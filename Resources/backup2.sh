#!/bin/bash          
BU=homeuser$(date +%Y%m%d).tgz 
tar cvfz $BU $(pwd)
