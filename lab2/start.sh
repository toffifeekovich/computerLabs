#!/bin/bash
export LC_NUMERIC="C"

N=(400000000 600000000 800000000 1000000000 1200000000)

switches=("-O0" "-O1" "-O2" "-O3" "-Os" "-Ofast" "-Og" "-m64"
"-O0 -m32" "-O1 -m32" "-O2 -m32" "-O3 -m32" "-Os -m32" "-Ofast -m32"
"-Og -m32" "-m32"
)

echo "switch;40e7;60e7;80e7;10e8;12e8" > result.csv

for sw in "${switches[@]}"; do
	echo -n "${sw//-/_}" >> result.csv
	gcc $sw "computerlab1-1.c" -o "lab1${sw// /_}.out" -lm 
	for n in "${N[@]}";do
		echo -n ";" >> result.csv
		echo "Запуск c $sw с n=$n"		
                user_time=$(/usr/bin/time -p ./"lab1${sw// /_}.out" "$n" 2>&1 | grep "user" | awk '{print $2}')
        
                if [ -n "$user_time" ]; then
            		 formatted_time=$(printf "%.1f" "$user_time")
                else
              		 formatted_time="ERROR"
                fi

                echo -n "$formatted_time" >> result.csv
		echo "  -> $formatted_time секунд"
	done
	echo >> result.csv
done
echo "ГОТОВО!"
