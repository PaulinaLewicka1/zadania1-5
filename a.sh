if [ -n  "$a" ]; then
        if [ -n "$s" ]; then
                echo "$list" | awk '{for (i=0;i<NF;i++) {mb=$(i+1)*2^(i-8); sum+=mb; printf "%d %d %.2f\n", i, $(i+1), mb;}} END {printf "%.2f\n", sum;}'
        else
                echo "$list" | awk '{for (i=0;i<NF;i++) {mb=$(i+1)*2^(i-8); printf "%d %d %.2f\n", i, $(i+1), mb;}}'
        fi
