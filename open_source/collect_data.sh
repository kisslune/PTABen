# Collect data from TestFolders
# Author: Sen Ye (senye1985@gmail.com)
#
# INPUT
# $1    configuration file
# $2    suffix of data files
# $3    file name of output file
#
#
# Format of config file
#     Each line has two componenets: section name and field names. Section and fileds are separated by colon and fields are separated by commas.
#     Suppose we have following data file:
#
# ****Andersen Pointer Analysis Statistics****       <-- section name
# ################ (program : )###############
# IndCallSites        2                              <-- field data we need
# ReturnsNum          3
# CallsNum            113
#
# ****Demand-Driven Pointer Analysis Statistics****  <-- section name
# ################ (program : )###############
# IndEdgeSolved       2                              <-- field data we need
# NumOfNullPtr        0
# NumOfInfePath       0
#
#
# The config file should contains following two lines:
#-----------------------------------------------------
#        Demand-Driven Pointer:IndEdgeSolved
#        Andersen:IndCallSites
#-----------------------------------------------------
#
#
# FINAL DATA INFORMATION IN OUTPUT 
#--------------------
# program_name_1 2 2
# program_name_2 4 6
#--------------------
#

if [ $# -ne 3 ]
then
	echo "Expecting three arguments!";
	echo "Usage: ./collect_data.sh CONFIG OUTPUT";
	echo "    CONFIG   configuration file (check this script for an example)";
	echo "    SUFFIX   suffix of data files";
	echo "    OUTPUT   name of output file";
	exit;
fi


TestFolders="spell-1.1\
			 ed-1.10\
			 bc-1.06\
			 less-451\
			 sed-4.2\
			 make-4.1\
			 screen-4.2.1\
			 gzip-1.6\
			 a2ps-4.14\
			 bison-3.0.4\
			 grep-2.21\
			 tar-1.28\
			 wget-1.16\
			 bash-4.3\
			 sendmail-8.15.1\
			 vim74\
			 emacs-24.4\
			 Python-3.4.2\
			 ghostscript-9.14\
			 gdb-7.8"

CFG_FILE=$1
SUFFIX=$2
OUTPUT=$3
SCRIPT="./find_data.pl"

if [ -f $OUTPUT ];
then
	rm $OUTPUT;
fi

for prog in $TestFolders
do
	echo -----------collecting data from program $prog ----------;
	for i in `find $prog -name '*.orig'`
	do
		PROGRAM_NAME=`basename $i .orig`
		STAT_FILE=$i.$SUFFIX
		if [ -f $STAT_FILE ];
		then
			echo collecting $i;
			data="$PROGRAM_NAME    ";
			echo $SCRIPT $STAT_FILE $PROGRAM_NAME $CFG_FILE;
			data+=`$SCRIPT $STAT_FILE $PROGRAM_NAME $CFG_FILE`;
			echo $data >> $OUTPUT
		fi
	done
	echo --------------------------------------------
	echo
done
