#!/bin/bash

set -eu -o pipefail

OPENSCAD="/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"

for part in shell_a shell_b tpu_lining; do
    $OPENSCAD -o "$(dirname $0)/stl/tern_gsd_chain_wheel_${part}.stl" -D "EXPORT=\"$part\"" $(dirname $0)/tern_gsd_chain_wheel.scad
done