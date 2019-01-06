FOLDERS='basic_c_tests
basic_cpp_tests
complex_tests
mem_leak'

wpaty=$1

for folder in $
do
	./runwpatest.sh $1 $folder
done
