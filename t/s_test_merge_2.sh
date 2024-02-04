#!/bin/bash

# merge with empty file

T_FOLDER=${T_FOLDER:-t}
R_FOLDER=${R_FOLDER:-}

cd "$(dirname "$0")/..$R_FOLDER" || exit 1

DIFF=${DIFF:-diff}


# output_file="$T_FOLDER/output.txt"
# cat "$T_FOLDER"/d/m2.txt | c/merge.js "$T_FOLDER"/d/s2.txt > "$output_file"


if $DIFF <(cat "$T_FOLDER"/d/test_merge2.txt) <(cat "$T_FOLDER"/d/m2.txt | c/merge.js "$T_FOLDER"/d/s2.txt) > /dev/null;
then
    echo "$0 success: custom merge indexes are identical"
else
    echo "$0 failure: custom merge indexes are not identical"
fi
