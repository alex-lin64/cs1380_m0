#!/bin/bash
#
# Combine terms to create  n-grams (for n=1,2,3) and then count and sort them

# Initialize variables
first=""
second=""
third=""


while read -r word; do
    # check if variables are filled
    if [[ -z "$first" ]]; then
        first="${word#"${word%%[![:space:]]*}"}"
    elif [[ -z "$second" ]]; then
        second="${word#"${word%%[![:space:]]*}"}"
    elif [[ -z "$third" ]]; then
        third="${word#"${word%%[![:space:]]*}"}"

        # process 3 words without using function calls
        if [ -n "$first" ]; then
            echo "$first"
        fi
        if [ -n "$second" ]; then
            echo "$first $second"
        fi
        if [ -n "$third" ]; then
            echo "$first $second $third"
        fi

        first="$second"
        second="$third"
        third=""
    fi
done

# process remaining words without using function calls
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



# Read words from the input stream
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
#         echo echo "$ngram"

#     done
# }

# generate_ngrams 1
# generate_ngrams 2
# generate_ngrams 3