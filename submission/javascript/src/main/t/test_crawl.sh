#!/bin/bash

T_FOLDER=${T_FOLDER:-t}
R_FOLDER=${R_FOLDER:-}

cd "$(dirname "$0")/..$R_FOLDER" || exit 1

DIFF=${DIFF:-diff}

cat /dev/null > d/visited.txt
cat /dev/null > d/global-index.txt

cat "$T_FOLDER"/d/test_crawl.txt > d/urls.txt

./engine.sh

if $DIFF <(sort d/visited.txt) <(sort "$T_FOLDER"/d/test_crawl_sol.txt) > /dev/null;
then
    echo "$0 success: visited urls are identical"
else
    echo "$0 failure: visited urls are not identical"
fi

