#!/bin/bash
# Converts ("moves") all files in the directory run to lowercase.
for i
do 
	mv $i $(echo $i | tr "A-Z" "a-z")
done
