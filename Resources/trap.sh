#!/bin/bash
# Prevents use of Control-C to prematurely end important script.
# User can override if they're really, really sure.

    ctrlc_count=0

function test_ctrlc()
{
    let ctrlc_count++
    echo
    if [[ $ctrlc_count == 1 ]]; then
        echo "Cntrl-C prevented unless you're sure."
    elif [[ $ctrlc_count == 2 ]]; then
        echo "Really sure?"
    elif [[ $ctrlc_count == 3 ]]; then
        echo "Really, really sure?"
    else
        echo "OK, you're really, really sure.."
        exit
    fi
}

trap test_ctrlc SIGINT

while true
do
    echo "This is a sleeping loop. The loop that keeps on sleeping on."
    sleep 2
done

exit
