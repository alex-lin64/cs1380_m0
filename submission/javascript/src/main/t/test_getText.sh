#!/bin/bash
T_FOLDER=${T_FOLDER:-t}
R_FOLDER=${R_FOLDER:-}

cd "$(dirname "$0")/..$R_FOLDER" || exit 1

DIFF=${DIFF:-diff}

# output_file="$T_FOLDER/output.txt"
# touch "$output_file"

# cat "$T_FOLDER"/d/d0.txt | c/getText.js | sort > "$output_file"

# if $DIFF "$output_file" <(sort "$T_FOLDER"/d/d2.txt) > /dev/null;

if $DIFF <(cat "$T_FOLDER"/d/d0.txt | c/getText.js | sort) <(sort "$T_FOLDER"/d/d2.txt) > /dev/null;
then
    echo "$0 success: texts are identical"
else
    echo "$0 failure: texts are not identical"
fi
