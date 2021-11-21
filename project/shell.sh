rm -rf *out*
./muscle3.8.31_i86linux64 -in PF00069_seed.txt -out PF00069_muscle_out
hmmbuild PF00069_hmmbuild_out.hmm PF00069_muscle_out
hmmpress PF00069_hmmbuild_out.hmm
hmmscan --tblout PF00069_hmmscan_out PF00069_hmmbuild_out.hmm PF00069_seed.txt
#hmmsearch --tblout PF00069_hmmsearch_out PF00069_hmmbuild_out.hmm PF00069_seed.txt
grep PF00069_muscle_out PF00069_hmmscan_out | awk '{ print $5 }' >> E0_value_out.txt


mkdir singleoutfiles
rm -rf ./singleoutfiles/*
wc=$(wc -l < ./PF00069_seed.txt)
for i in $(seq 1 7 $wc); 
do
        let inc=$i+6;
	let quit=$inc+1;	
	sed -e "$i","$inc d" PF00069_seed.txt >> ./singleoutfiles/PF69_exclude_out$i.txt
	./muscle3.8.31_i86linux64 -in ./singleoutfiles/PF69_exclude_out$i.txt -out ./singleoutfiles/PF69_muscle_out$i
	chmod ugo+rwx ./singleoutfiles/*
	hmmbuild ./singleoutfiles/PF69_hmmbuild_out$i ./singleoutfiles/PF69_muscle_out$i
	chmod ugo+rwx ./singleoutfiles/*
	hmmpress ./singleoutfiles/PF69_hmmbuild_out$i
	chmod ugo+rwx ./singleoutfiles/*
	sed -n "$i","$inc p" PF00069_seed.txt >> ./singleoutfiles/PF69_seq_out$i.txt
	chmod ugo+rwx ./singleoutfiles/*
	hmmscan --tblout ./singleoutfiles/PF69_hmmscan_out$i ./singleoutfiles/PF69_hmmbuild_out$i ./singleoutfiles/PF69_seq_out$i.txt
	chmod ugo+rwx ./singleoutfiles/*
        grep PF69_muscle_out$i ./singleoutfiles/PF69_hmmscan_out$i | awk '{ print $5 }' >> ./singleoutfiles/Ei_value_out.txt
done

wc=$(wc -l < ./E0_value_out.txt)
sum=0
for i in $(seq 1 1 $wc)
do
	        z1=$(sed -n "$i","$i p" E0_value_out.txt)
		#echo $z1
		z2=$(sed -n "$i","$i p" ./singleoutfiles/Ei_value_out.txt)
		#echo $z2
		diff=$(awk -v a=$z1 -v b=$z2 'BEGIN{print (a-b)}') 
		echo $diff >> diff.txt
		#echo " difference is $diff"
		sum=$(awk -v x=$sum -v y=$diff 'BEGIN{print (x+y)}')
		#echo "sum is $sum"
done
echo $sum

Px=$(awk -v m=$sum -v n=38e0 'BEGIN{printf ("%1.5e\n"), (m/n)}')
echo "P value is $Px"
