#!/bin/bash
# AWK examples, from Supercomputing with Linux, Lev Lafayette, VPAC, 2015
# Simple 1: Count of character 'A' in field 7
# Simple 2: Sum of field 7
# Simple 3 Sum of each record. Awk operates line-by-line

awk '$7=="A" { ++count } END { print "Simple 1: " count }' simple1.txt;
awk '{sum+=$7} END {print "Simple2: " sum}' simple2.txt;
awk '{ for(i=1; i<=NF;i++) j+=$i; print "Simple3: " j; j=0 }' simple3.txt
