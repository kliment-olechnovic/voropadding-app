# About VoroPadding

VoroPadding is method to calculate how much space is available for atoms to occupy around a selected part of the molecular
structure (e.g. a ligand). VoroPadding pads (fills up the space around) the selected part of the input molecule (e.g. a ligand)
and then calculates the total available volume and the total interface area of the padded part.

This repository provides an alpha version of VoroPadding app.

# Obtaining and setting up VoroPadding

## Getting the latest version

The currently recommended way to obtain VoroPadding is cloning the VoroPadding git repository [https://github.com/kliment-olechnovic/voropadding-app](https://github.com/kliment-olechnovic/voropadding-app):

```bash
git clone https://github.com/kliment-olechnovic/voropadding-app.git
cd ./voropadding-app
```

## Setting up an environment for running VoroPadding

VoroPadding comes with statically built binaries for Linux in the 'tools' subdirectory.

The source code for the compilable software is included, and can be used to build all the needed executable with the following single command: 

```bash
./tools/build-all.bash
```

VoroPadding does not require any setup apart from an optional rebuilding of the executable binaries in the 'tools' subdirectory.


# Running the VoroPadding command-line tool

The overview of command-line options, as well as input and output, is printed when running the "voropadding" executable with "--help" or "-h" flags:

```bash
./voropadding --help

./voropadding -h
```

The following is the help message output:

```

'voropadding' script pads (fills up the space around) the selected part of the input molecule (e.g. a ligand)
and then calculates the total available volume and the total interface area of the padded part.

Options:
    --input                       string  *  input file path for a molecule, must be in PDB or mmCIF format
    --selection                   string     selection of the structural part to pad and analyze, default is '(not [-protein])'
    --max-padding                 number     maximum number of padding layers, default is 2
    --restriction-centers         string     selection of the atoms to be used as centers of the restriction spheres, default is ''
    --restriction-radius          number     radius to be used for the restriction spheres (if any), default is 10.0
    --output-table-file           string     output table file path, default is '_stdout' to print to stdout
    --output-graphics-file        string     output file path for the PyMol drawing script, default is ''
    --graphics-mode               string     graphics output mode, may be 'basic' or 'detailed', default is 'basic'
    --print-mode                  string     printing to stdout mode, can be 'h' or 'v', default is 'h'
    --help | -h                              flag to display help message and exit

Standard output:
    space-separated table of values

Examples:

    voropadding --input "./complex.pdb"

    voropadding --input "./complex.pdb" --selection '[-chain B]' 

    voropadding --input "./complex.pdb" --restriction-centers '[-chain A -rnum 30 -aname CB]' --restriction-radius 12.0

    voropadding --input "./complex.pdb" --max-padding 3 --output-graphics-file "./padded.py"

```

# Output examples

## Basic example

Running

```bash
./voropadding \
  --input "./tests/input/5zyg.pdb" \
  --output-graphics-file "./vis_5zyg.py" \
  --print-mode v
```

gives

```
input                5zyg.pdb
volume_freedom_coef  4.49694
iface_freedom_coef   2.10274
volume_padded        1695.58
iface_area_padded    1027.75
volume_unpadded      674.586
iface_area_unpadded  488.766
sasa_unpadded        41.4579
volume_vdw           377.052
atoms_count          30
max_padding          2
```

The values are explained below:

* `input` is the basename of the provided input file
* `volume_freedom_coef` is the ratio value = `(volume_padded/volume_vdw)`
* `iface_freedom_coef`  is the ratio value = `(iface_area_padded/iface_area_unpadded)`
* `volume_padded` is the Voronoi tessellation-based volume of the ligand together with the padding
* `iface_area_padded` is the Voronoi tessellation-based total area of the interface between the receptor on one side, and the ligand and its padding on the other side
* `volume_unpadded` is the total volume of the Voronoi cells of the lingand atoms constrained inside the solvent-accessible surface
* `iface_area_unpadded` is the total area of the Voronoi faces (constrained inside the solvent-accessible surface) between the receptor and the ligand
* `volume_unpadded` is the total solvent accessible surface area of the Voronoi cells of the lingand atoms constrained inside the solvent-accessible surface
* `volume_vdw` is the volume of the union of the ligand atomic balls of van der Waals radii
* `atoms_count` is the number of the ligand atoms
* `max_padding` is the maximum number of padding layers considered by the scripts

The generated `vis_5zyg.py` can be opened in PyMol by its own, or together with the input structure:

```bash
pymol ./tests/input/5zyg.pdb ./vis_5zyg.py
```

which allows visualizations similar to the ones below:

![](./doc/visual_example1.png)

![](./doc/visual_example2.png)


## Example with additional restrictions

A user may specify a selection of an atom (or atoms) and a maximum allowed distance from the centers of the selected atoms.
This is useful for cases where there is a covalently bound ligand.
Note that if multiple atoms are selected, then multiple restrictions are combined using the `AND` logical operation, not `OR`.

Below is an example of running with additional restrictions:

```bash
./voropadding \
  --input "./tests/input/1cnw.pdb" \
  --selection '[-chain A -rnum 555]' \
  --restriction-centers '[-chain A -rnum 262 -aname ZN]' \
  --restriction-radius 16.0 \
  --output-graphics-file "./vis_1cnw.py" \
  --print-mode v
```

which produces the following output:

```bash
input                1cnw.pdb
volume_freedom_coef  5.67799
iface_freedom_coef   1.91799
volume_padded        1728.97
iface_area_padded    585.138
volume_unpadded      683.218
iface_area_unpadded  305.078
sasa_unpadded        233.052
volume_vdw           304.504
atoms_count          26
max_padding          2
```

and the following visualization:

![](./doc/visual_example3.png)

