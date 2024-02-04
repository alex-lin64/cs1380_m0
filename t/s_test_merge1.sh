#!/bin/bash

T_FOLDER=${T_FOLDER:-t}
R_FOLDER=${R_FOLDER:-}

cd "$(dirname "$0")/..$R_FOLDER" || exit 1

DIFF=${DIFF:-diff}

output_file="$T_FOLDER/output.txt"

cat "$T_FOLDER"/d/m2.txt | c/merge.js d/m1_gi.txt > "$output_file"

if $DIFF <(cat d/test_merge1.txt) <(cat "$T_FOLDER"/output.txt) > /dev/null;
then
    echo "$0 success: custom merge indexes are identical"
else
    echo "$0 failure: custom merge indexes are not identical"
fi
