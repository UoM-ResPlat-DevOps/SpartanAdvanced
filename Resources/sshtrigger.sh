#! /bin/bash 
# Access to a system is tested with ping every few minutes until a connection is made whereupon it opens an SSH session.
read -p "Enter Hostname:" nethost 
echo $nethost 
until ping -c 1 $nethost 
do 
        sleep 180; 
done 
ssh $nethost 
