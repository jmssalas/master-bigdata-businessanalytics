DROP TABLE comments;
CREATE EXTERNAL TABLE comments (info STRING);

LOAD DATA LOCAL INPATH '/home/bigdata/git/master-bigdata-businessanalytics/06-bigdata-infraestructure/02-hadoop-tools/02-hive/02-complex-structures/comments.json' OVERWRITE INTO TABLE comments;

SELECT * FROM comments;
SELECT GET_JSON_OBJECT(comments.info, '$.idBlog') FROM comments;
SELECT GET_JSON_OBJECT(c.info, '$.contact.email') FROM comments C;

SELECT 
	b.idBlog, 
	c.email
FROM
	comments a
LATERAL VIEW JSON_TUPLE(a.info, 'idBlog', 'contact') b AS idBlog, contact
LATERAL VIEW JSON_TUPLE(b.contact, 'email', 'tlfn') c AS email, tlfn

WHERE
	b.idBlog = '75584'
; 