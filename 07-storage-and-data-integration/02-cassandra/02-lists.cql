CREATE KEYSPACE lists WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : '1' };
USE lists;

DROP TABLE exams;
CREATE TABLE exams (

id uuid,

name text,

surnames text,

califications list<int>,

PRIMARY KEY (id, name));

SELECT * FROM exams;


/* LISTS */

/* Insert new lists */
INSERT INTO exams (id, name, surnames, califications ) VALUES ( aa71ab3b-f9bb-4918-89f1-5c7579347773, 'Felipe', 'Suárez Sanz', [10, 9, 5]);
SELECT * FROM exams;

/* Add elements into list in the last position */
UPDATE exams SET califications = califications + [0, 1, 1] WHERE id = aa71ab3b-f9bb-4918-89f1-5c7579347773 AND name = 'Felipe';
SELECT * FROM exams;

/* Add elements into list in the first position */
UPDATE exams SET califications = [0] + califications WHERE id = aa71ab3b-f9bb-4918-89f1-5c7579347773 AND name = 'Felipe';
SELECT * FROM exams;

/* Update individual elements into list */
UPDATE exams SET califications[0] = 4 WHERE id = aa71ab3b-f9bb-4918-89f1-5c7579347773 AND name = 'Felipe';
SELECT * FROM exams;

/* Remove all data of a element into the list */
UPDATE exams SET califications = califications - [1] WHERE id = aa71ab3b-f9bb-4918-89f1-5c7579347773 AND name = 'Felipe';
SELECT * FROM exams;