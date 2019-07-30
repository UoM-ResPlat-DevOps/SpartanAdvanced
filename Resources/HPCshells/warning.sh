#!/bin/bash
# This is an abstract example of things that could do wrong!
#SBATCH --output=/home/example/data/output_%j.out

for for file in /home/example/data/* 
	do
        sbatch application ${file}
	done
