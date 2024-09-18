#!/bin/bash

# Check if all arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <sha_version> <path/to/file> <known_good_hash>"
    exit 1
fi

# Assign arguments to variables
sha_version=$1
file_path=$2
known_good=$(echo "$3" | tr '[:upper:]' '[:lower:]') # convert known good to lower casek

#calculate the hash of the file
calculated_hash=$(shasum -a "$sha_version" "$file_path" | awk '{print $1}')

# Compare the calculated hash with the known good hash
if [ "$calculated_hash" = "$known_good" ]; then
    echo "OK"
else
    echo "Hashes do not match"
    echo "Calculated hash: $calculated_hash"
    echo "Known good hash: $known_good"
fi
