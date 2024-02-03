#!/bin/bash
#
# Combine terms to create  n-grams (for n=1,2,3) and then count and sort them

# Initialize variables
first=""
second=""
third=""

# Function to process 3 words
process_words() {
    if [ -n "$first" ]; then
        echo "$first"
    fi
    if [ -n "$second" ]; then
        echo "$first $second"
    fi
    if [ -n "$third" ]; then
        echo "$first $second $third"
    fi

    # Move words to their respective positions
    first="$second"
    second="$third"
    third=""
}

process_words_shortage() {
    if [ -n "$first" ]; then
        echo "$first"
    fi
    if [ -n "$second" ]; then
        echo "$first $second"
        echo "$second"
    fi
    if [ -n "$third" ]; then
        echo "$first $second $third"
        echo "$second $third"
        echo "$third"
    fi
}

# Main loop
while read -r word; do
    # Check if variables are filled
    if [[ -z "$first" ]]; then
        first=$(echo "$word" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    elif [[ -z "$second" ]]; then
        second=$(echo "$word" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    elif [[ -z "$third" ]]; then
        third=$(echo "$word" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
        process_words
    fi
done

process_words_shortage



# # Read words from the input stream
# while read -r word; do
#     words+=("$word")
# done

# # Function to generate n-grams
# generate_ngrams() {
#     local n=$1
#     local length=${#words[@]}

#     for ((i = 0; i <= length - n; i++)); do
#         local ngram=""
#         for ((j = 0; j < n; j++)); do
#             ngram+=" ${words[i + j]}"
#         done
#         echo $(echo "$ngram" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

#     done
# }

# generate_ngrams 1
# generate_ngrams 2
# generate_ngrams 3