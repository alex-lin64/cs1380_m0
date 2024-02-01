#!/bin/bash
#
# Combine terms to create  n-grams (for n=1,2,3) and then count and sort them

# Read words from the input stream
while read -r word; do
    words+=("$word")
done

# Function to generate n-grams
generate_ngrams() {
    local n=$1
    local length=${#words[@]}

    for ((i = 0; i <= length - n; i++)); do
        local ngram=""
        for ((j = 0; j < n; j++)); do
            ngram+=" ${words[i + j]}"
        done
        echo $(echo "$ngram" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

    done
}

generate_ngrams 1
generate_ngrams 2
generate_ngrams 3