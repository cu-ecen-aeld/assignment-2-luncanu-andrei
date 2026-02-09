#!/bin/bash

# Check both arguments are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Error: Missing parameters. Usage: $0 <directory> <search_string>"
    exit 1
fi

filesdir="$1"
searchstr="$2"

# Check that filesdir is a directory
if [ ! -d "$filesdir" ]; then
    echo "Error: $filesdir is not a directory"
    exit 1
fi

# Count the number of files in the directory and subdirectories
num_files=$(find "$filesdir" -type f | wc -l)

# Count the number of matching lines
num_matches=$(grep -r "$searchstr" "$filesdir" 2>/dev/null | wc -l)

# Print the result
echo "The number of files are $num_files and the number of matching lines are $num_matches"

