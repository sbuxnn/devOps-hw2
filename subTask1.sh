#!/bin/bash
#get variables from output
WORKERS_COUNT=$1
COL_NAME=$2
FOLDER_NAME=$3
CSV_FILE=$4
#get col name
COL_NAME=$(head -1 $CSV_FILE | tr -s ';' '\n' | nl -nln |  grep "$COL_NAME" | cut -f1)
echo $COL_NAME 
LINKS=$(awk -F ";" -v head=$COL_NAME '{print $head}' $CSV_FILE)
mkdir -p $FOLDER_NAME
cd $FOLDER_NAME

WORKERS=$WORKERS_COUNT
echo $WORKERS_COUNT
#loop for downloading links from file
for LINK in $LINKS
do
if [ $WORKERS -eq 0 ]
then
    wait
    WORKERS=$WORKERS_COUNT
fi
    WORKERS="$(($WORKERS-1))"
    echo $WORKERS
    echo $LINK
    wget $LINK &
done
wait