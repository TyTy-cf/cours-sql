
-- Quelques questions de rappels dans un premier temps...

-- 0.1/ Faire une requête pour supprimer les doublons de la table libraries (paire game_id et account_id)


-- 0.2/ Faire une requête pour afficher le nombre d'upvotes et de downvotes par jeux


-- 0.3/ Faire une requête pour afficher les langages par jeux (dans une seule colonne)


-- 0.4/ Faire une requête pour afficher les utilisateurs qui ont mis des commentaires à des jeux non présents dans leur bibliothèque


-- 0.5/ AFficher les commentaires ayant un downvote supérieur à son upvote


-- 0.6/ Afficher les jeux dont leur total de downvote est supérieur au total d'upvotes


-- 0.7/ Afficher le jeu ayant le plus de downvote


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


-- 2/ Afficher les informations des comptes, avec les jeux qu'ils peuvent se payer (en une seule colonne) avec leur solde actuel


-- 3/ Créer un trigger qui vérifit si la valeur de wallet saisit est inférieure à 0, si oui, on la met à 0


-- 4/ Vérifiez votre Trigger avec notre ApexeurFou de la dernière fois
-- Name : Apexeurfoudu63 
-- Email : asmenforce@hotmail.fr
-- Nickname : Apexeurfoudu63
-- wallet : une valeur négative quelconque


-- 5/ Ajouter une colonne 'closed' sur la table accounts, après l'id
-- (En ligne de commande bien sûr)


-- 6/ Sur le même principe que le trigger du 2/ faire un trigger qui permet de gérer la même chose en UPDATE
-- Sauf que l'on va ajouter le fait que si le compte va être fermé (closed = 1) alors on met le solde de son compte à 0


-- 7/ Le tester avec un UPDATE sur les accounts ayant un email en '@russel.com'


-- 8/ Faire un trigger sur l'UPDATE de libraries qui modifira en plus last_used à la date du jour si game_time a augmenté


-- 9/ Tester le trigger sur le compte de 'haley.cleve', avec le jeu Skyrim, et augmenter son temps de jeu de 1800.


----------------------------------------------------------- SUITE -------------------------------------------------------------------------


-- 10/ Ajouter une gestion d'erreur lorsqu'un utilisateur essaie d'acheter un jeu et que son solde est inférieur au prix du jeu
-- (Vous n'avez pas plus d'informations, à vous de mettre en place votre logique ici)


-- 11/ Tester dans une transaction votre trigger 
-- (je vous laisse réfléchir à la manière de procéder, je vous dit juste qu'il y a 2 requêtes à passer) 


-- 12/ Mettez à jour votre trigger pour que si le trigger ne passe pas dans le message d'erreur, on débite la wallet de l'account
-- du montant du prix du jeu


-- 13/ Dans le même procédé, faire un TRIGGER pour que lors de la création d'un compte, on vérifit qu'il n'existe pas déjà
-- sinon on renvoit une erreur (name, et email doivent être unique)


----------------------------------------------------- SUITE - J2 --------------------------------------------------------------------------


-- 14/ Faire une requête préchargée qui permet de récupérer pour un genre donné, tous les jeux qui lui sont liés
-- Exécuter cette requête et vérifier son bon fonctionnement avec FPS et MMO


-- 15/ Faire une fonction permettant pour un id d'account et un id de game, de savoir si le propriétaire du compte peut 
-- acheter le jeu ou non
-- Tester votre fonction avec plusieurs cas de figure (une personne pouvant acheter et une, non)


-- 16/ Faire une function qui pour un id de game et un boolean (isUpvote), permet de retourner tout les upvote qu'il a reçu
-- ou les downvote (table comment)


-- 17/ Ecrire une procédure qui permet de récupérer les jeux achetables pour un idAccount donné


-- 18/ Modifier la fonction de la 15 pour que si le jeu ne passe pas dans l'erreur, on ajoute la ligne dans la table avec les champs
-- game_time à 0
-- last_used à null
-- installed à 1






