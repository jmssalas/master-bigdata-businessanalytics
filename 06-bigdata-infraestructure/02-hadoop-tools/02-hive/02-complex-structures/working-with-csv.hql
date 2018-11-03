DROP TABLE debt2012;
CREATE TABLE debt2012 (
	cod_comunidad STRING, 
	cod_prov STRING, 
	cod_municipio STRING, 
	municipio STRING, 
	deuda INT
) 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\;'
;

LOAD DATA LOCAL INPATH '/home/bigdata/git/master-bigdata-businessanalytics/06-bigdata-infraestructure/02-hadoop-tools/02-hive/02-complex-structures/deuda2012.csv' INTO TABLE debt2012;

SELECT * FROM debt2012;

SELECT * 
FROM debt2012
WHERE municipio LIKE 'Madri%';
