
-- Quelques questions de rappels dans un premier temps...


-- 0.5/ Faire une requête pour supprimer les doublons de la table libraries (paire game_id et account_id)
-- Delete doublons
DELETE FROM libraries
WHERE libraries.id IN (SELECT libraries.id
FROM libraries
GROUP BY libraries.game_id, libraries.account_id
HAVING COUNT(*) > 1)


-- 1/ Créer un nouvel utilisateur à notre plateforme de jeux préféré :
-- name : DarksasukeXx63xXx
-- email : thedarksasuke63@hotmail.fr
-- nickname : sasuke63xXx
-- wallet : 0

-- Toutefois, il faut bien compliqué un peu les choses...
-- Ce brave sasuke63xXx veut créditer le solde de son compte, après l'avoir créer
-- Je veux qu'il y ai une transaction qui effectue :
-- Ajout du compte
-- Modification du compte pour le créditer de 42€

START TRANSACTION;

INSERT INTO accounts VALUES (null, 'DarksasukeXx63xXx', 'thedarksasuke63@hotmail.fr', 'sasuke63xXx', 0);

UPDATE accounts
SET wallet = 42
WHERE name = 'DarksasukeXx63xXx';

COMMIT;

-- 2/ Afficher les informations des comptes, avec les jeux qu'ils peuvent se payer (en une seule colonne) avec leur solde actuel
SELECT accounts.*, GROUP_CONCAT(games.name)
FROM accounts, games
WHERE accounts.wallet > games.price
GROUP BY accounts.id

-- 3/ Créer un trigger qui vérifit si la valeur de wallet saisit est inférieure à 0, alors on la met à 0
DELIMITER |
CREATE TRIGGER before_insert_account BEFORE INSERT
ON accounts FOR EACH ROW
BEGIN
    IF NEW.wallet < 0 THEN
    	SET NEW.wallet = 0;
    END IF;
END |
DELIMITER ;

-- 4/ Vérifiez votre Trigger en updatant notre DarksasukeXx63xXx
-- Name : DarksasukeXx63xXx 
-- Email : thedarksasuke63@hotmail.fr
-- Nickname : sasuke63xXx
-- wallet : une valeur négative quelconque


-- 5/ Ajouter une colonne 'closed' sur la table accounts, après l'id
-- (En ligne de commande bien sûr)
ALTER TABLE accounts 
ADD COLUMN closed TINYINT(1) DEFAULT 0
AFTER id ;

-- 6/ Sur le même principe que le trigger du 2/ faire un trigger qui permet de gérer la même chose en UPDATE
-- Sauf que l'on va ajouter le fait que si le compte va être fermé (closed = 1) alors on met le solde de son compte à 0
DELIMITER |
CREATE TRIGGER before_update_account BEFORE UPDATE
ON accounts FOR EACH ROW
BEGIN
    IF NEW.closed = 1 THEN
    	SET NEW.wallet = 0;
    END IF;
END |
DELIMITER ;

-- 7/ Le tester avec un UPDATE sur les accounts ayant un email en '@russel.com'
UPDATE accounts
SET closed = 1
WHERE email LIKE '%@russel.com';

-- 8/ Faire un trigger sur l'UPDATE de libraries qui modifira en plus last_used à la date du jour si game_time a augmenté
DELIMITER |
CREATE TRIGGER modify_time_update BEFORE UPDATE
ON libraries FOR EACH ROW
BEGIN
    IF OLD.game_time < NEW.game_time THEN
        SET NEW.last_used = NOW();
    END IF;
END |
DELIMITER ;


-- 9/ Tester le trigger sur le compte de 'haley.cleve', avec le jeu Skyrim, et augmenter son temps de jeu de 1800.
SET AUTOCOMMIT = 0;

SET @idAccount = (
    SELECT id
    FROM accounts
    WHERE accounts.name LIKE 'haley.cleve'
);

SET @idGame = (
    SELECT id
    FROM games
    WHERE games.name LIKE 'The Elder Scrolls V : Skyrim'
);

START TRANSACTION;

UPDATE libraries
SET libraries.game_time = libraries.game_time + 18000
WHERE libraries.account_id = @idAccount
AND libraries.game_id = @idGame;

COMMIT;


-------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------- SUITE -----------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------


-- 10/ Ajouter une gestion d'erreur lorsqu'un utilisateur essaie d'acheter un jeu et que son solde est inférieur au prix du jeu
-- (Vous n'avez pas plus d'informations, à vous de mettre en place votre logique ici)
-- 12/ Mettez à jour votre trigger pour que si le trigger ne passe pas dans le message d'erreur, on débite la wallet de l'account
-- du montant du prix du jeu


