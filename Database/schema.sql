-- create catalog of my things database
CREATE DATABASE catalog;

-- create label table

CREATE TABLE label (
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    color VARCHAR(100) NOT NULL
);

-- create book table
CREATE TABLE book (
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    author TEXT,
    published_date DATE,
    publisher TEXT,
    archived BOOLEAN NOT NULL DEFAULT FALSE,
    cover_state VARCHAR(5),
    label_id int REFERENCES label(id),
    genre TEXT
);

