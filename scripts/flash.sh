#!/bin/bash

set -e
set -o pipefail

script_dir=$(dirname "$(readlink -f "$0")")
root_dir=$(dirname "$script_dir")

cd "$root_dir"

mkdir -p logs

quartus_pgm -m jtag -o "p;compile/nes.sof" 2>&1 | tee logs/flash.log