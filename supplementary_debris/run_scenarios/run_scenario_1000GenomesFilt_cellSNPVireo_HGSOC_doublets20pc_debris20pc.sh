#!/bin/bash
#$ -cwd
#$ -pe local 4
#$ -l mem_free=5G,h_vmem=6G,h_fsize=100G


################################################
# Shell script to run debris simulation scenario
################################################

# These scripts run the selected demultiplexing tool (e.g. cellSNP/Vireo) for a 
# given debris simulation scenario (VCF file, dataset, percent doublets, percent 
# debris).

# Requires the modified BAM file from the previous script "parse_BAM_X_debris.sh".


# start runtime
start=`date +%s`


# ----------------------------------------------------------
# Scenario: 1000 Genomes Project VCF filtered, cellSNP/Vireo
# ----------------------------------------------------------

# run cellSNP

mkdir -p ../../../supplementary_debris/scenarios/HGSOC/20pc/debris20pc/1000GenomesFilt_cellSNPVireo

# using recommended parameters for cellSNP
cellsnp-lite \
-s ../../../supplementary_debris/scenarios/HGSOC/20pc/bam_merged_HGSOC_doublets20pc_debris20pc.bam \
-b ../../../supplementary_debris/scenarios/HGSOC/20pc/barcodes_merged_HGSOC_doublets20pc_debris20pc.tsv \
-O ../../../supplementary_debris/scenarios/HGSOC/20pc/debris20pc/1000GenomesFilt_cellSNPVireo/cellSNP \
-R ../../../data/cellSNP/genome1K.phase3.SNP_AF5e2.chr1toX.hg38.threeUTRs.vcf \
-p 4 \
--minMAF=0.1 \
--minCOUNT=20 \
--gzip


# end runtime
end=`date +%s`
runtime=`expr $end - $start`

# save runtime
mkdir -p ../../../supplementary_debris/scenarios/HGSOC/20pc/debris20pc/1000GenomesFilt_cellSNPVireo/runtimes
echo runtime: $runtime seconds > ../../../supplementary_debris/scenarios/HGSOC/20pc/debris20pc/1000GenomesFilt_cellSNPVireo/runtimes/runtime_1000GenomesFilt_cellSNPVireo_cellSNP_HGSOC_doublets20pc_debris20pc.txt

# start runtime
start=`date +%s`


# run Vireo

# note parameter for known number of samples (3 for HGSOC dataset, 6 for lung dataset)
vireo \
-c ../../../supplementary_debris/scenarios/HGSOC/20pc/debris20pc/1000GenomesFilt_cellSNPVireo/cellSNP \
-N 3 \
-o ../../../supplementary_debris/scenarios/HGSOC/20pc/debris20pc/1000GenomesFilt_cellSNPVireo/vireo \
--randSeed=123


# end runtime
end=`date +%s`
runtime=`expr $end - $start`

# save runtime
mkdir -p ../../../supplementary_debris/scenarios/HGSOC/20pc/debris20pc/1000GenomesFilt_cellSNPVireo/runtimes
echo runtime: $runtime seconds > ../../../supplementary_debris/scenarios/HGSOC/20pc/debris20pc/1000GenomesFilt_cellSNPVireo/runtimes/runtime_1000GenomesFilt_cellSNPVireo_vireo_HGSOC_doublets20pc_debris20pc.txt

