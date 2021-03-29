/* 1 */
INSERT INTO	sellers
	(first_name, last_name, email, location, phone_number)
VALUES
	('Raymond', 'Duval', 'rduval@gmail.com', 'Ceyrat', '0655206895')
    
/* 2 */
INSERT INTO models (id, brand_id, category_id, label, description) VALUES
(
 	NULL,
    (SELECT id FROM brands WHERE label = 'Peugeot'),
    (SELECT id FROM categories WHERE label = 'Citadine'),
    '206',
    'Lorem Ipsum'
)

/* 3 */
INSERT INTO listings (seller_id, model_id, title, mileage, price, publish_at) 
VALUES (
	(SELECT id FROM sellers WHERE email = 'rduval1@gmail.com' AND sellers.phone_number = '0655206895'),
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

/* 4 */
SELECT	brands.label,
		models.label,
		categories.label,
		listings.produce_year,
		listings.price,
        DATE_FORMAT(listings.publish_at, "%d/%m/%Y-%h:%m:%s") AS 'Date de publication',
		CONCAT(UPPER(sellers.last_name), ' ', sellers.first_name) AS 'Nom vendeur',
		sellers.first_name AS "Nom vendeur",
		sellers.location

FROM listings

JOIN sellers ON listings.seller_id = sellers.id
JOIN models ON listings.model_id = models.id
JOIN brands ON models.brand_id = brands.id
JOIN categories ON models.category_id = categories.id

/* 5*/
SELECT	brands.label,
		models.label,
		categories.label,
		listings.produce_year,
		listings.price,
        DATE_FORMAT(listings.publish_at, "%d/%m/%Y%h%m%s") AS 'Date de publication',
		CONCAT(UPPER(sellers.last_name), ' ', sellers.first_name) AS 'Nom vendeur',
		sellers.first_name AS "Nom vendeur",
		sellers.location

FROM listings

JOIN sellers ON listings.seller_id = sellers.id
JOIN models ON listings.model_id = models.id
JOIN brands ON models.brand_id = brands.id
JOIN categories ON models.category_id = categories.id

ORDER BY
	listings.publish_at DESC

LIMIT 20

/* 6 */
SELECT
	brands.label AS "Marque",
    COUNT(listings.id) AS "Nombre de ventes"
FROM
	listings
	
LEFT JOIN models ON listings.model_id = models.id
LEFT JOIN brands ON models.brand_id = brands.id

GROUP BY models.brand_id

/* 7 */
SELECT
	brands.label AS 'Marque',
    models.label AS 'Modèle',
    categories.label AS 'Catégorie',
    listings.produce_year AS 'Année de production',
    listings.mileage AS 'Kilomètrage',
    listings.price AS 'Prix',
    listings.description AS 'Description du produit',
    DATE_FORMAT(listings.publish_at, '%d/%m/%Y - %H:%i:%s') AS 'Date de publication',
    CONCAT(UPPER(sellers.last_name), ' ', sellers.first_name) AS 'Nom vendeur',
    sellers.location AS 'Adresse'

FROM
	listings
	
LEFT JOIN models ON listings.model_id = models.id
LEFT JOIN sellers ON listings.seller_id = sellers.id
LEFT JOIN brands ON models.brand_id = brands.id
LEFT JOIN categories ON models.category_id = categories.id

WHERE
	brands.label = 'Renault'
    AND
    listings.mileage < 100000
    AND
    categories.label = 'Citadine'
	
ORDER BY
	listings.publish_at DESC
	
LIMIT 20


/* 8 */
SELECT
	brands.label AS 'Marque',
    models.label AS 'Modèle',
    categories.label AS 'Catégorie',
    listings.produce_year AS 'Année de production',
    listings.mileage AS 'Kilomètrage',
    listings.price AS 'Prix',
    listings.description AS 'Description du produit',
    DATE_FORMAT(listings.publish_at, '%d/%m/%Y - %H:%i:%s') AS 'Date de publication',
    CONCAT(UPPER(sellers.last_name), ' ', sellers.first_name) AS 'Nom vendeur',
    sellers.location AS 'Adresse'

FROM
	listings
	
LEFT JOIN models ON listings.model_id = models.id
LEFT JOIN sellers ON listings.seller_id = sellers.id
LEFT JOIN brands ON models.brand_id = brands.id
LEFT JOIN categories ON models.category_id = categories.id

WHERE
	brands.label = 'Renault'
AND
    listings.mileage < 100000
AND
    categories.label = 'Citadine'
AND
    listings.price BETWEEN 5000 AND 9000
	
ORDER BY
	listings.publish_at DESC

LIMIT 20

/* 9 */
SELECT
	DISTINCT sellers.email

FROM
	`listings`
    INNER JOIN sellers ON listings.seller_id = sellers.id

WHERE
	publish_at < NOW() - INTERVAL 12 MONTH

/* 10 */
SELECT
	AVG(listings.price) AS 'Prix moyen'

FROM
	listings

WHERE 
	listings.produce_year < YEAR(NOW() - INTERVAL 5 YEAR);
    
/* 11 */
SELECT
	brands.label AS "Marque",
    SUM(listings.price) AS "Prix total de ventes"

FROM
	listing

LEFT JOIN models ON listings.model_id = models.id
LEFT JOIN brands ON models.brand_id = brands.id

GROUP BY models.brand_id

/* 12 */
SELECT
	count(listings.id) AS 'Nb annonces',
    CONCAT(UPPER(sellers.last_name), ' ', sellers.first_name) AS 'Nom vendeur'
	
FROM
	listings
	
LEFT JOIN sellers ON listings.seller_id = sellers.id
	
GROUP BY listings.seller_id

ORDER BY
	listings.publish_at DESC






