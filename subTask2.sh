 #!/bin/bash
 #get variables from output
FILE_PATH=$1
PERCENTAGE_TRAIN_DATA=$2
#get numbr of rows
ROWS=$(cat $FILE_PATH | wc -l)
#get numbr of rows wo header
ROWS_WO_HEADER=$(expr $ROWS - 1)
#count numbr of train rows
LINES_TRAIN=$(($ROWS_WO_HEADER*$PERCENTAGE_TRAIN_DATA/100+1))
NOW=`date +"%Y-%m-%d-%s"`
#write split data to files
sed -n -e "2,$LINES_TRAIN p" -e "$LINES_TRAIN q" $FILE_PATH >> train_${NOW}.csv
sed -n -e "$(expr $LINES_TRAIN + 1),$ROWS_WO_HEADER p" -e "$ROWS_WO_HEADER q" $FILE_PATH >> val_${NOW}.csv
