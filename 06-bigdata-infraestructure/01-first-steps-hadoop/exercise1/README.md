# How to execute 
`hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.8.0.jar wordcount wc-in/ wc-out/`

# Exercises
### Word which is repetead more times
`hdfs dfs -cat wc-out/* | sort -k2nr | head -1`

### Words which is repetead 6 times
`hdfs dfs -cat wc-out/* | grep 6`

### How many times 'eyes' word is appeared
`hdfs dfs -cat wc-out/* | grep eyes`