DELIMITER |
CREATE TRIGGER libraries_before_insert BEFORE INSERT
ON libraries FOR EACH ROW
BEGIN
	SET @gamePrice = (SELECT games.price FROM games WHERE games.id = NEW.game_id);
	SET @accountWallet = (SELECT accounts.wallet FROM accounts WHERE accounts.id = NEW.account_id);
    IF @gamePrice > @accountWallet
    THEN
    	INSERT INTO errors VALUES (1, 'Le solde de l''utilisateur ne permet pas d''acheter ce jeu');
	ELSE
		UPDATE accounts
		SET accounts.wallet = @accountWallet - @gamePrice
		WHERE accounts.id = NEW.account_id;
    END IF;	
END |
DELIMITER ;


-- 11/ Tester dans une transaction votre trigger 
-- (je vous laisse réfléchir à la manière de procéder, je vous dit juste qu'il y a 2 requêtes à passer) 
SET AUTOCOMMIT = 0;

START TRANSACTION;

-- Exemple qui ne fonctionne pas
INSERT INTO libraries VALUES (null, 18, 1, 0, 0, null); 

-- Exemple qui fonctionne -- A REGARDER
INSERT INTO libraries VALUES (null, 89, 1, 0, 0, null);

COMMIT;


-- 13/ Dans le même procédé, faire un TRIGGER pour que lors de la création d'un compte, on vérifit qu'il n'existe pas déjà, sinon on renvoit une erreur
DELIMITER |
CREATE TRIGGER accounts_before_insert BEFORE INSERT
ON accounts FOR EACH ROW
BEGIN
    IF NEW.name IN (SELECT DISTINCT accounts.name FROM accounts)
    THEN
    	INSERT INTO errors VALUES (2, 'il existe déjà un user avec ce nom');
    END IF;
    IF NEW.email IN (SELECT DISTINCT accounts.email FROM accounts)
    THEN
    	INSERT INTO errors VALUES (3, 'il existe déjà un user avec cet email');
    END IF;
END |
DELIMITER ;


-- SUITE - J2------ -----------------------------------------------------------------------------------------------------------------------


-- 14/ Faire une requête préchargée qui permet de récupérer pour un genre donné, tous les jeux qui lui sont liés
-- Exécuter cette requête et vérifier son bon fonctionnement avec FPS et MMO
PREPARE select_games_by_genre
FROM "SELECT games.name, genres.name FROM games JOIN games_genres ON games_genres.games_id = games.id JOIN genres ON games_genres.genres_id = genres.id WHERE genres.name = ?";

EXECUTE select_games_by_genre USING 'FPS';
EXECUTE select_games_by_genre USING 'MMO';


-- 15/ Faire une fonction permettant pour un id d'account et un id de game, de savoir si le propriétaire du compte peut 
-- acheter le jeu, sinon > Erreur
-- Tester votre fonction avec plusieurs cas de figure (une personne pouvant acheter et une, non)
DELIMITER //
CREATE FUNCTION can_buy_game ( accountId INT, gameId INT )
RETURNS TINYINT
BEGIN
	SET @return_value = 0;
    SET @gamePrice = (SELECT games.price FROM games WHERE games.id = gameId);
	SET @accountWallet = (SELECT accounts.wallet FROM accounts WHERE accounts.id = accountId);
   	IF @accountWallet >= @gamePrice THEN
     	SET @return_value = 1;
    END IF;
    RETURN @return_value;
END //
DELIMITER ;

-- Celui-là ne peut pas
SELECT can_buy_game (18, 1) AS 'Peut acheter ?';

-- Celui-là peut
SELECT can_buy_game (89, 1) AS 'Peut acheter ?';


-- 16/ Faire une function qui pour un id de game et un boolean (isUpvote), permet de retourner tout les upvote qu'il a reçu
-- ou les downvote (table comment)
DELIMITER //
CREATE FUNCTION getVotesByGame (gameId INT, isUpVote TINYINT)
RETURNS INT
BEGIN
	SET @sumVotes = (SELECT SUM(comments.up_votes) FROM comments WHERE comments.game_id = gameId);
    IF !isUpVote THEN
    	SET @sumVotes = (SELECT SUM(comments.down_votes) FROM comments WHERE comments.game_id = gameId);
    END IF;
    RETURN @sumVotes;
END //
DELIMITER ;

SELECT getVotesByGame (1, 1) AS 'Up vote';
SELECT getVotesByGame (1, 0) AS 'Down vote';


-- 17 Ecrire une procédure qui permet de récupérer les jeux achetable pour un idAccount donné
DELIMITER //
DROP PROCEDURE IF EXISTS getBuyableGames //
CREATE PROCEDURE 
  getBuyableGames( idAccount INT )
BEGIN
	SELECT *
    FROM games
    WHERE games.price <= (SELECT wallet FROM accounts WHERE accounts.id = idAccount)
    ORDER BY games.price;
END //
DELIMITER  ;

CALL getBuyableGames(21);
CALL getBuyableGames(7);
CALL getBuyableGames(18);
CALL getBuyableGames(89);



