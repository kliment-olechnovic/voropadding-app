#!/bin/bash

cd "$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

./build-sihsolvexpand.bash "$1"

./build-voronota-lt.bash "$1"

