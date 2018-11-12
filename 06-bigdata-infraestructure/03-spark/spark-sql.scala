/* Load Data */
val df = spark.read.json("/spark/geniuses.json")

/* Show data */
df.show()

/* Show schema */
df.printSchema()

/* Several selects */
df.select("nombre").show()

df.select(df("nombre"), upper(df("apellido"))).show()


/* Several filter */
df.filter(df("apellido") > "J").show()

df.filter(df("apellido") startsWith("P")).show()


/* Creating view */
df.createOrReplaceTempView("geniuses")
val res = spark.sql("SELECT * FROM geniuses WHERE apellido = 'Euler'")
res.show()