#!/bin/bash

HOSTNAME="${COLLECTD_HOSTNAME:-pi}"
INTERVAL="${COLLECTD_INTERVAL:-30}"

applog="/opt/crashplan/log/app.log"

while sleep "$INTERVAL"; do

	perc=$(cat $applog | grep complete | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}')
	totalFiles=$(cat $applog | grep totalFiles | tr -cd "[:digit:]")
	totalSize=$(cat $applog | grep totalSize | grep -o '[\.0-9]*')
	totalSizeB=$(echo $totalSize*1024*1024*1024 | bc) #GB to B
	echo "PUTVAL \"$HOSTNAME/crashplan/percent-completed\" interval=$INTERVAL N:$perc"
	echo "PUTVAL \"$HOSTNAME/crashplan/files-totalFiles\" interval=$INTERVAL N:$totalFiles"
	echo "PUTVAL \"$HOSTNAME/crashplan/bytes-totalSize\" interval=$INTERVAL N:$totalSizeB"

done
