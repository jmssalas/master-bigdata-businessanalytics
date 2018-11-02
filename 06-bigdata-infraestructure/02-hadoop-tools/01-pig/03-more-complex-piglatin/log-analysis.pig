-- How to execute: pig -x mapreduce -f log-analysis.pig -param LOGS='path_to_access_log_file.txt' --param OUTFILE='path_to_output_file'

-- El formato del fichero que estamos cargando es el siguiente:
-- File format that we are loading is the following:
-- http://httpd.apache.org/docs/current/logs.html


-- Register the library
REGISTER /home/bigdata/pig/lib/piggybank.jar

-- Define like CommonLogLoader library like ApacheCommonLogLoader
DEFINE ApacheCommonLogLoader org.apache.pig.piggybank.storage.apachelog.CommonLogLoader();

-- Load data given by $LOGS params
logs = LOAD '$LOGS' USING ApacheCommonLogLoader as (remoteHost, hyphen, user, time, method, uri, protocol, statusCode, responseSize);

-- Filter only successfully GET logs 
logs = FILTER logs BY method == 'GET' AND statusCode >= 200 AND statusCode < 300;

-- Proyect only the fields we need
logs = FOREACH logs GENERATE uri, responseSize;

-- Group by URI and count requests
groupedByUri = GROUP logs BY uri;
uriCounts = FOREACH groupedByUri GENERATE group AS uri, COUNT(logs) AS numHits;

-- Order the result
uri_result = ORDER uriCounts BY uri DESC;

DESCRIBE uri_result;

-- Storage result on output file $OUTFILE
STORE uri_result INTO '$OUTFILE';