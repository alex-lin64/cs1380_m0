#!/bin/bash
T_FOLDER=${T_FOLDER:-t}
R_FOLDER=${R_FOLDER:-}

cd "$(dirname "$0")/..$R_FOLDER" || exit 1

DIFF=${DIFF:-diff}

# output_file="$T_FOLDER/output2.txt"


url="https://hi.com"


# cat "$T_FOLDER"/d/d5.txt | c/invert.sh $url > "$output_file"
# cat "$T_FOLDER"/d/d6.txt | sed 's/[[:space:]]//g' > "$output_file"




if $DIFF <(cat "$T_FOLDER"/d/s11.txt | c/invert.sh $url | sed 's/[[:space:]]//g') <(cat "$T_FOLDER"/d/s12.txt | sed 's/[[:space:]]//g') > /dev/null;
then
    echo "$0 success: inverted indices are identical"
else
    echo "$0 failure: inverted indices are not identical"
fi