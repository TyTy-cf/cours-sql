
/** 1 **/
-- Afficher le nom de famille et le prénom de tous les étudiants
SELECT
	`nom` AS 'Nom',
	`prenom` AS 'Prénom'
FROM
	`etudiant`

    
/** 2 **/
-- Afficher les étudiants M de moins de 160cm ou les F de plus de 160 

SELECT *

FROM etudiant

WHERE taille < 160 AND sexe = 'M'
OR sexe = 'F' AND taille > 160

ORDER BY taille ASC
    
    
/** 3 **/
-- Afficher la taille minimum parmi tous les étudiants
SELECT MIN(`taille`) 
FROM `etudiant`;

SELECT taille
FROM `etudiant`
ORDER BY taille ASC
LIMIT 1


/** 4 **/
-- Afficher la moyenne de la taille pour les hommes (M)
SELECT AVG(taille), sexe
FROM `etudiant`
WHERE sexe = 'M'


/** 5 **/
-- Afficher le nombre d'étudiants par sexe
SELECT COUNT(*), sexe 
FROM etudiant 
GROUP BY sexe


/** 6 **/
-- Même question que la 5
-- mais pour les étudiants M de moins de 160cm ou les F de plus de 160  
SELECT COUNT(*), sexe 
FROM etudiant
WHERE (
    sexe = 'M' and taille < 160
) OR (
    sexe = 'F' and taille > 160
)
GROUP BY sexe


/** 7 **/
-- Afficher le nombre d'étudiants par taille, et uniquement celles ayant plus d'un étudiant
SELECT taille, COUNT(taille) AS NbTaille
FROM etudiant
GROUP BY taille
HAVING NbTaille >= 2
ORDER BY taille ASC;


/** 8 **/
-- Afficher les étudiants ayant une taille comprise entre 170 et 190cm
SELECT *

FROM etudiant

WHERE taille BETWEEN 170 AND 190

ORDER BY taille ASC;


/** 9 **/
-- Afficher les étudiants faisant exactement 160, 170, 180 et 190cm
SELECT *
FROM `etudiant`
WHERE taille IN (160, 170, 180, 190);

-- Equivaut à la même chose que ça, en plus long
SELECT * 
FROM `etudiants` 
WHERE taille = 160 OR taille = 170 OR taille = 180 OR taille = 190;
