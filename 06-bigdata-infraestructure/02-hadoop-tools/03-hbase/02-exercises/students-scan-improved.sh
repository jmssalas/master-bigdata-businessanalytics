#!/bin/sh
# how to execute
# sh students-scan-improved.sh <table> <startrow> <stoprow>


TABLE=$1
STARTROW=$2
STOPROW=$3

exec hbase shell <<EOF
	scan "${TABLE}", {STARTROW => "${STARTROW}", STOPROW => "${STOPROW}"}
EOF