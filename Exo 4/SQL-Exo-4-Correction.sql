
-- 1/ 
-- Afficher le contenu de la table Hero 
SELECT *

FROM hero

-- 2/
-- Ajouter un nouvel Héro

INSERT INTO hero (`name`, `hp_max`, `mana_max`, `level`, `attack_min`, `attack_max`, `defense`, `ability_resistance`)
VALUES ("Vengeful Spirit", 1720, 711, 25, 132, 140, 19, 25);

-- 3/
--  Créer deux nouvelles Ability

INSERT INTO `ability`(`name`, `mana_cost`, `damage_min`, `damage_max`, `is_ulti`)
VALUES ("Magic Missile", 130, 360, 360, 0);

INSERT INTO `ability`(`name`, `mana_cost`, `damage_min`, `damage_max`, `is_ulti`)
VALUES ("Wave of Terror", 40, 120, 120, 0);

-- 4/
-- Ajouter la relation hero_ability :
-- Vengeful Spirit a Magic Missile
-- Vengeful Spirit a Wave of Terror

INSERT INTO hero_ability
VALUES (
	null,
    (SELECT id FROM hero WHERE name = 'Vengeful Spirit'),
    (SELECT id FROM ability WHERE name = 'Magic Missile')
);

INSERT INTO hero_ability
VALUES (
	null,
    (SELECT id FROM hero WHERE name = 'Vengeful Spirit'),
    (SELECT id FROM ability WHERE name = 'Wave of Terror')
);


-- 5/
-- Afficher le détail d'un hero avec son/ses ability liées, par exemple :
-- Nom hero | ses stats | Nom ability | ability stats

-- Solution plusieurs lignes

SELECT 	*

FROM	hero

JOIN 	hero_ability
ON	hero_ability.hero_id = hero.id

JOIN 	ability
ON 	hero_ability.ability_id = ability.id;

-- Solution une seule ligne

SELECT 	hero.*,
		GROUP_CONCAT(ability.name)	

FROM	hero

JOIN 	hero_ability
ON	hero_ability.hero_id = hero.id

JOIN 	ability
ON 	hero_ability.ability_id = ability.id

GROUP BY hero.id;

-- 6/
--  Afficher les hero n'ayant jamais participé à une game.

SELECT name, hero.id

FROM hero

WHERE hero.id NOT IN (
    SELECT hero_id
    FROM participe
);

-- 8/  Afficher le récapitulatif d'une game :
-- Nom partie | Nom Team | Nom hero | Stats hero (kill/death/assistance) | 'V' si son équipe a gagné ou
-- 'P' sinon

SELECT game.name AS 'Nom partie',
       team.name AS 'Nom Team',
       hero.name AS 'Nom hero',
       CONCAT(participe.nb_kill, ' / ',  participe.nb_death, ' / ',  participe.nb_assistance) AS 'Stats hero (kill/death/assistance)',
       IF(team.id = game.team_victory_id, 'V', 'P') AS 'Result'
       
FROM game

JOIN participe
ON participe.game_id = game.id

JOIN team
ON participe.team_id = team.id 

JOIN hero
ON participe.hero_id = hero.id

ORDER BY game.name;