DROP TABLE docs;
CREATE TABLE docs (line STRING);

LOAD DATA LOCAL INPATH '/home/bigdata/git/master-bigdata-businessanalytics/06-bigdata-infraestructure/02-hadoop-tools/02-hive/01-first-steps-hive/data1' INTO TABLE docs; 
LOAD DATA LOCAL INPATH '/home/bigdata/git/master-bigdata-businessanalytics/06-bigdata-infraestructure/02-hadoop-tools/02-hive/01-first-steps-hive/data2' INTO TABLE docs; 

SELECT * FROM docs;

DROP TABLE word_count;
CREATE TABLE word_count AS (
	SELECT 
		word, 
		count(1) AS count 
	FROM 
		( 	SELECT EXPLODE(SPLIT(line, ' ')) AS word 
			FROM docs	) A
	GROUP BY word
	ORDER BY word
);

SELECT * FROM word_count;