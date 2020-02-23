folder=$1

./runwpatest.sh -dda $folder &
./runwpatest.sh -new $folder &
./runwpatest.sh -scc $folder &



