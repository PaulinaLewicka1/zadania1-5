if [ -n  "$a" ]; then
        if [ -n "$s" ]; then
                echo "$list" | awk '{for (i=0;i<NF;i++) {mb=$(i+1)*2^(i-8); sum+=mb; printf "%d %d %.2f\n", i, $(i+1), mb;}} END {printf "%.2f\n", sum;}'
        else
                echo "$list" | awk '{for (i=0;i<NF;i++) {mb=$(i+1)*2^(i-8); printf "%d %d %.2f\n", i, $(i+1), mb;}}'
        fi
elif [ -n "$1" ]; then
        if [ -n "$s" ]; then
                echo "$list" | awk -v order="$1" '{for (i=0;i<NF;i++) {mb=$(i+1)*2^(i-8); sum+=mb;} printf "%d %d %.2f\n", order, $(order+1), $(order+1)*2^(order-8);} END {printf "%.2f\n", sum;}'
        else
                echo "$list" | awk -v nr="$1" '{printf "%d %d %.2f\n", order, $(order+1), $(order+1)*2^(order-8);}'
        fi
fi
               
