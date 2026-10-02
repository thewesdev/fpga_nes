#!/bin/bash

set -e
set -o pipefail

mkdir -p logs

quartus_sh -t setup.tcl 2>&1 | tee logs/setup.log
quartus_sh --flow compile nes 2>&1 | tee logs/compile.log