#!/bin/bash

cd "$(dirname "$0")" || exit


./s_test_combine.sh
./s_test_combine_mid.sh
./s_test_combine_small.sh
./s_test_getText.sh
./s_test_invert.sh
./s_test_merge.sh
./s_test_merge_small.sh
./s_test_process.sh
./s_test_query.sh
