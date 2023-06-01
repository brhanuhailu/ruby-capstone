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
    author_id INT REFERENCES author(id),
    published_date DATE,
    publisher TEXT,
    archived BOOLEAN NOT NULL DEFAULT FALSE,
    cover_state VARCHAR(5),
    label_id INT REFERENCES label(id)
);

-- create game table
CREATE TABLE game (
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    published_date DATE,
    multiplayer BOOLEAN NOT NULL DEFAULT FALSE,
    last_played_at DATE,
    author_id int REFERENCES author(id),
);

-- create author table
CREATE TABLE author (
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
);

-- create genre table
CREATE TABLE Genre(
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(60) NOT NULL
);

-- create item table

CREATE TABLE item(
 id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
 genre_id INT,
 author_id INT,
 label_id INT,
 publish_date Date,
 archived BOOLEAN,
 FOREIGN KEY(genre_id) REFERENCES Genre(id) ON UPDATE CASCADE,
 FOREIGN KEY(author_id) REFERENCES Author(id) ON UPDATE CASCADE,
 FOREIGN KEY(label_id) REFERENCES Label(id) ON UPDATE CASCADE
);

-- create music_album table
CREATE TABLE MusicAlbum(
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  on_spotify BOOLEAN NOT NULL,
  FOREIGN KEY(id) REFERENCES item(id) ON UPDATE CASCADE
);