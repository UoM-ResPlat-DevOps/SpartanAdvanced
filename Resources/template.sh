#! /bin/sh

## Recommendation from Andrew Worsley
## https://github.com/amworsley/intro-shell-programming/blob/master/shell-programing.md

usage()
{
   echo "$(basename $0): Description of script"
   echo ""
   echo "-h : This usage information"
   echo "-n : Dry-run print commands instead of executing them"
   echo "-x : Enabling tracing of shell script"
}

while getopts 'nxhA:' argv
do
case $argv in
n)
   echo "Dry-Run"
   DR=echo
;;
x)
    echo "Enabling tracing"
    set -x
;;
#A) ARG="$OPTARG" ;;
h) usage ;;
esac
done
shift $(($OPTIND-1))
