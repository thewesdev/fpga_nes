#!/bin/bash

set -e
set -o pipefail

mkdir -p logs

quartus_pgm -m jtag -o "p;compile/nes.sof" 2>&1 | tee logs/flash.log