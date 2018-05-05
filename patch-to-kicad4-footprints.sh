#!/bin/bash

# apply patch, to use a path prefix for all models, 
repren --from " \(model ([A-Za-z0-9])" --to " (model \${KISYS3DMOD}/\1" ./*.pretty | tee -a log.txt
rm */*.orig


# and to use KICAD4_3D_DIR instead of KISYS3DMOD
repren --from KISYS3DMOD --to KICAD4_3D_DIR ./*.pretty | tee -a log.txt
rm */*.orig


