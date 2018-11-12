/* Load data */
val textFile = sc.textFile("/spark/README.md")

/* Get number of lines */
textFile.count()

/* Get first line */
textFile.first()

/* Get lines which contains "Spark" */
val linesWithSpark = textFile.filter(line => line.contains("Spark"))
linesWithSpark.count()