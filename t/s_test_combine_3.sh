#!/bin/bash
T_FOLDER=${T_FOLDER:-t}
R_FOLDER=${R_FOLDER:-}

cd "$(dirname "$0")/..$R_FOLDER" || exit 1

DIFF=${DIFF:-diff}


# output_file="$T_FOLDER/output.txt"
# cat "$T_FOLDER"/d/s3.txt | c/combine.sh > "$output_file"


if $DIFF <(cat "$T_FOLDER"/d/s7.txt | c/combine.sh | sed 's/\t*$//' | sed 's/\s/ /g' | sort | uniq) <(cat "$T_FOLDER"/d/s8.txt | sed 's/\t*$//' | sed 's/\s/ /g' | sort | uniq) > /dev/null;
then
    echo "$0 success: ngrams are identical"
else
    echo "$0 failure: ngrams are not identical"
fi