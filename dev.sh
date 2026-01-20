#!/bin/bash

command -v entr >/dev/null || brew install entr
command -v browser-sync >/dev/null || npm install -g browser-sync

browser-sync start --server .output --no-open &
trap "kill $! 2>/dev/null" EXIT

swift run
find Sources Content Assets -type f | entr -s 'swift run && browser-sync reload'
