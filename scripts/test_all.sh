#!/bin/bash

shopt -s nullglob
set -e
set -o pipefail

# entra na root do projeto
script_dir=$(dirname "$(readlink -f "$0")")
root_dir=$(dirname "$script_dir")

cd "$root_dir"

tb_dir="testbench"
testbench=("$tb_dir"/*/)

# verifica se existem testbenchs
if [ ${#testbench[@]} -eq 0 ]; then
	echo "Nenhuma testbench em $tb_dir"
	exit 1
fi

for rd in "${testbench[@]}"; do
	if [ -n "$rd" ]; then
		d="${rd%/}"

		m_name="$(basename "$d")"

		tb_files=("$d"/tb_*.v)

		if [ ${#tb_files[@]} -eq 0 ]; then
			echo "nenhum tb encontrado em $d"
			continue
		fi

		for tb_file in ${#tb_files[@]}; do
			tb_name=$(basename "$tb_file" .v)
			echo "exec $tb_name"

			iverilog -g2012 -o "$d/$tb_name.vvp" "$tb_file" "src/$m_name.v"
			vvp "$d/$tb_name.vvp"
		done
	fi
done