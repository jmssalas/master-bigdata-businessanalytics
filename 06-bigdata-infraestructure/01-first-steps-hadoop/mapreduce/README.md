# How to execute the examples
- Java folder
	- WordCount: `hadoop jar wc.jar WordCount wc-in/ wc-out/`
	- LineCount: `hadoop jar LineCount.jar LineCount line-count-in/ line-count-out/`

- Python folder
	- WordCount: `hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-2.8.0.jar -mapper mapper.py -reducer reducer.py -input wc-in-python/ -output wc-out-python/`