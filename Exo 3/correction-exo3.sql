
/*

1/ Afficher :
- Le nom de l'album suivi d'un tiret puis son année de sortie sous le label 'Nom album'
- L'indice de l'album 'is_parental_advisory' sous le label 'Parent Advisory'
Suivi du :
- Nom des chansons de l'album sous le label 'Titre'
- La durée de la chanson sous le label 'Durée'

*/
SELECT 	CONCAT(album.name, ' - ', album.published_year) AS 'Nom album',
		IF(album.is_parental_advisory = 1, '(X)', '') AS 'Parent Advisory',
        song.name AS 'Titre',
        song.duration AS 'Durée'
        
FROM	album

JOIN	album_song
ON		album_song.album_id = album.id
JOIN	song
ON		album_song.song_id = song.id;


/*

2/ Afficher :
- Tous les albums de 'Rock' et ses variantes

*/
SELECT 	album.*,
		GROUP_CONCAT(genre.name)
        
FROM	album

JOIN	album_genre
ON		album_genre.album_id = album.id

JOIN	genre
ON 		album_genre.genre_id = genre.id

WHERE 	genre.name LIKE '%Rock%'

GROUP BY 	album.id;

/*

3/ Afficher :
- Le nom de l'album le plus ancien de la discographie

*/
SELECT 	*

FROM 	album

ORDER BY published_year ASC

LIMIT 0, 1;


/*

4/ Afficher :
- Le nom de l'artiste le plus ancien

*/
SELECT	artist.*

FROM	artist

WHERE begining_year IS NOT NULL

ORDER BY artist.begining_year ASC

LIMIT 0, 1;

/*

5/ Afficher :
- Tous les albums ayant un parental advisory à false

*/
SELECT 	*
        
FROM	album

WHERE 	album.is_parental_advisory = 0

ORDER BY album.published_year;


/*

6/ Afficher :
- Tous les genres d'un artiste (en une seule colonne)

*/
SELECT 	artist.name AS 'Nom artiste',
		artist.begining_year AS 'Date de début',
        GROUP_CONCAT(genre.name) AS 'Genre(s)'
        
FROM	artist

JOIN	artist_genre
ON		artist_genre.artist_id = artist.id

JOIN	genre
ON		artist_genre.genre_id = genre.id

GROUP BY artist.id

ORDER BY artist.begining_year;


/*

7/ Afficher :
- Tous les artistes référencés, mais n'ayant pas d'album en vente

*/
SELECT * 

FROM artist

WHERE artist.id NOT IN (
	SELECT	album_artist.artist_id
    FROM album_artist
)

ORDER BY name;


/*

8/ Afficher :
- Le nombre d'artistes par nationalité

*/
SELECT 	COUNT(artist.id) AS 'Nb artiste',
		artist.nationality
        
FROM	artist

GROUP BY artist.nationality


/*

9/ Afficher :
- Le nombre d'album par artiste

*/
SELECT	artist.name,
		COUNT(album_artist.album_id)

FROM 	artist

JOIN	album_artist
ON		album_artist.artist_id = artist.id

GROUP BY artist.id;


/*

10/ Afficher :
- Le nombre de chanson par album, s'il y en a 

*/
SELECT	album.name,
		COUNT(album_song.song_id)
        
FROM 	album

LEFT JOIN	album_song
ON			album_song.album_id = album.id

GROUP BY 	album.id;


/*

11/ Afficher :
- Le nom du genre
- Le nombre d'artistes pour ce genre
- Le nombre d'album pour ce genre

*/
/*
	NB artist
*/
SELECT	genre.name,
		COUNT(artist.id)

FROM 	genre

JOIN	artist_genre
ON		artist_genre.genre_id = genre.id
JOIN	artist
ON		artist.id = artist_genre.artist_id

GROUP BY	genre.id;

/*
	NB genre
*/
SELECT	genre.name,
		COUNT(album.id)

FROM 	genre

JOIN	album_genre
ON		album_genre.genre_id = genre.id
JOIN	album
ON		album.id = album_genre.album_id

GROUP BY	genre.id;

/* Solution optimale */
SELECT
    genre.id,
    genre.name,
    count(DISTINCT album.name) AS 'Count Album(s)',
    GROUP_CONCAT(DISTINCT album.name SEPARATOR ', ') AS 'Album(s)',
    count(DISTINCT artist.name) AS 'Count Artiste(s)',
    GROUP_CONCAT(DISTINCT artist.name SEPARATOR ', ') AS 'Artiste(s)'
    
FROM genre

LEFT JOIN album_genre
ON album_genre.genre_id = genre.id

LEFT JOIN album
ON album_genre.album_id = album.id

LEFT JOIN artist_genre
ON artist_genre.genre_id = genre.id

LEFT JOIN artist
ON artist_genre.artist_id = artist.id

GROUP BY genre.name  
ORDER BY `genre`.`name`  ASC;

/*

12/ Afficher :
- Le nom des albums
- Le prix de l'album
- Par album, afficher aussi le prix total des chansons de celui-ci (s'il existe) (POUR TOUS LES ALBUMS)

*/
SELECT	album.name,
		album.price,
        ROUND(SUM(song.price), 2) AS 'Total prix chansons'

FROM 	album

LEFT JOIN	album_song
ON		album.id = album_song.album_id
LEFT JOIN	song
ON		song.id = album_song.song_id

GROUP BY album.id


/*

13/ Afficher par album les artistes ayant participer à celui-ci

*/
SELECT	album.name,
		GROUP_CONCAT(artist.name)
  
FROM 	album

JOIN album_artist
ON album.id = album_artist.album_id

JOIN artist
ON artist.id = album_artist.artist_id

GROUP BY album.id;


/*

14/ Afficher :
- Le nombre de chansons par album
- Le nom de l'album

Et pour TOUS les albums, j'insiste sur le TOUS

*/
SELECT 	album.name,
		COUNT(album_song.song_id) AS 'Nb_chansons'

FROM album

LEFT JOIN album_song
ON album.id = album_song.album_id

GROUP BY album.id

ORDER BY album.name;


/*

15/ Afficher :
- Le nom de l'album
- Sa date de sortie
- Sa durée au format 00:00:00

*/
SELECT 	album.name AS 'Nom album',
		album.published_year AS 'Date de sortie',
		IF(album.is_parental_advisory = 1, '(X)', '') AS 'Parent Advisory',
        SEC_TO_TIME(SUM(TIME_TO_SEC(song.duration))) AS 'Durée album'
        
FROM	album

JOIN	album_song
ON		album_song.album_id = album.id
JOIN	song
ON		album_song.song_id = song.id

GROUP BY album.id





