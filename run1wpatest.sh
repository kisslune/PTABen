#/bin/bash
################################################
#
#  Script to run all the testings in selected folder in $PTATEST/
#  ./runtest       run testcases with your executables
#  ./runtest opt   run testcases with llvm opt to load your .so library
#  Set TestFolders to indicate the testcasts you want to compile and run 
#  Set TestScript to indicate which analysis/optimizations you want to test with
################################################


######## Initialize the following key vailables before analyze ########
WPATy=$1
TestFolders=$2
testscript="wpatest.sh"
curDir=`pwd`
Clean="$PTATEST/clean.sh"

# testrc.sh
# testdvf.sh
# testmssa.sh"


##remember to run ./setup script before running testings
CLANGFLAG='-Xclang -disable-O0-optnone -g -c -emit-llvm -I.'
LLVMOPTFLAG='-mem2reg -mergereturn'
COMPILELOG="compile.log"
### Add the fold of c files to be tested
#      rc
#            test\
#	     "

### Add the test shell files


### remove previous compile log
rm -rf $COMPILELOG
# $Clean

### start testing
for folder in $TestFolders
do
	I=1
	cd $folder
	mkdir ptsoutputs
	mkdir Faults
	echo Entering Folder $folder 'for' testing ...
	echo "#################COMPILATION LOG##############" > $COMPILELOG

	### test llvm bitcode files (located in cpu2000/cpu2006 folder)
	Suffix='orig'
	for i in `find . -name '*.orig'` 
	do	
		FileName=`basename $i .$Suffix`
		$PTATESTSCRIPTS/$testscript $WPATy $FileName $I
 		I=$(($I+1))

		FileName=`basename $i .$Suffix`
		$PTATESTSCRIPTS/$testscript $WPATy $FileName $I
		I=$(($I+1))
	done

	cd $curDir
done
# $Clean
echo analysis finished
