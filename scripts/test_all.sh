#!/bin/bash

shopt -s nullglob
set -e
set -o pipefail

failed=0
pass_count=0
failed_count=0

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
			echo "nenhum tb encontrado em $d\n"
			continue
		fi

		for tb_file in "${tb_files[@]}"; do
			tb_name=$(basename "$tb_file" .v)
			echo -e "\nexec $tb_name\n"

			if ! iverilog -g2012 -o "$d/$tb_name.vvp" "$tb_file" "src/enable_pulse.v" "src/$m_name.v"; then
				echo "\nFAIL: compilação de $tb_name\n"
				failed=1
				failed_count=$((failed_count + 1))
				continue
			fi

			if (cd "$d" && vvp "$tb_name.vvp"); then
				echo -e "\nPASS: $tb_name\n"
				pass_count=$((pass_count + 1))
			else
				echo -e "\nFAIL: simulação de $tb_name\n"
				failed=1
				failed_count=$((failed_count + 1))
			fi
		done
	fi
done

echo "$pass_count passaram, $failed_count falharam"

exit "$failed"