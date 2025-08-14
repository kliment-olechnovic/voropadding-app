#!/bin/bash

cd "$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

BUILDMODE="$1"

if [ "$BUILDMODE" == "static" ]
then
	g++ -std=c++14 -static-libgcc -static-libstdc++ -static -O3 -I "./voronota-js-src/expansion_lt/src/" -o "./sihsolvexpand" "./sihsolvexpand.cpp"
elif [ "$BUILDMODE" == "ofast" ]
then
	g++ -std=c++14 -Ofast -march=native -I "./voronota-js-src/expansion_lt/src/" -o "./sihsolvexpand" "./sihsolvexpand.cpp"
else
	g++ -std=c++14 -O3 -I "./voronota-js-src/expansion_lt/src/" -o "./sihsolvexpand" "./sihsolvexpand.cpp"
fi

