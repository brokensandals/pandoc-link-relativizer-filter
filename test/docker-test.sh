#!/bin/sh

set -e
set -o pipefail

test_dir=$(dirname $0)
root_dir=$(dirname $test_dir)
image_id_file=$test_dir/image-id.txt
docker_dir=$test_dir/docker

docker build --iidfile $image_id_file $docker_dir
docker run --rm -v $root_dir:/pandoc-goodreads-writer $(cat $image_id_file) /pandoc-goodreads-writer/test/local-test.sh
