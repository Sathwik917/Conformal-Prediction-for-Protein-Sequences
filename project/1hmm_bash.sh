./muscle3.8.31_i86linux64 -in PF00069_seed.txt -out PF00069_muscle_out
#hmmbuild PF00069_hmmbuild_out.hmm PF00069_muscle_out
#hmmpress PF00069_hmmbuild_out.hmm
#hmmscan -o hmmscan_out PF00069_hmmbuild_out.hmm pf69sampleseq.txt
