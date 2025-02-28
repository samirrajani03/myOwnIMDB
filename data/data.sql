CREATE TABLE MotionPicture (
    id INT,
    name VARCHAR(255),
    rating FLOAT CHECK (rating >= 0 AND rating <= 10),
    production VARCHAR(255),
    budget INT CHECK (budget > 0),
    PRIMARY KEY (id)
);

CREATE TABLE Users (
    email VARCHAR(255),
    name VARCHAR(255),
    age INT,
    PRIMARY KEY (email)
);

CREATE TABLE Likes (
    mpid INT,
    uemail VARCHAR(255),
    PRIMARY KEY (mpid, uemail),
    FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE,
    FOREIGN KEY (uemail) REFERENCES Users(email) ON DELETE CASCADE
);

CREATE TABLE Movie (
    mpid INT,
    boxoffice_collection FLOAT CHECK (boxoffice_collection >= 0),
    PRIMARY KEY (mpid),
    FOREIGN KEY (mpid) REFERENCES MotionPicture(id)
    ON DELETE CASCADE
);

CREATE TABLE Series (
    mpid INT,
    season_count INT CHECK (season_count >= 1),
    PRIMARY KEY (mpid),
    FOREIGN KEY (mpid) REFERENCES MotionPicture(id)
    ON DELETE CASCADE
);

CREATE TABLE People (
    id INT,
    name VARCHAR(255),
    nationality VARCHAR(255),
    dob DATE,
    gender VARCHAR(1),
    PRIMARY KEY (id)
);

CREATE TABLE Role (
    mpid INT,
    pid INT,
    role_name VARCHAR(255),
    PRIMARY KEY (mpid, pid, role_name),
    FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE,
    FOREIGN KEY (pid) REFERENCES People(id) ON DELETE CASCADE
);

CREATE TABLE Award (
    mpid INT,
    pid INT,
    award_name VARCHAR(255),
    award_year INT,
    PRIMARY KEY (mpid, pid, award_name, award_year),
    FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE,
    FOREIGN KEY (pid) REFERENCES People(id) ON DELETE CASCADE
);

CREATE TABLE Genre (
    mpid INT,
    genre_name VARCHAR(255),
    PRIMARY KEY (mpid, genre_name),
    FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE
);

CREATE TABLE Location (
    mpid INT,
    zip INT,
    city VARCHAR(255),
    country VARCHAR(255),
    PRIMARY KEY (mpid, zip),
    FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE
);

INSERT INTO MotionPicture (id, NAME, rating, production, budget) VALUES
(101, 'Breaking Bad', 9.1, 'High Bridge Productions', 195000000),
(102, 'Band of Brothers', 9.5, 'DreamWorks', 125000000),
(103, 'Game of Thrones', 8.9, 'HBO', 480000000),
(104, 'Rick and Morty', 8.2, 'Green Portal Productions', 52000000),
(201, 'Iron Man', 9, 'Marvel', 200000000),
(202, 'Daredevil', 2, 'Marvel', 50000000),
(203, 'Doctor Strange', 8, 'Marvel', 300000000),
(204, 'Batman vs Superman', 3, 'Warner Bros', 300000000);

INSERT INTO Users (email, NAME, age) VALUES
('aneesha@fb.com', 'Aman Aneesh', 25),
('ssarkar@bu.edu', 'Simone Sarkar', 23),
('jamiel@gmail.com', 'Jamie Vardy', 29),
('wasaya@yahoo.com', 'Wasay Ahmeed', 41);

INSERT INTO Likes (mpid, uemail) VALUES
(101, 'aneesha@fb.com'),
(201, 'aneesha@fb.com'),
(104, 'aneesha@fb.com'),
(203, 'ssarkar@bu.edu'),
(101, 'ssarkar@bu.edu'),
(101, 'jamiel@gmail.com');

INSERT INTO Movie (mpid, boxoffice_collection) VALUES
(201, 500000000),
(202, 60000000),
(203, 300000000),
(204, 200000000);

INSERT INTO Series (mpid, season_count) VALUES
(101, 5),
(102, 1),
(103, 8),
(104, 5);

