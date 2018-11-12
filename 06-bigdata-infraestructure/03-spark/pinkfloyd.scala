/* Load Pink Floyd Data */
val data = spark.read.json("/spark/pink-floyd.json")

/* Show data */
data.show()
data.printSchema()

/* Create View */
data.createOrReplaceTempView("pinkfloyd")

/* Get disks which were in the first five in a both rankings */
val res = spark.sql("SELECT * FROM pinkfloyd WHERE USA_Ranking < 5 AND UK_Ranking < 5")
res.show()

/* Get maximun and minimum position in USA and UK */
val usa = spark.sql("SELECT MAX(USA_Ranking), MIN(USA_Ranking) FROM pinkfloyd")
usa.show()
val uk = spark.sql("SELECT MAX(UK_Ranking), MIN(UK_Ranking) FROM pinkfloyd")
uk.show()

/* Get disk's titles in uppercase */
data.select(upper(data("Title"))).show()