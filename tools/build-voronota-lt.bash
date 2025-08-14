#!/bin/bash

cd "$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

BUILDMODE="$1"

if [ "$BUILDMODE" == "static" ]
then
	g++ -std=c++14 -static-libgcc -static-libstdc++ -static -O3 -o "./voronota-lt" "./voronota-js-src/expansion_lt/src/voronota_lt.cpp"
elif [ "$BUILDMODE" == "ofast" ]
then
	g++ -std=c++14 -Ofast -march=native -o "./voronota-lt" "./voronota-js-src/expansion_lt/src/voronota_lt.cpp"
else
	g++ -std=c++14 -O3 -o "./voronota-lt" "./voronota-js-src/expansion_lt/src/voronota_lt.cpp"
fi

