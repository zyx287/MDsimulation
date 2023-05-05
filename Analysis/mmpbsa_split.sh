#!/bin/bash
#############MMGBSA-SPLIT################
name=1K659E
dir=/home/hipeson/data1/zhangyuxiang/FGFR2result/${name}
cd ${dir}
mkdir MMGBSAresult
for round in {1..1}
do
  echo "Processing ROUND${round}"
  cd ${dir}/ROUND${round}
  mkdir MMGBSA
  echo "Generating mdcrd file for ROUND${round}"
  cd MMGBSA
  cp /home/hipeson/data1/zhangyuxiang/MDtemple/CPPTRAJ/mdcrd.in .
  cpptraj -i mdcrd.in > mdcrd.txt &&
  echo "mdcrd file DONE"
  echo "Preparing Input file for ROUND${round}"
  cp -r ${dir}/MMPBSA/useful/* .
  move complex.prmtop complex_nosol.prmtop
  echo "Preparing Done"
  echo "Calculating MMGBSA_split using 30 CPU"
  cp /home/hipeson/data1/zhangyuxiang/MDtemple/MMGBSA/mmgbsa_split.in .
  nohup mpirun -np 30 MMPBSA.py.MPI -O -i mmgbsa_split.in -o MMGBSA_split.dat -do FINAL_DECOMP.dat -sp complex.prmtop -cp complex_nosol.prmtop -rp protein.prmtop -lp ligand.prmtop -y gamd.mdcrd > MMGBSAlog.txt &&
  echo "Calculating Done"
  mv FINAL_DECOMP.dat ${name}GBSAdecompROUND${round}.dat
  cp ${name}GBSAdecompROUND${round}.dat ${dir}/MMGBSAreslt
  echo "Copy Done" &&
  echo "###########################################"
done

