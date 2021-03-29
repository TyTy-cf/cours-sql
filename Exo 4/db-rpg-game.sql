
CREATE DATABASE IF NOT EXISTS rpg_games;
USE rpg_games;

DROP TABLE IF EXISTS ability;
CREATE TABLE ability (
    id int(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
	mana_cost INT NOT NULL,
	damage_min INT NOT NULL,
	damage_max INT NOT NULL,
	is_ulti TINYINT(1) NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS team;
CREATE TABLE team (
    id INT(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS map;
CREATE TABLE map (
    id INT(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    height INT NOT NULL,
    width INT NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS hero;
CREATE TABLE hero (
    id INT(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    hp_max INT NOT NULL,
    mana_max INT NOT NULL,
    level INT NOT NULL,
    attack_min INT NOT NULL,
    attack_max INT NOT NULL,
    defense INT NOT NULL,
    ability_resistance INT NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS hero_ability;
CREATE TABLE hero_ability (
    id INT(11) NOT NULL AUTO_INCREMENT,
    hero_id INT NOT NULL,
    ability_id INT NOT NULL,
    PRIMARY KEY (id),
	FOREIGN KEY (hero_id) REFERENCES hero(id),
	FOREIGN KEY (ability_id) REFERENCES ability(id)
);

DROP TABLE IF EXISTS game;
CREATE TABLE game (
    id INT(11) NOT NULL AUTO_INCREMENT,
	map_id INT NOT NULL,
	team_victory_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    played_on DATETIME NOT NULL,
	duration INT NULL,
    PRIMARY KEY (id),
	FOREIGN KEY (map_id) REFERENCES map(id),
	FOREIGN KEY (team_victory_id) REFERENCES team(id)
);

DROP TABLE IF EXISTS participe;
CREATE TABLE participe (
    id int(11) NOT NULL AUTO_INCREMENT,
	nb_kill INT NOT NULL,
	nb_death INT NOT NULL,
	nb_assistance INT NOT NULL,
	hero_id INT NOT NULL,
	game_id INT NOT NULL,
    team_id INT NOT NULL,
    PRIMARY KEY (id),
	FOREIGN KEY (hero_id) REFERENCES hero(id),
	FOREIGN KEY (game_id) REFERENCES game(id),
	FOREIGN KEY (team_id) REFERENCES team(id)
);