INSERT INTO People (id, NAME, nationality, dob, gender) VALUES
(1, 'Brian Cranston', 'USA', '1956-12-12', 'M'),
(2, 'Aaron Paul', 'USA', '1982-01-12', 'M'),
(3, 'Vince Gillian', 'USA', '1976-03-03', 'M'),
(4, 'Melissa Burns', 'USA', '1986-04-21', 'F'),
(5, 'Robert Downey Jr.', 'USA', '1970-08-17', 'M'),
(6, 'Jon Favreau', 'France', '1960-10-10', 'M'),
(7, 'Gwyneth Paltrow', 'USA', '1980-11-30', 'F'),
(8, 'Benedict Cumberbatch', 'USA', '1980-05-03', 'M'),
(9, 'Keanu Reaves', 'USA', '1978-03-22', 'M'),
(10, 'Ben Affleck', 'USA', '1965-02-11', 'M'),
(11, 'Henry Cavill', 'France', '1970-10-26', 'M'),
(12, 'Christian Bale', 'France', '1971-01-05', 'M'),
(13, 'Morgan Freeman', 'France', '1972-08-11', 'M'),
(14, 'Gerard Butler', 'France', '1973-09-21', 'M'),
(15, 'Aaron Eckhart', 'France', '1973-11-26', 'M'),
(16, 'Michael Nyqvist', 'France', '1974-10-22', 'M'),
(17, 'Chad Stahelski', 'Germany', '1975-08-29', 'M'),
(18, 'Babak Najafi', 'Germany', '1976-02-20', 'M'),
(19, 'The Wachowskis', 'Germany', '1977-04-26', 'M'),
(20, 'Carrie-Anne Moss', 'Germany', '1978-06-21', 'M'),
(30, 'Zack Snyder', 'Canada', '1983-06-06', 'M'),
(32, 'Amy Adams', 'USA', '1985-08-30', 'F'),
(33, 'Gal Gadot', 'USA', '1986-01-29', 'F'),
(34, 'Deborah Snyder', 'UK', '1987-08-17', 'F');

INSERT INTO Role (mpid, pid, role_name) VALUES
(201, 5, 'Actor'),
(201, 6, 'Actor'),
(201, 6, 'Director'),
(201, 7, 'Producer'),
(202, 10, 'Actor'),
(202, 6, 'Actor'),
(203, 8, 'Actor'),
(204, 10, 'Actor'),
(204, 11, 'Actor'),
(204, 30, 'Director'),
(204, 34, 'Producer'),
(204, 32, 'Actor'),
(204, 33, 'Actor');

INSERT INTO Award (mpid, pid, award_name, award_year) VALUES
(201, 5, 'Best Director', 2009),
(201, 5, 'Best Actor', 2010);

INSERT INTO Genre (mpid, genre_name) VALUES
(101, 'Crime'),
(101, 'Drama'),
(101, 'Thriller'),
(201, 'Sci-fi'),
(201, 'Action'),
(102, 'Action'),
(102, 'History'),
(102, 'War'),
(103, 'Action'),
(103, 'Adventure'),
(103, 'Drama'),
(103, 'Fantasy'),
(104, 'Animation'),
(104, 'Adventure'),
(104, 'Comedy'),
(104, 'Sci-Fi'),
(202, 'Scifi'),
(202, 'Thriller'),
(202, 'Action'),
(202, 'Fantasy'),
(203, 'Action'),
(203, 'Sci-fi'),
(203, 'Fantasy'),
(203, 'Thriller'),
(204, 'Action'),
(204, 'Sci-fi'),
(204, 'Fantasy'),
(204, 'Thriller');

INSERT INTO Location (mpid, zip, city, country) VALUES
(101, 02135, 'Boston', 'USA'),
(101, 02134, 'Boston', 'USA'),
(201, 99999, 'San Jose', 'USA'),
(201, 460005, 'Bangalore', 'India'),
(201, 23489, 'Paris', 'France'),
(201, 02135, 'Boston', 'USA'),
(202, 11111, 'Seattle', 'USA'),
(203, 201014, 'Delhi', 'India'),
(204, 7245893, 'Singapore', 'Singapore');