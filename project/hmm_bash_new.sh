rm -rf *out*
./muscle3.8.31_i86linux64 -in PF00069_seed.txt -out PF00069_muscle_out
hmmbuild PF00069_hmmbuild_out.hmm PF00069_muscle_out
hmmpress PF00069_hmmbuild_out.hmm
hmmscan --tblout PF00069_hmmscan_out PF00069_hmmbuild_out.hmm PF00069_seed.txt
#hmmsearch --tblout PF00069_hmmsearch_out PF00069_hmmbuild_out.hmm PF00069_seed.txt
grep PF00069_muscle_out PF00069_hmmscan_out | awk '{ print $5 }' >> Evalue_out.txt
