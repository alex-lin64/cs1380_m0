#!/bin/bash

# if url already visited
if grep -qxF "$1" d/visited.txt; then
    exit 0
else
# if url not visited
  echo "$1" >>d/visited.txt

  curl -sL "$1" |
    tee >(c/getURLs.js "$1" | grep -vxf d/visited.txt >>d/urls.txt) |
    c/getText.js
fi

