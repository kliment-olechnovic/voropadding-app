#!/bin/bash

SCRIPTDIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPTDIR"

rm -rf "./output"
mkdir -p "./output"

../voropadding -h &> "./output/help_message.txt"

find ./input/complex/ -type f \
| grep -v '1cnw' \
| while read -r INFILE
do
	BASENAME="$(basename ${INFILE} .pdb)"
	echo "${INFILE} --output-table-file ./output/base_table_${BASENAME}.txt --output-graphics-file ./output/base_draw_${BASENAME}.py"
done \
| xargs -L 1 -P 4 ../voropadding --input-complex


../voropadding \
  --input-complex "./input/complex/1cnw.pdb" \
  --restriction-centers '[-aname ZN]' \
  --restriction-radius 16.0 \
  --output-table-file "./output/restricted_table_1cnw.txt" \
  --output-graphics-file "./output/restricted_draw_1cnw.py" \
  --print-mode v \
  --graphics-mode detailed

../voropadding \
  --input-receptor "./input/receptor_ligand/5zyg_receptor.pdb" \
  --input-ligand "./input/receptor_ligand/5zyg_ligand.sdf" \
  --output-table-file "./output/receptor_ligand_table_5zyg.txt" \
  --output-graphics-file "./output/receptor_ligand_draw_5zyg.py" \
  --print-mode v

for MPADDING in 1 2 3
do
	find "./input/complex/" -type f -name '*.pdb' \
	| ../voropadding \
	  --input-complex _list \
	  --max-padding ${MPADDING} \
	  --output-table-file "./output/all_global_scores_table_max_padding_${MPADDING}.txt" \
	  --processors 4

	../voropadding \
	  --input-receptor "./input/receptor_ligand/5zyg_receptor.pdb" \
	  --input-ligand "./input/receptor_ligand/5zyg_ligand.sdf" \
	  --max-padding ${MPADDING} \
	  --output-table-file "./output/receptor_ligand_table_5zyg_max_padding_${MPADDING}.txt" \
	  --output-padding-file "./output/receptor_ligand_padding_table_5zyg_max_padding_${MPADDING}.tsv" \
	  --output-padding-draw-file "./output/receptor_ligand_padding_table_5zyg_max_padding_${MPADDING}_draw.py"
done

../voropadding \
  --input-receptor "./input/receptor_ligand/5zyg_receptor.pdb" \
  --input-ligand "./input/receptor_ligand/5zyg_ligand.sdf" \
  --max-padding 3 \
  --output-padding-file "./output/receptor_ligand_padding_table_5zyg_max_padding_3_only.tsv" \
  --only-padding-table


