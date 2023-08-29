#!/bin/sh

if [ "$(pandoc --version | head -n1)" != "pandoc 3.1.6" ]; then
  echo "unexpected pandoc version"
  exit 1
fi

test_dir=$(dirname $0)
root_dir=$(dirname $test_dir)
filter=$root_dir/pandoc-link-relativizer-filter.lua
in_dir=$test_dir/in
out_dir=$test_dir/out
expected_dir=$test_dir/expected

rm $out_dir/* 2> /dev/null
mkdir -p $out_dir

pandoc --lua-filter $filter $in_dir/main.md -o $out_dir/main.md

diff $out_dir $expected_dir

if [ $? -eq 0 ]; then
  echo "All tests passed!"
else
  exit 1
fi
