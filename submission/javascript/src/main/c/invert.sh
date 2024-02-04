#!/bin/bash

# Invert index to create a mapping from terms to URLs containing that term
# The details of the index structure can be seen in the test cases

invert_url="$1"

# declare -A counts

# while IFS= read -r line; do
#     # Increment count for each unique line
#     counts["$line"]=$((counts["$line"] + 1))
# done < <(sed 's/^[ \t]*//;s/[ \t]*$//')

# # Print results
# for line in "${!counts[@]}"; do
#     echo "$line | ${counts[$line]} | $invert_url"
# done



sed 's/^[ \t]*//;s/[ \t]*$//' | sort | uniq -c | while read -r count word; do
    echo "$word | $count | $invert_url"
done

