#!/bin/bash

cd "$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if [ "$1" == "static" ]
then

g++ -std=c++14 -static-libgcc -static-libstdc++ -static -O3 -I "./voronota-js-src/expansion_js/src/dependencies" -o "./voronota-js" $(find ./voronota-js-src/expansion_js/ -name '*.cpp')

else

g++ -std=c++14 -O3 -I "./voronota-js-src/expansion_js/src/dependencies" -o "./voronota-js" $(find ./voronota-js-src/expansion_js/ -name '*.cpp')

fi

