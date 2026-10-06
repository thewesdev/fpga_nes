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
	exit 1
fi

PS3="tb: "

select rd in "${testbench[@]}"; do
	if [ -n "$rd" ]; then
		d="${rd%/}"

		m_name="$(basename "$d")"

		tb_files=("$d"/tb_*.v)

		if [ ${#tb_files[@]} -eq 0 ]; then
			echo "nenhum tb encontrado em $d"
		else
			PS3="wave: "

			tb_names=("${tb_files[@]##*/}")
			select tb_f in "${tb_names[@]}"; do
				if [ -n "$tb_f" ]; then
					tb_name=$(basename "$tb_f" .v)
					iverilog -g2012 -o "$d/$tb_name.vvp" "$d/$tb_f" "src/enable_pulse.v" "src/$m_name.v"
					(cd "$d" && vvp "$tb_name.vvp" > /dev/null)
					gtkwave "$d/$tb_name.vcd" > /dev/null 2>&1
					break
				else
					echo "opção inválida"
				fi
			done
		fi

		break
	else
		echo "opção inválida!"
	fi
done