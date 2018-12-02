CREATE KEYSPACE maps WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : '1' };
USE maps;

DROP TABLE subject_average;
CREATE TABLE subject_average ( 

id uuid, 
kind_of_evaluation text, 
group text static, 
subject text static, 
average map<text, int>, 

PRIMARY KEY (id, kind_of_evaluation) ) ;

SELECT * FROM subject_average;


/* MAPS */

/* Insert new maps */
INSERT INTO subject_average (id, kind_of_evaluation , group , subject , average ) VALUES ( 9b02528d-75af-41d9-866e-75d189f57118, 'Continua', 'A', 'Álgebra', { 'Pepe': 9, 'Isabel': 7, 'Maria': 278});
INSERT INTO subject_average (id, kind_of_evaluation ,group , subject , average ) VALUES ( 9b02528d-75af-41d9-866e-75d189f57118, 'Parciales', 'A', 'Álgebra', { 'Pepe': 1, 'Isabel': 7, 'Maria': 6}) ;
SELECT * FROM subject_average;


/* Add elements into maps */
UPDATE subject_average SET average = average + {'Héctor': 6, 'Javier': 7} WHERE id = 9b02528d-75af-41d9-866e-75d189f57118 AND kind_of_evaluation = 'Continua';
SELECT * FROM subject_average;

/* Update individual elements into map */
UPDATE subject_average SET average['Maria']= 9, average['Javier'] = 5 WHERE id = 9b02528d-75af-41d9-866e-75d189f57118 AND kind_of_evaluation = 'Continua';
SELECT * FROM subject_average;

/* Remove a element into the map */
DELETE average['Maria'], average['Isabel'] FROM subject_average WHERE id = 9b02528d-75af-41d9-866e-75d189f57118 AND kind_of_evaluation = 'Continua';
SELECT * FROM subject_average;