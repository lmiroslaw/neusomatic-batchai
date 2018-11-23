#!/bin/bash

datadir=/mnt/bigdata
workdir=$datadir/output_dir/AJT_test
storaccname=yourstoragename

## PREPARE
mkdir -p $workdir
cd ~/neusomatic

if [ -z "$(ls -A $workdir)" ]; then
   echo "Empty $workdir directory"
else
   echo "Not Empty"
   exit
fi

## PREPROCESS
#echo "Run Preprocessing"
time python neusomatic/python/preprocess.py \
--mode train \
--reference $datadir/reference/human_g1k_v37_decoy/human_g1k_v37_decoy.fasta \
--region_bed $datadir/AJT_test/region.bed \
--tumor_bam $datadir/AJT_test/HG004.70T30N.md.bam \
--normal_bam  $datadir/AJT_test/HG003.5T95N.md.bam \
--work $workdir \
--scan_maf 0.01 \
--truth_vcf $datadir/AJT_test/truth_fixed.vcf \
--min_mapq 10 \
--snp_min_af 0.03 \
--snp_min_bq 20 \
--snp_min_ao 3 \
--ins_min_af 0.02 \
--del_min_af 0.02 \
--num_threads 6 \
--scan_alignments_binary neusomatic/bin/scan_alignments
 

