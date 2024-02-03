#!/bin/bash

# Provided an appropriate index, the query could be implemented using grep
# along  with appropriate stemming of the input strings and stripping of the 
# index metadata

search=""

for arg in "$@"; do
  stemmed=$(echo "$arg" | ./c/stem.js)
  search+="$stemmed "
done

grep -i "$search" "d/global-index.txt"

