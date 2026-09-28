#!/usr/bin/env bash

if [ $# -ne 1 ];
then 
echo "Enter one arguement!"
exit 1
fi 

if [ ! -f "$1" ];
then 
echo "File doesm't exist" 
exit 1
fi 

if [[ $1 != *.c ]];
then 
echo "Not C source file!"
exit 1
fi

filename=$1
Owner=$(ls -l "$1" | awk '{ print $3 }')
month=$(ls -l "$1" | awk '{ print $7 }')
day=$(ls -l "$1" | awk '{ print $8 }')
timestamp=$(ls -l "$1" | awk '{ print $9 }')

tempfile=$(mktemp) 

echo "/**" > "$tempfile" 
echo " * File Name: $filename" >> "$tempfile"
echo " * Owner: $Owner" >> "$tempfile"
echo " * Last Modified On: $month $day $timestamp" >> "$tempfile"
echo " */" >> "$tempfile" 

cat "$1" >> "$tempfile"

mv "$tempfile" "$1"  
