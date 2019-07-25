#! /bin/bash 
# Tests whether a specified file exists of not, illustrates if/then/else.
file=$1 
if [ -e $file ] 
then 
	echo -e "File $file exists" 
else 
	echo -e "File $file doesn't exists" 
fi 
exit 0
