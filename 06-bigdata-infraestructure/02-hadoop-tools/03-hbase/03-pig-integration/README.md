# How to execute

1. Execute `$ hbase shell create-table.sh`
2. We need compiler PIG with HBase 1.X compatibility
	- `$ sudo apt install ant`
	- `$ cd /home/bigdata/pig`
	- `$ sudo ant jar -Dhadoopversion=23 -Dhbase95.version=1.2.6`
	- `$ sudo rm pig-0.16.0-core-h2.jar`
	- `$ sudo mv pig-0.16.0-SNAPSHOT-core-h2.jar pig-0.16.0-core-h2.jar`
3. Execute `$ pig -x local load_data.pig`
4. Execute `$ hbase shell scan-table.sh`