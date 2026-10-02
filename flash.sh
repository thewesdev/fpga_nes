#!/bin/bash

mkdir -p logs

quartus_pgm -m jtag -o "p;compile/nes.sof" > logs/flash.log