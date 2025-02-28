from typing import Any, AnyStr, Optional, Tuple

import pymysql as sqldb
import app.config as config


def get_db_connection() -> sqldb.Connection:
    """Establish and return a database connection."""
    return sqldb.connect(
        user=config.DB_USER,
        password=config.DB_PASSWORD,
        host=config.DB_HOST,
        database=config.DB_DATABASE,
    )


class Database:
    """Context manager class for managing database connections."""

    def __enter__(self) -> "Database":
        """Open a database connection when entering the context."""
        try:
            self.conn: sqldb.Connection = get_db_connection()
            self.cursor: sqldb.cursors.Cursor = self.conn.cursor()
            return self
        except sqldb.Error as e:
            raise RuntimeError(f"Database connection failed: {e}")

    def execute(
        self,
        query: AnyStr,
        params: Optional[Tuple[Any, ...]] = None,
        fetch_one: bool = False,
        commit: bool = False,
    ) -> Optional[Any]:
        """Execute an SQL query safely within the database context.

        Parameters
        ----------
        query : str
            The SQL query to execute.
        params : Optional[Tuple[Any, ...]], default=None
            A tuple containing the parameters to be substituted into the SQL query.
            If no parameters are required, this defaults to None.
        fetch_one : bool, default=False
            If True, returns only a single result instead of all matching results.
        commit : bool, default=False
            If True, commits the transaction. Used for INSERT, UPDATE, and DELETE queries.

        Returns
        -------
        Optional[Any]
            - If the query is a SELECT statement:
                - Returns a tuple containing all results if `fetch_one=False`.
                - Returns a single row if `fetch_one=True`.
            - If the query is an INSERT, UPDATE, or DELETE statement:
                - Returns None after committing the transaction.
            - If an error occurs:
                - Rolls back the transaction and raises `RuntimeError`.

        Raises
        ------
        RuntimeError
            If the SQL query execution fails, the function raises a `RuntimeError`
            after rolling back the transaction.

        Examples
        --------
        Fetching multiple rows:
            >>> with Database() as db:
            ...     results = db.execute("SELECT name, rating FROM MotionPicture WHERE rating > %s", (8.0,))

        Fetching a single row:
            >>> with Database() as db:
            ...     movie = db.execute("SELECT name FROM MotionPicture WHERE id = %s", (1,), fetch_one=True)

        Inserting data:
            >>> with Database() as db:
            ...     db.execute("INSERT INTO Users (email, name, age) VALUES (%s, %s, %s)", 
            ...                 ("johndoe@example.com", "John Doe", 30), commit=True)
        """

        try:
            self.cursor.execute(query, params or ())
            if commit:
                self.conn.commit()
            return self.cursor.fetchone() if fetch_one else self.cursor.fetchall()
        except sqldb.Error as e:
            self.conn.rollback()
            raise RuntimeError(f"Database query failed: {e}")

    def __exit__(self, exc_type, exc_value, traceback):
        """Ensure that the connection is closed when exiting the context."""
        if self.conn:
            self.conn.close()
