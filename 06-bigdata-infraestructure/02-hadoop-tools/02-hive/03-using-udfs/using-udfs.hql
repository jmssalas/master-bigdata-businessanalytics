add jar /home/bigdata/git/master-bigdata-businessanalytics/06-bigdata-infraestructure/02-hadoop-tools/02-hive/03-using-udfs/Lower.jar;

DROP TABLE lowerExample;
CREATE TABLE lowerExample (string String);
INSERT INTO lowerExample values ('STRING1'), ('String2');

CREATE TEMPORARY FUNCTION my_lower AS 'com.example.hive.udf.Lower';

SELECT my_lower(string), string 
FROM lowerExample;
