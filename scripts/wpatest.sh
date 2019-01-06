#/bin/bash
###############################
#
# Script to test WPA, change variables and options for testing
#
##############################

TNAME=wpa
EXEFILE=$PTABIN/$TNAME
WPATy=$1
FILE=$2
FILENAME=$3
COUNT=$4

OUTPUT=$COUNT$WPATy-1-$FILENAME.txt
# FLAG1="$WPATy -stat=0 -fieldlimit=0"
# FLAG2="-print-pts>&pts$WPATy-$FILENAME.txt"

echo === Analyzing $FILE with $WPATy ===
$EXEFILE $WPATy $FILE -stat=0 -print-pts >&ptsoutputs/$OUTPUT
echo $OUTPUT created.

#-fieldlimit=0 -print-pts>&ptsoutputs/$OUTPUT

#>&ptsoutputs/$OUTPUT
