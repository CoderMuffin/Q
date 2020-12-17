acc=0;function goto { label=$1;cmd=$(sed -n '/^:[[:blank:]][[:blank:]]*${label}/{:a;n;p;ba};' q.sh | grep -v ':$');eval '$cmd';exit; };
read acc;echo $acc;goto  2;