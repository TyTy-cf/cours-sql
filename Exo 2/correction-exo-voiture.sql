/**
1/ Ajouter un nouveau 'sellers' ayant ces informations :
Raymond Duval, d'email rduval@gmail.com, habitant à Ceyrat et ayant un numéro le numéro de téléphone 0655206895
*/
INSERT INTO	sellers
	(first_name, last_name, email, location, phone_number)
VALUES
	('Raymond', 'Duval', 'rduval@gmail.com', 'Ceyrat', '0655206895')
    
/* 
2/ Ajouter un nouveau modèle de voiture (via sous-requête)
Une Peugeot 206 Citadine
*/
INSERT INTO models (id, brand_id, category_id, label, description) VALUES
(
 	NULL,
    (SELECT id FROM brands WHERE label = 'Peugeot'),
    (SELECT id FROM categories WHERE label = 'Citadine'),
    '206',
    'Lorem Ipsum'
)

/*
3/ Raymond Duval souhaite vendre sa Peugeot 206 Citadine, ajoutez son offre aux ventes (via sous-requête)
- La description (title) doit être : Vente de Peugeot 206 pas cher
- Le prix doit être : 5000
- La vente doit être affiché à la date actuelle
- La voiture (mileage) a 95000km

*/
INSERT INTO listings (seller_id, model_id, title, mileage, price, publish_at) 
VALUES (
	(SELECT id FROM sellers WHERE email = 'rduval@gmail.com' AND sellers.phone_number = '0655206895'),
    (
        SELECT models.id 
        FROM models
        JOIN categories
        ON models.category_id = categories.id
        WHERE models.label = '206'
        AND categories.label = 'Citadine'
    ), 
    'Vente de Peugeot 206 pas cher',
    95000,
    5000,
    NOW()
);

/*
4/ Afficher Une liste des  ventes :
On affichera que les informations suivantes :
- Le label de la marque (brands)
- Le label du modèle (models)
- La label de la catégorie (categories)
- L'année de production du véhicule
- Le prix du véhicule
- La description du produit
- La date de publication de la vente au format JJ/MM/AAAA - HH:mm:ss
- Le nom en majuscule et le prénom du vendeur sous le label "Nom vendeur"
- L''email du vendeur
- L'adresse du vendeur

(NB : il s'agit d'une requete courante pour l'affichage des données dans un tableau sur un site de vente)
*/
/* Solution avec select sur plusieurs tables & conditions */
SELECT 	brands.label,
		models.label,
        categories.label,
        listings.produce_year,
        listings.description,
        listings.price,
        DATE_FORMAT(listings.publish_at, "%d/%m/%Y %h:%m:%s") AS 'Date de publication',
        CONCAT(UPPER(sellers.last_name), ' ', sellers.first_name) AS 'Nom vendeur',
        sellers.email,
        sellers.location
        
FROM	listings, sellers, brands, models, categories

WHERE 	listings.seller_id = sellers.id
AND		brands.id = models.brand_id
AND		categories.id = models.category_id
AND		listings.model_id = models.id;
      
/*
4bis/ Solution avec le JOIN
*/	  
SELECT 	brands.label,
		models.label,
        categories.label,
        listings.produce_year,
        listings.description,
        listings.price,
        DATE_FORMAT(listings.publish_at, "%d/%m/%Y %h:%m:%s") AS 'Date de publication',
        CONCAT(UPPER(sellers.last_name), ' ', sellers.first_name) AS 'Nom vendeur',
        sellers.email,
        sellers.location
        
FROM	listings

JOIN sellers ON listings.seller_id = sellers.id
JOIN models ON listings.model_id = models.id
JOIN brands ON models.brand_id = brands.id
JOIN categories ON models.category_id = categories.id;

/*
5/ Même question mais cette fois je ne veux que les 20 dernières ventes

(NB : le limit est utile pour la pagination des tables)
*/
SELECT 	brands.label,
		models.label,
        categories.label,
        listings.produce_year,
        listings.description,
        listings.price,
        DATE_FORMAT(listings.publish_at, "%d/%m/%Y %h:%m:%s") AS 'Date de publication',
        CONCAT(UPPER(sellers.last_name), ' ', sellers.first_name) AS 'Nom vendeur',
        sellers.email,
        sellers.location
        
FROM	listings

