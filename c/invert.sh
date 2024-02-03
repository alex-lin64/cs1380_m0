#!/bin/bash

# Invert index to create a mapping from terms to URLs containing that term
# The details of the index structure can be seen in the test cases

invert_url="$1"

sed 's/^[ \t]*//;s/[ \t]*$//' | sort | uniq -c | while read -r count word; do
    echo "$word | $count | $invert_url"
done
