#/bin/bash

BEGIN=$1
END=$2

I=$BEGIN
while [[ $I -le $END ]]
do
	echo $I
	./txtdif.sh $I
	I=$(($I+1))
done
