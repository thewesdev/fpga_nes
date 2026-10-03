#!/bin/bash

set -e
set -o pipefail

script_dir=$(dirname "$(readlink -f "$0")")
root_dir=$(dirname "$script_dir")

cd "$root_dir"

mkdir -p logs

quartus_sh -t setup.tcl 2>&1 | tee logs/setup.log
quartus_sh --flow compile nes 2>&1 | tee logs/compile.log