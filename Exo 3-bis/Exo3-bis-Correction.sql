
-- 1/ Ajouter un nouveau compte avec ces informations : 
INSERT INTO account VALUES (
	null, -- pour l'id
	'Apexeurfoudu63',
	'asmenforce@hotmail.fr',
	'Apexeurfoudu63'
);


-- 2/ Ajouter à la librairie de ce joueur (par un SELECT, quand c’est nécessaire)
INSERT INTO librarie VALUES (
	null, -- pour l'id
	(
		SELECT games.id
		FROM games
		WHERE games.name = 'Apex la Légende'
	), -- game_id
	(
		SELECT account.id
		FROM account
		WHERE account.name = 'Apexeurfoudu63'
	), -- account_id
	1, -- installed
	4242, -- game_time
	'2021-02-18 23:42:17' -- last_used > une date est ajoutée sous forme de
	-- chaine de caractères, AAAA-MM-DD HH:MM:SS
);


-- 3/ Faire une requête permettant d'afficher tout le contenu de la librarie d'un compte,
-- les données seront affichées sous cette forme : 

SELECT
	account.nickname AS 'Joueur',
	games.name AS 'Jeu',
	IF(librarie.installed = 1, 'Oui', 'Non') AS "Installé O/N",
	SEC_TO_TIME(librarie.game_time) AS 'Temps passé',
	librarie.last_used AS "Dernière utilisation"
	
FROM
	librarie
	
JOIN account
ON librarie.account_id = account.id
JOIN games
ON librarie.game_id = games.id;


-- 4/ Afficher les jeux (table : games) avec leur différents genres respectifs, cependant je veux une ligne par
-- jeux et les différents genres en une seule colonne, que vous renommerez "Genre(s)". 
SELECT
	games.name,
    games.published_at,
    games.price,
    GROUP_CONCAT(genre.name SEPARATOR ', ')

FROM `games` 

JOIN games_genre
ON games_genre.games_id = games.id
JOIN genre
ON games_genre.genre_id = genre.id

GROUP BY games.id


-- 5/ En reprenant la requête de la question 4, afficher le jeu le plus cher 
SELECT
	games.name,
    games.published_at,
    games.price,
    GROUP_CONCAT(genre.name)

FROM `games` 

JOIN games_genre
ON games_genre.games_id = games.id
JOIN genre
ON games_genre.genre_id = genre.id

GROUP BY games.id

ORDER BY games.price DESC

LIMIT 1


-- 6/ En reprenant la requête de la question 4, afficher uniquement les jeux ayant au moins le style FPS 
SELECT
	games.name,
    games.published_at,
    games.price,
    GROUP_CONCAT(genre.name)

FROM `games` 

JOIN games_genre
ON games_genre.games_id = games.id
JOIN genre
ON games_genre.genre_id = genre.id

WHERE genre.name = 'FPS'

GROUP BY games.id

-- Solution pour tout afficher
SELECT 	g.name AS "Jeux",
		GROUP_CONCAT(gen.name) AS "Genre(s)" 

FROM `games`AS g

INNER JOIN games_genre as gg ON gg.games_id = g.id
INNER JOIN genre as gen ON gen.id = gg.genre_id

GROUP BY g.name

HAVING GROUP_CONCAT(gen.name) LIKE "%FPS%"

ORDER BY g.price DESC;


-- 7/ Affichez le temps de jeu total par nom de compte  
SELECT
	account.name,
    SEC_TO_TIME(SUM(librarie.game_time))

FROM `librarie`

JOIN account
ON librarie.account_id = account.id

GROUP BY account.id

ORDER BY SUM(librarie.game_time) DESC


-- 8/ Reprendre la question 3, et n'afficher cette fois que les jeux installés
SELECT
	account.nickname AS 'Joueur',
	games.name AS 'Jeu',
	IF(librarie.installed = 1, 'Oui', 'Non') AS "Installé O/N",
	SEC_TO_TIME(librarie.game_time) AS 'Temps passé',
	librarie.last_used AS "Dernière utilisation"
	
