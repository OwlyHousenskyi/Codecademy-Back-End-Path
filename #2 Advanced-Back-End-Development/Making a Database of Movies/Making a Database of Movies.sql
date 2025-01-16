-- Drop the table if it exists
DROP TABLE IF EXISTS films;

-- Create the table
CREATE TABLE films (
  name TEXT UNIQUE,
  release_year INTEGER
);

-- Insert data into the table
INSERT INTO films (name, release_year)
VALUES 
  ('The Matrix', 1999),
  ('Monsters Inc.', 2001),
  ('Call Me By Your Name', 2017);

-- Select all rows
SELECT * FROM films;

-- Select rows where release_year is 1999
SELECT * FROM films WHERE release_year = 1999;

-- Add new columns
ALTER TABLE films
ADD COLUMN runtime INTEGER,
ADD COLUMN category TEXT,
ADD COLUMN rating REAL,
ADD COLUMN box_office_earnings BIGINT;

-- Update existing rows with new data
UPDATE films
SET runtime = 136, category = 'Action', rating = 8.7, box_office_earnings = 463517383
WHERE name = 'The Matrix';

UPDATE films
SET runtime = 92, category = 'Animation', rating = 8.1, box_office_earnings = 577425017
WHERE name = 'Monsters Inc.';

UPDATE films
SET runtime = 132, category = 'Drama', rating = 8.3, box_office_earnings = 4171984
WHERE name = 'Call Me By Your Name';

-- Add a unique constraint to the name column
ALTER TABLE films
ADD CONSTRAINT unique_name UNIQUE (name);
