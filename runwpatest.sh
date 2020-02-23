#/bin/bash
################################################
#
#  Script to run all the testings in selected folder in $PTATEST/
#  ./runtest       run testcases with your executables
#  ./runtest opt   run testcases with llvm opt to load your .so library
#  Set TestFolders to indicate the testcasts you want to compile and run 
#  Set TestScript to indicate which analysis/optimizations you want to test with
################################################

PTATEST=`realpath .`
PTATESTSCRIPTS=$PTATEST/scripts
RUNSCRIPT=$PTATEST/run.sh

######## Initialize the following key vailables before analyze ########
WPATy=$1
TestFolders=$2
testscript="wpatest.sh"
curDir=`pwd`
Clean="$PTATEST/clean.sh"

# testrc.sh
# testdvf.sh\
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

	### test plain c program files
	Suffix='c'
	for i in `find . -name '*.c'`
	do
		FileName=`basename $i .$Suffix`
		$CLANG -I$PTATEST $CLANGFLAG $i -o $FileName.bc >>$COMPILELOG 2>&1
		$LLVMOPT $LLVMOPTFLAG $FileName.bc -o $FileName.opt
		$LLVMDIS $FileName.opt
		$PTATESTSCRIPTS/$testscript $WPATy $FileName.opt $FileName $I
		I=$(($I+1))
	done

	### test cpp program files
	Suffix='cpp'
	for i in `find . -name '*.cpp'`
	do
		FileName=`basename $i .$Suffix`
		$CLANG -I$PTATEST $CLANGFLAG $i -o $FileName.bc >>$COMPILELOG 2>&1
		$LLVMOPT $LLVMOPTFLAG $FileName.bc -o $FileName.opt
		$LLVMDIS $FileName.opt
		$PTATESTSCRIPTS/$testscript $WPATy $FileName.opt $FileName $I
		I=$(($I+1))
	done

	### test llvm bitcode files (located in cpu2000/cpu2006 folder)
	Suffix='orig'
	for i in `find . -name '*.orig'` 
	do
		FileName=`basename $i .$Suffix`
		$LLVMOPT $LLVMOPTFLAG $i -o $FileName.opt
		$PTATESTSCRIPTS/$testscript $WPATy $FileName.opt $FileName $I
 		I=$(($I+1))
	done

	cd $curDir
done
# $Clean
echo analysis finished
