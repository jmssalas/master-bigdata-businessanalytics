CREATE KEYSPACE udts WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : '1' };
USE udts;

/* Create UDT */
DROP TABLE votation;
CREATE TYPE votation (
	scala decimal,
	current_value decimal,
	amount_of_votes int
);

/* Create Table with UDT (use frozen to indicate that field is a UDT) */
CREATE TABLE votations (
	model text,
	version text,
	price text,
	users_votations frozen<votation>,
PRIMARY KEY ((model, version)));

/* Insert into column family */
INSERT INTO votations (model, version, price, users_votations) VALUES ('Iphone', '7', '500', {scala:10, current_value:9, amount_of_votes:20});
SELECT * FROM votations;