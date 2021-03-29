
CREATE DATABASE IF NOT EXISTS music_shop;
USE music_shop;

CREATE TABLE song (
    id INT(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    duration TIME NOT NULL,
    price FLOAT(2) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE album (
    id int(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
	published_year INT(4) NOT NULL,
	is_parental_advisory INT(1) NOT NULL,
	price FLOAT(2) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE genre (
    id int(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE artist (
    id INT(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    nationality VARCHAR(255) NOT NULL,
    begining_year INT(4) NULL,
    PRIMARY KEY (id)
);

CREATE TABLE album_song (
    id INT(11) NOT NULL AUTO_INCREMENT,
    album_id INT(11) NOT NULL,
    song_id INT(11) NOT NULL,
    PRIMARY KEY (id),
	FOREIGN KEY (album_id) REFERENCES album(id),
	FOREIGN KEY (song_id) REFERENCES song(id)
);

CREATE TABLE album_genre (
    id INT(11) NOT NULL AUTO_INCREMENT,
    album_id INT(11) NOT NULL,
    genre_id INT(11) NOT NULL,
    PRIMARY KEY (id),
	FOREIGN KEY (album_id) REFERENCES album(id),
	FOREIGN KEY (genre_id) REFERENCES genre(id)
);

CREATE TABLE artist_genre (
    id INT(11) NOT NULL AUTO_INCREMENT,
    artist_id INT(11) NOT NULL,
    genre_id INT(11) NOT NULL,
    PRIMARY KEY (id),
	FOREIGN KEY (artist_id) REFERENCES artist(id),
	FOREIGN KEY (genre_id) REFERENCES genre(id)
);

CREATE TABLE album_artist (
    id int(11) NOT NULL AUTO_INCREMENT,
	artist_id INT(11) NOT NULL,
	album_id INT(11) NOT NULL,
    PRIMARY KEY (id),
	FOREIGN KEY (album_id) REFERENCES album(id),
	FOREIGN KEY (artist_id) REFERENCES artist(id)
);

