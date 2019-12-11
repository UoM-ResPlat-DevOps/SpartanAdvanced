#!/bin/bash
# Illustrates the difference between various types (and lack of) quoting.

SAMPLE="The quick brown fox jumps over the lazy dog"
echo "Double quotes gives you $SAMPLE"
echo 'Single quotes gives you $SAMPLE'

exit
