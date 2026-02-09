#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
	echo "Error: Missing parameters. Usage: $0 <path> <textstring>"
	exit 1
fi
writefile="$1"
writestr="$2"

dirpath=$(dirname "$writefile")

if [ ! -d "$dirpath" ]; then
	mkdir -p "$dirpath" 2>/dev/null
	if [ $? -ne 0 ]; then
		echo "Error: could not create dir path '$dirpath'"
		exit 1
	fi
fi

echo "$writestr" > "$writefile" 2>/dev/null

if [ $? -ne 0 ]; then
	echo "Error: Could not create file '$writefile'"
	exit 1
fi
echo "File '$writefile' created successfully with provided content."

