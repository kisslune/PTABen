TestFolders="
	    spell-1.1\
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
	    sendmail-8.15.1\
	    bash-4.3\
	    vim74\
	    emacs-24.4\
	    gdb-7.8\
	    ghostscript-9.14\
		"

budget=$1
for prog in $TestFolders
do
echo -----------analysing program $prog ----------;
#$PTATESTSCRIPTS/DDA/dda.sh $prog all dda.cfg
fname=*.uninit.$budget
for i in `find $prog -name $fname`
do
rm $i
done
for i in `find $prog -name '*.orig'`
do
echo analysing $i;
opt -mem2reg $i -o $i.opt
dvf -dfs -flowbg=$budget -query=uninit -dwarn $i.opt >& $i.uninit.$budget
done
echo --------------------------------------------
echo
echo
done
