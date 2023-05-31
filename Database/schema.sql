-- create catalog of my things database
CREATE DATABASE catalog;

-- create label table

CREATE TABLE label (
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    color VARCHAR(100) NOT NULL
);
