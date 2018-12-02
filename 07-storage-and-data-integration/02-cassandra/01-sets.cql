CREATE KEYSPACE collections WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : '1' };
USE collections;

DROP TABLE books;
CREATE TABLE books(

title text,

editorial text,

collection text,

version text,

editions set<text>,

price decimal,

PRIMARY KEY((editorial, collection), version));

SELECT * FROM books;



/* COLLECTIONS */

/* Insert new collection */
INSERT INTO books (title, editorial, collection, version, editions, price) VALUES ('El Quijote', 'Alianza', 'Bolsillo', 'Papel', {'1984', '1990', '2005', '2007'}, 13.8);
SELECT * FROM books;

/* Add new elements into collection */
UPDATE books SET editions = editions + {'2010'} WHERE editorial = 'Alianza' AND collection = 'Bolsillo' AND version = 'Papel';
SELECT * FROM books;

/* Remove elements into collection */
UPDATE books SET editions = editions - {'2010'} WHERE editorial = 'Alianza' AND collection = 'Bolsillo' AND version = 'Papel';
SELECT * FROM books;

/* Remove all elements into collection */
UPDATE books SET editions = editions - {} WHERE editorial = 'Alianza' AND collection = 'Bolsillo' AND version = 'Papel';
SELECT * FROM books;
/* Also */
DELETE editions FROM books WHERE editorial = 'Alianza' AND collection = 'Bolsillo' AND version = 'Papel';
SELECT * FROM books;