#!/bin/env bash

find  ../utils ../src -type f -exec sed -e 's/read.*/REPLY=1/' -e 's/source.*//' {} > ../test/src/test_skitgubbe.sh \;
