#!/bin/bash
T_FOLDER=${T_FOLDER:-t}
R_FOLDER=${R_FOLDER:-}

cd "$(dirname "$0")/..$R_FOLDER" || exit 1

DIFF=${DIFF:-diff}

# output_file="$T_FOLDER/output.txt"
# touch "$output_file"

# cat "$T_FOLDER"/d/d4.txt | c/combine.sh > "$output_file"
# cat "$T_FOLDER"/d/d5.txt | sed 's/\t*$//' | sed 's/\s/ /g' | sort | uniq > "$T_FOLDER/output2.txt"


# if $DIFF "$output_file" <(sort "$T_FOLDER"/d/d2.txt) > /dev/null;

if $DIFF <(cat "$T_FOLDER"/d/d4.txt | c/combine.sh | sed 's/\t*$//' | sed 's/\s/ /g' | sort | uniq) <(cat "$T_FOLDER"/d/d5.txt | sed 's/\t*$//' | sed 's/\s/ /g' | sort | uniq) > /dev/null;
then
    echo "$0 success: ngrams are identical"
else
    echo "$0 failure: ngrams are not identical"
fi
