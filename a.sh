n=3
file=
while getopts ":f:n:" opt
do
        case $opt in
                f) file="$OPTARG";;
                n) n="$OPTARG";;
                *) echo "opcja nieprawidlowa: -$OPTARG"
                        exit 1;;
        esac
done

shift $((OPTIND-1))

if [ -n "$file" ]; then
        pslist=$(sed 1d "$file");
else
        pslist=$(ps -eo user,vsz,rsz,pcpu,comm | sed 1d);
fi

echo "CPU hogs:"
echo "$pslist" | sort -rn -k4 | head -n"$n" | tr -s ' ' | cut -d' ' -f 1,4,5 | awk'{printf "%10s %16s %16s\n", $1, $2, $3;}'

echo
echo "RES hogs:"
echo "$pslist" | sort -rn -k3 | head -n"$n" | tr -s ' ' | cut -d' ' -f 1,3,5 | awk'{printf "%10s %16s %16s\n", $1, $2, $3;}'

echo
echo "VIRT hogs:"
echo "$pslist" | sort -rn -k2 | head -n"$n" | tr -s ' ' | cut -d' ' -f 1,2,5 | awk'{printf "%10s %16s %16s\n", $1, $2, $3;}'

