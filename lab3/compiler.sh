#!/bin/bash
export LC_NUMERIC="C"

switches=("-O0" "-O1" "-O2" "-O3" "-Os" "-Ofast" "-Og" "-m64" \
"-O0 -m32" "-O1 -m32" "-O2 -m32" "-O3 -m32" "-Os -m32" "-Ofast -m32" \
"-Og -m32" "-m32"
)

for sw in "${switches[@]}"; do
	gcc $sw "computerlab3.c" -o "lab3${sw// /_}.out" -lm 

done
echo "ГОТОВО!"
