#!/bin/bash

mkdir -p logs

quartus_sh -t setup.tcl > logs/setup.log
quartus_sh --flow compile nes > logs/compile.log