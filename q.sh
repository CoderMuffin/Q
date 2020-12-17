qcod=$1

echo "Translating Q into pure Q..."
(
while IFS= read -r line
do
re='(.*)[^Q0-9 ](.*)'
while [[ $line =~ $re ]]; do
  line=${BASH_REMATCH[1]}${BASH_REMATCH[2]}
done
echo $line
done < "$qcod"
) > main.pq

echo "Translating pure Q into bash..."
(
    printf "acc=0;function goto { label=\$1;cmd=\$(sed -n '/^:[[:blank:]][[:blank:]]*\${label}/{:a;n;p;ba};' $0 | grep -v ':\$');eval '\$cmd';exit; };\n";
    while IFS= read -r line
    do
        case "$line" in
            "QQQ"*) printf "goto ${line//Q/};";;
            "QQ") printf "read acc;";;
            "Q") printf "echo \$acc;";;
        esac
    done < main.pq
) > $2

echo "Cleaning up..."
rm main.pq
echo "Done!"
#if [[ $qcod =~ ^(Q* )*$ ]]; then