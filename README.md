kicad4-footprints
=================

This library provides a workaround to an incompatibility issue between KiCad 4 and KiCad 5, discussed here: https://github.com/KiCad/kicad-footprints/issues/503

The origin of this repository all the Git repos for KiCad V4 library downloaded with 
```
kicad-library-utils./download_pretty_libs.py -p ../kicad4-footprints/ 
```
on 3rd of May, 2018. They are deprecated, but can be useful with existing projects. 


## Do you need this?
You only want to use this library, if you want to port KiCad 4 projects to KiCad 5, and still want to use the footprints and according 3D models from lib v4.

## The two major issues
1. KiCad 5 doesn't use the implicit prefix KISYS3DMOD any more. This breaks the link to the according 3D models of about 20% of all footprints in the library v4. 
2. KiCad 5 uses by default the same prefix KISYS3DMOD for the path to it's 3D models. But the 3D-library for version 4 isn't compatible with v5 (other namings, other directories). 

## How we solved them
1. We added a path prefix to all links to the 3D-models in the `*.kicad_mod` files.
2. We renamed that prefix from `KISYS3DMOD` to `KICAD4_3D_DIR`


## Installation
1. Download/clone this repository wherever you like it to be. 
2. copy'n'paste the file `fp-lib-table` into your KiCad's config folder or integrate it into your existing fp-lib-table. 
3. To be sure to use the same revision of 3D models, that match to the provided footprints here, download them from here: http://downloads.kicad-pcb.org/libraries/kicad-library-4.0.7.tar.gz
   We suggest to move the content of packages3d into a folder called kicad4-packages3D and that of the symbols library folder into a folder called kicad4-symbols, according to the new lib v5. 
4. Edit your file `kicad_common` from the KiCad 4 config folder. Add entries for
   `KICAD4_3D_DIR=/home/<insert-your-path-here>/kicad4-packages3D`
   `KICAD4_FOOTPRINTS_DIR=/home/<insert-your-path-here>/kicad4-footprints`
   Optionally you could also add 
   `KICAD4_SYMBOLS_DIR=/home/<insert-your-path-here>/kicad4-symbols`
   
Please note, that you should add these environment variables to both of your KiCad configs (KiCad 4 and KiCad 5). 


## Consequences
* Every existing project, that has been using the libs v4 must reload it's footprints, so the paths to the 3D models get updated. 
  I recommend to use the kicad-models-updater: https://github.com/KarlZeilhofer/kicad-models-updater
* If you have your own footprint library, which uses KiCad's 3D models (version 4), you have to replace the KISYS3DMOD there too. You can use https://github.com/jlevy/repren to do this:
  `repren --from " \(model ([A-Za-z0-9])" --to " (model \${KISYS3DMOD}/\1" .`
  `repren --from KISYS3DMOD --to KICAD4_3D_DIR .`
  `rm */*.orig`