FROM
	librarie
	
JOIN account
ON librarie.account_id = account.id
JOIN games
ON librarie.game_id = games.id

WHERE librarie.installed = 1;

-- 9/ Afficher la valeur (somme du prix des jeux) de la bibliothèque (librarie)
-- d'un compte (account)
SELECT
	account.name AS 'Nom compte',
    CONCAT(SUM(games.price), '€') AS 'Valeur blibli'
    
FROM
	librarie
    
JOIN account ON account.id = librarie.account_id
JOIN games ON games.id = librarie.game_id

GROUP BY account.id

ORDER BY SUM(games.price) DESC


-- 10/ Afficher les nicknames utilisés plusieurs fois
SELECT  COUNT(account.nickname),
		account.name

FROM `account` 

GROUP BY account.id  

HAVING COUNT(account.nickname) > 1

ORDER BY `account`.`name`  ASC

-- 11/ Afficher par jeux, le nombre de fois où il a été acheté 
SELECT
	COUNT(librarie.game_id) 'nb_jeux',
    games.name

FROM `librarie` 

JOIN games
ON games.id = librarie.game_id

GROUP BY games.id

ORDER BY nb_jeux DESC


-- 12/ Afficher par jeux, son revenu total à son éditeur
SELECT
	games.name,
    CONCAT(COUNT(librarie.game_id) * games.price, '€') AS 'Valeur ventes totales'
    
FROM
	librarie
    
JOIN games ON games.id = librarie.game_id

GROUP BY games.id

ORDER BY (COUNT(librarie.game_id) * games.price) DESC;

-- Ou
SELECT
	games.name,
	CONCAT(SUM(g.price), " €") AS "Revenu a l'editeur"
	
FROM games

JOIN librarie
ON librarie.game_id = games.id

GROUP BY games.id;


-- 13/ Afficher par genre, son nombre de fois où il a été vendu 
SELECT COUNT(librarie.game_id), genre.name

FROM games

JOIN librarie
ON librarie.game_id = games.id

JOIN games_genre
ON games_genre.games_id = games.id

JOIN genre
ON genre.id = games_genre.genre_id

GROUP bY games_genre.genre_id

ORDER BY COUNT(librarie.game_id) DESC;


-- 14/  Afficher le top 3 des jeux les plus vendu 
SELECT 	COUNT(librarie.game_id),
		games.name

FROM games

JOIN librarie
ON librarie.game_id = games.id

GROUP bY games.id

ORDER BY COUNT(librarie.game_id) DESC

LIMIT 3;


-- 15/ Afficher le top 3 des jeux les plus joués
SELECT 	SUM(librarie.game_time),
		games.name

FROM games

JOIN librarie
ON librarie.game_id = games.id

GROUP bY games.id

ORDER BY SUM(librarie.game_time) DESC

LIMIT 3;


-- 16/ Afficher les différents jeux par année, sous une même colonne 
SELECT	
    GROUP_CONCAT(games.name) AS 'Jeux',
    YEAR(published_at) AS 'Année de sortie'

FROM
	games

GROUP BY YEAR(published_at);


-- 17/ Le jeu le plus anciens 
SELECT	
    GROUP_CONCAT(games.name) AS 'Jeux',
    YEAR(published_at) AS 'Année de sortie'

FROM
	games
	
GROUP BY YEAR(published_at)

ORDER BY YEAR(published_at) ASC

LIMIT 1;

-- Plus précis
SELECT	
    games.name AS 'Jeu',
    published_at AS 'Année de sortie'

FROM
	games

ORDER BY published_at ASC

LIMIT 1;

-- Delete doublons
DELETE FROM libraries
WHERE libraries.id IN (SELECT libraries.id
FROM libraries
GROUP BY libraries.game_id, libraries.account_id
HAVING COUNT(*) > 1)