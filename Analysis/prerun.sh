#!/bin/bash
#############GaMDpreRUN################
echo "CPUcMD Runing"
nohup pmemd -O -i cmdcpu.in -o cmdcpu.out -c equil.rst -r cmdcpu.rst -x cmdcpu.nc -p wt.prmtop > nohupcmdcpu.out 2>&1 &&
echo "CPUcMD Done"
echo"export CUDA_VISIBLE_DEVICES=03"
export CUDA_VISIBLE_DEVICES=03 &&
echo "cMD1 Running"
nohup pmemd.cuda -O -i cmd.in -o cmd1.out -c cmdcpu.rst -r cmd1.rst -x cmd1.nc -p wt.prmtop > nohupcmd1.out 2>&1 &&
echo"cMD1 Done"
echo "MDcollect Running"
nohup pmemd.cuda -O -i mdcollect.in -o collect.out -c cmd1.rst -r collect.rst -x collect.nc -p wt.prmtop > mohupmdcollect.out 2>&1 &&
echo "MDcollect Done"&&
echo "Pre-RUN Done" | mail -s "Pre-RUN DONE" zyx_287@sjtu.edu.cn < /home/hipeson/data1/zhangyuxiang/MAIL/pre-run-done.txt
