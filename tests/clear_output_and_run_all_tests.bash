#!/bin/bash

SCRIPTDIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPTDIR"

rm -rf "./output"
mkdir -p "./output"

find ./input/ -type f \
| grep -v '1cnw' \
| while read -r INFILE
do
	BASENAME="$(basename ${INFILE} .pdb)"
	echo "${INFILE} --output-table-file ./output/base_table_${BASENAME}.txt --output-graphics-file ./output/base_draw_${BASENAME}.py"
done \
| xargs -L 1 -P 4 ../voropadding --input


../voropadding \
  --input "./input/1cnw.pdb" \
  --restriction-centers '[-aname ZN]' \
  --restriction-radius 16.0 \
  --output-table-file "./output/restricted_table_1cnw.txt" \
  --output-graphics-file "./output/restricted_draw_1cnw.py" \
  --print-mode v \
  --graphics-mode detailed

  