CREATE TABLE public."Corruption_New" AS 

SELECT 
	c."CustomerId", 
	c."Country", 
	i."BillingAddress", 
	il."Quantity", 
	m."Name" AS "MediaType", 
	t."Name" AS "Track", 
	al."Title", 
	a."Name" AS "Artist", 
	g."Name" AS "Genre"
FROM "Customer" c
JOIN "Invoice" i ON c."CustomerId" = i."CustomerId"
JOIN "InvoiceLine" il ON i."InvoiceId" = il."InvoiceId"
JOIN "Track" t ON il."TrackId" = t."TrackId"
JOIN "MediaType" m ON t."MediaTypeId" = m."MediaTypeId"
JOIN "Genre" g ON t."GenreId" = g."GenreId"
JOIN "Album" al ON t."AlbumId" = al."AlbumId"
JOIN "Artist" a ON al."ArtistId" = a."ArtistId";

SELECT * FROM "Corruption_New";

SELECT COUNT(DISTINCT "MediaType")
FROM "Corruption_New";

SELECT "MediaType", COUNT(*) AS count
FROM "Corruption_New"
GROUP BY "MediaType"
ORDER BY count DESC;


SELECT "Country", COUNT(*) AS count
FROM "Corruption_New"
GROUP BY "Country"
ORDER BY count DESC;

SELECT "Country", COUNT(*) AS count, "Genre"
FROM "Corruption_New"
GROUP BY "Country", "Genre"
ORDER BY "Country" DESC;

SELECT "Track", COUNT("Track") AS count, "Artist"
FROM "Corruption_New"
GROUP BY "Track", "Artist"
ORDER BY "Artist" DESC;



