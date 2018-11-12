from pyspark import SparkContext

sc = SparkContext.getOrCreate()

# Load data
textFile = sc.textFile("/spark/README.md")

# Get Count of lines
print(textFile.count())

# Get first line
print(textFile.first())

# Get lines with Spark
linesWithSpark = textFile.filter(lambda line: "Spark" in line)
print(linesWithSpark.count())

# Get line with more words
textFile.map(lambda line: len(line.split())).reduce(lambda a,b: a if (a > b) else b)


# Get Word counts
wordCounts = textFile.flatMap(lambda line: line.split()).map(lambda word: (word, 1)).reduceByKey(lambda a,b: a + b)
print(wordCounts.collect())
print(wordCounts.count())