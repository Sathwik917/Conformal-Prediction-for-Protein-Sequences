wc=$(wc -l < ./E0_value_out.txt)
sum=0
for i in $(seq 1 1 $wc)
do
	z1=$(sed -n "$i","$i p" E0_value_out.txt)
	echo $z1
	z2=$(sed -n "$i","$i p" ./singleoutfiles/Ei_value_out.txt)
	echo $z2
	diff=$(awk -v a=$z1 -v b=$z2 'BEGIN{print (a-b)}')
	echo " difference is $diff"
	sum=$(awk -v x=$sum -v y=$diff 'BEGIN{print (x+y)}')
	echo "sum is $sum"
done
echo $sum
sumf=$(printf "%0.40f" $sum)
Px=$(awk -v m=$sum -v n=38e0 'BEGIN{printf ("%1.5e\n"), (m/n)}')
echo $Px
#Pvalue=$(awk 'BEGIN{printf ("%.60f\n"), "($sum/38e0)"}')
#echo $Pvalue
