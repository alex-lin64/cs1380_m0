#!/bin/bash

T_FOLDER=${T_FOLDER:-t}
R_FOLDER=${R_FOLDER:-}

cd "$(dirname "$0")/..$R_FOLDER" || exit 1

DIFF=${DIFF:-diff}
DIFF_PERCENT=${DIFF_PERCENT:-0}

cat /dev/null > d/visited.txt
cat /dev/null > d/global-index.txt

echo https://cs.brown.edu/courses/csci1380/sandbox/3 > d/urls.txt

./engine.sh

if $DIFF <(sort d/visited.txt) <(sort "$T_FOLDER"/d/s3_urls.txt) > /dev/null;
then
    echo "$0 success: visited urls are identical"
else
    echo "$0 failure: visited urls are not identical"
fi

if DIFF_PERCENT=$DIFF_PERCENT t/gi-diff.js <(sort d/global-index.txt) <(sort "$T_FOLDER"/d/s3_gi.txt) > /dev/null;
then
    echo "$0 success: global-index is identical"
else
    echo "$0 failure: global-index is not identical"
fi
