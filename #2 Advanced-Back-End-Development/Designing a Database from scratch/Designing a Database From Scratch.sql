-- Create the Books table
CREATE TABLE Books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(13) UNIQUE NOT NULL,
    publication_year INT
);

-- Create the Authors table
CREATE TABLE Authors (
    author_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    birthdate DATE
);

-- Create the Members table
CREATE TABLE Members (
    member_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

-- Create the Loans table
CREATE TABLE Loans (
    loan_id SERIAL PRIMARY KEY,
    book_id INT REFERENCES Books(book_id),
    member_id INT REFERENCES Members(member_id),
    loan_date DATE NOT NULL,
    return_date DATE
);

-- Create the Categories table
CREATE TABLE Categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(255) UNIQUE NOT NULL
);

-- Create the BookAuthors junction table
CREATE TABLE BookAuthors (
    book_id INT REFERENCES Books(book_id),
    author_id INT REFERENCES Authors(author_id),
    PRIMARY KEY (book_id, author_id)
);

-- Create the BookCategories junction table
CREATE TABLE BookCategories (
    book_id INT REFERENCES Books(book_id),
    category_id INT REFERENCES Categories(category_id),
    PRIMARY KEY (book_id, category_id)
);

-- Insert data into Books
INSERT INTO Books (title, isbn, publication_year) VALUES
('The Great Gatsby', '9780743273565', 1925),
('To Kill a Mockingbird', '9780061120084', 1960);

-- Insert data into Authors
INSERT INTO Authors (name, birthdate) VALUES
('F. Scott Fitzgerald', '1896-09-24'),
('Harper Lee', '1926-04-28');

-- Insert data into Members
INSERT INTO Members (name, email) VALUES
('John Doe', 'john.doe@example.com'),
('Jane Smith', 'jane.smith@example.com');

-- Insert data into Loans
INSERT INTO Loans (book_id, member_id, loan_date, return_date) VALUES
(1, 1, '2023-07-01', '2023-07-15'),
(2, 2, '2023-07-10', NULL);

-- Insert data into Categories
INSERT INTO Categories (category_name) VALUES
('Fiction'),
('Classics');

-- Insert data into BookAuthors
INSERT INTO BookAuthors (book_id, author_id) VALUES
(1, 1),
(2, 2);

-- Insert data into BookCategories
INSERT INTO BookCategories (book_id, category_id) VALUES
(1, 1),
(1, 2),
(2, 1);

ALTER TABLE Loans ADD COLUMN due_date DATE;

-- Update existing loans to include a due date
UPDATE Loans SET due_date = '2023-07-20' WHERE loan_id = 1;
UPDATE Loans SET due_date = '2023-07-24' WHERE loan_id = 2;
