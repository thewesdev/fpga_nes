#!/bin/bash

shopt -s nullglob
set -e
set -o pipefail

script_dir=$(dirname "$(readlink -f "$0")")
root_dir=$(dirname "$script_dir")

cd "$root_dir"

tb_dir="testbench"
testbench=("$tb_dir"/*/)

if [ ${#testbench[@]} -eq 0 ]; then
	echo "Nenhuma testbench em $tb_dir"
	exit 0
fi