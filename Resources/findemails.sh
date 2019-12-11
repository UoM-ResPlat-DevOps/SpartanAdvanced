#!/bin/bash
# Search for email addresses in file, extract, turn into csv with designated file name

# Constants
INPUT=${1}
OUTPUT=${2}

# Filecheck Subroutine
filecheck() {
if [ ! $INPUT -o ! $OUTPUT ]; then
    echo "Input file not found, or output file not specified. Exiting script."
    exit 0
fi
}

# Search and Sort Subroutine

searchsort() {
grep --only-matching -E '[.[:alnum:]]+@[.[:alnum:]]+' $INPUT > $OUTPUT
sed -i 's/$/,/g' $OUTPUT
sort -u $OUTPUT -o $OUTPUT
sed -i '{:q;N;s/\n/ /g;t q}' $OUTPUT
}

# View and Print Subroutine
viewprint() {
echo "Data file extracted to" $OUTPUT
read -t5 -n1 -r -p "Press any key to see the list, sorted and with unique record"
if [ $? -eq 0 ]; then
    echo A key was pressed
    else
    echo No key was pressed
    exit
fi
less $OUTPUT | \
# Output file piped through sort and uniq. 
# Show that line extension still works with comments.
sort | uniq
} 

main() {
	filecheck
	searchsort
	viewprint
}

# Main function
main
exit
