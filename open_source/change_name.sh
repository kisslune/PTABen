for i in `find ./ -name "*.bc"`;
do
	NAME=`basename $i .bc`;
	DIR=`dirname $i`;
#	echo $i $DIR $NAME;
	mv $i $DIR/$NAME.orig
done
