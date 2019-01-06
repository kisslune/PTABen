# Calculate lines of code of files with specified suffix
# Author: Sen Ye
#   Date: 02/02/2015
#
# $1    directory containing source files
# $2-   source file suffixes


for (( j=2; $j<=$#; j=$j+1 ))
do
	TYPE_LN=0;
	for i in `find $1 -name "*${!j}"`;
	do
		LN_NUM=`wc -l $i | awk '{print $1;}'`;
		TYPE_LN=$(( TYPE_LN + LN_NUM ));
		TOTAL_LN=$(( TOTAL_LN + LN_NUM ));
	done
done

echo Total $TOTAL_LN