JOIN sellers ON listings.seller_id = sellers.id
JOIN models ON listings.model_id = models.id
JOIN brands ON models.brand_id = brands.id
JOIN categories ON models.category_id = categories.id

ORDER BY listings.publish_at DESC

LIMIT 20;

/*
6/ Même question qu'à la 4, sauf que l'on veut : 
- les 20 dernières annonces
- pour des renault
- de type Citadine
- ayant moins de 100000km
*/
SELECT 	brands.label,
		models.label,
        categories.label,
        listings.produce_year,
        listings.mileage,
        listings.description,
        listings.price,
        DATE_FORMAT(listings.publish_at, "%d/%m/%Y %h:%m:%s") AS 'Date de publication',
        CONCAT(UPPER(sellers.last_name), ' ', sellers.first_name) AS 'Nom vendeur',
        sellers.email,
        sellers.location
        
FROM	listings

JOIN sellers ON listings.seller_id = sellers.id
JOIN models ON listings.model_id = models.id
JOIN brands ON models.brand_id = brands.id
JOIN categories ON models.category_id = categories.id

WHERE
	listings.mileage < 100000
    AND
    brands.label = 'Renault'
    AND
    categories.label = 'Citadine'    

ORDER BY
	listings.publish_at DESC
	
LIMIT 20

/*
7/ Même question qu'à la 7, sauf qu'il y a une limite de prix comprise entre 5000 et 9000€
*/
SELECT 	brands.label,
		models.label,
        categories.label,
        listings.produce_year,
        listings.mileage,
        listings.description,
        listings.price,
        DATE_FORMAT(listings.publish_at, "%d/%m/%Y %h:%m:%s") AS 'Date de publication',
        CONCAT(UPPER(sellers.last_name), ' ', sellers.first_name) AS 'Nom vendeur',
        sellers.email,
        sellers.location
        
FROM	listings

JOIN sellers ON listings.seller_id = sellers.id
JOIN models ON listings.model_id = models.id
JOIN brands ON models.brand_id = brands.id
JOIN categories ON models.category_id = categories.id

WHERE
	listings.mileage < 100000
AND
    brands.label = 'Renault'
AND
    categories.label = 'Citadine'
AND
	listings.price BETWEEN 5000 AND 9000

ORDER BY
	listings.publish_at DESC
	
LIMIT 20

/*
8/ Afficher les emails des vendeurs ayant passé des anonces au cours des 12 derniers mois
*/
SELECT  DISTINCT(sellers.email)

FROM	listings
JOIN	sellers
ON 		listings.seller_id = sellers.id

WHERE 	listings.publish_at < NOW() - INTERVAL 12 MONTH

/*
9/ Prix moyen des ventes sur les 5 dernières années
*/
SELECT AVG(price), COUNT(*), YEAR(publish_at)
FROM listing
GROUP BY YEAR(publish_at)

/*
10/ Chiffre affaire par marque de voiture
*/
SELECT	brands.label,
		SUM(listings.price)
        
FROM 	listings
JOIN 	models
ON 		listings.model_id = models.id
JOIN	brands
ON		brands.id = models.brand_id

GROUP BY brands.id

/*
11/ Avec comparaison du CA total

(NB: il est préférable de faire le GROUP BY sur l'id de la marque)
*/
SELECT	brands.label,
		SUM(listings.price),
        (SELECT SUM(listings.price) FROM listings) AS 'CA total'
        
FROM 	listings
JOIN 	models
ON 		listings.model_id = models.id
JOIN	brands
ON		brands.id = models.brand_id

GROUP BY brands.id

/*
12/ Afficher le nombre d'annonces par vendeurs, en affichant le nom en majuscule et le prénom du vendeur sous le label "Nom vendeur"
*/
SELECT	COUNT(listings.id) AS 'Nb annonces',
    	CONCAT(UPPER(sellers.last_name), ' - ', sellers.first_name) AS 'Nom vendeur'

FROM	sellers
JOIN	listings
ON		listings.seller_id = sellers.id

GROUP BY sellers.id

ORDER BY COUNT(listings.id);



/* 
 * 13 Afficher les informations du modele de voiture le plus vendu
*/
SELECT COUNT(id), listing.model_id
FROM listing
GROUP BY listing.model_id
ORDER BY COUNT(id) DESC
LIMIT 1





















