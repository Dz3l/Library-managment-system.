-- Create Database for Library Management System
CREATE DATABASE IF NOT EXISTS LibraryManagement;
USE LibraryManagement;

-- Create Table for Categories
-- Stores book categories/genres
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE,
    Description TEXT
);

-- Create Table for Authors
-- Stores author information
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    BirthDate DATE
);

-- Create Table for Books
-- Stores book information, linked to a category
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    ISBN VARCHAR(13) NOT NULL UNIQUE,
    PublicationYear INT,
    CategoryID INT NOT NULL,
    TotalCopies INT NOT NULL DEFAULT 1,
    AvailableCopies INT NOT NULL DEFAULT 1,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    CONSTRAINT chk_copies CHECK (AvailableCopies <= TotalCopies)
);

-- Create Table for Book_Authors (Many-to-Many relationship)
-- Links books to their authors
CREATE TABLE Book_Authors (
    BookID INT,
    AuthorID INT,
    PRIMARY KEY (BookID, AuthorID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

-- Create Table for Members
-- Stores library member information
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15),
    JoinDate DATE NOT NULL DEFAULT CURDATE(),
    Address VARCHAR(200)
);

-- Create Table for Loans
-- Tracks book loans to members
CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT NOT NULL,
    MemberID INT NOT NULL,
    LoanDate DATE NOT NULL DEFAULT CURDATE(),
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    CONSTRAINT chk_dates CHECK (DueDate >= LoanDate)
);

-- Insert Sample Data for Categories
INSERT INTO Categories (CategoryName, Description) VALUES
('Fiction', 'Fictional literature'),
('Non-Fiction', 'Factual and informational books'),
('Science Fiction', 'Speculative fiction with futuristic themes');

-- Insert Sample Data for Authors
INSERT INTO Authors (FirstName, LastName, Email, BirthDate) VALUES
('J.K.', 'Rowling', 'jkrowling@example.com', '1965-07-31'),
('Isaac', 'Asimov', 'asimov@example.com', '1920-01-02');

-- Insert Sample Data for Books
INSERT INTO Books (Title, ISBN, PublicationYear, CategoryID, TotalCopies, AvailableCopies) VALUES
('Harry Potter and the Philosopher''s Stone', '9780747532699', 1997, 1, 5, 3),
('Foundation', '9780553293357', 1951, 3, 3, 2);

-- Insert Sample Data for Book_Authors
INSERT INTO Book_Authors (BookID, AuthorID) VALUES
(1, 1),
(2, 2);

-- Insert Sample Data for Members
INSERT INTO Members (FirstName, LastName, Email, Phone, Address) VALUES
('John', 'Doe', 'john.doe@example.com', '555-0123', '123 Main St'),
('Jane', 'Smith', 'jane.smith@example.com', '555-0124', '456 Oak Ave');

-- Insert Sample Data for Loans
INSERT INTO Loans (BookID, MemberID, LoanDate, DueDate) VALUES
(1, 1, '2025-05-01', '2025-05-15'),
(2, 2, '2025-05-02', '2025-05-16');