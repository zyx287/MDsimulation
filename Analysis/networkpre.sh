#!/bin/bash
##################NetworkPrepare#########################
echo "complex-dele.prmtop, complex-dele.psf and gamd-dele.nc processing"
name=1K659E
dir=/home/hipeson/data1/zhangyuxiang/FGFR2result/${name}
for round in {1..3}
do
  cd ${dir}/ROUND${round}
  mkdir NetworkPre
  echo "Processing Pre"
  cd NetworkPre
  cp /home/hipeson/data1/zhangyuxiang/MDtemple/CPPTRAJ/network_prepare.in .
  cpptraj -i network_prepare.in > network_prepare.txt &&
  echo "Processing Done"
done
cd ${dir}
echo "Prepare Done" > final.txt &&
echo "DONE" | mail -s "DONE" zyx_287@sjtu.edu.cn < /${dir}/final.txt

