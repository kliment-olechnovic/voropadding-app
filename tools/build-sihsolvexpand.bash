#!/bin/bash

cd "$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if [ "$1" == "static" ]
then

# building a static execulable
g++ -std=c++14 -static-libgcc -static-libstdc++ -static -O3 -I "./voronota-js-src/expansion_lt/src/" -o "./sihsolvexpand" "./sihsolvexpand.cpp"

else

# building with OpenMP and with CPU architecture matching
# g++ -std=c++14 -Ofast -march=native -fopenmp -I "./voronota-js-src/expansion_lt/src/" -o "./sihsolvexpand" "./sihsolvexpand.cpp"

# building without OpenMP in a more portable way
g++ -std=c++14 -O3 -I "./voronota-js-src/expansion_lt/src/" -o "./sihsolvexpand" "./sihsolvexpand.cpp"

fi

