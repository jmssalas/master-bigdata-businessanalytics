-- Register all HBASE libraries
REGISTER '/home/bigdata/hbase/lib/hbase-common-1.2.6.jar';
REGISTER '/home/bigdata/hbase/lib/hbase-client-1.2.6.jar';
REGISTER '/home/bigdata/hbase/lib/protobuf-java-2.5.0.jar';

-- Load data
data = LOAD 'data.csv' using PigStorage(',') AS (id: chararray, name: chararray, surnames: chararray);

-- Storage data on HBASE namespace
STORE data INTO 'hbase://exercises:people' USING org.apache.pig.backend.hadoop.hbase.HBaseStorage ('info:nombre info:apellidos');
