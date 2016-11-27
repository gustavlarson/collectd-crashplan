#!/bin/bash

HOSTNAME="${COLLECTD_HOSTNAME:-hostname}"
INTERVAL="${COLLECTD_INTERVAL:-30}"
APPLOG="${1:-/usr/local/crashplan/log/app.log}"

while sleep "$INTERVAL"; do

	perc=$(cat $APPLOG | grep complete | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}')
	totalFiles=$(cat $APPLOG | grep totalFiles | tr -cd "[:digit:]")
	totalSize=$(cat $APPLOG | grep totalSize | grep -o '[\.0-9]*')
	totalSizeB=$(echo $totalSize*1024*1024*1024 | bc) #GB to B

	echo "PUTVAL \"$HOSTNAME/crashplan/percent-completed\" interval=$INTERVAL N:$perc"
	echo "PUTVAL \"$HOSTNAME/crashplan/files-totalFiles\" interval=$INTERVAL N:$totalFiles"
	echo "PUTVAL \"$HOSTNAME/crashplan/bytes-totalSize\" interval=$INTERVAL N:$totalSizeB"

done
