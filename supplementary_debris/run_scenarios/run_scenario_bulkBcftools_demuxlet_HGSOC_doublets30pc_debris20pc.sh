#!/bin/bash
#$ -cwd
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


# --------------------------------------------------
# Scenario: bulk samples VCF from bcftools, demuxlet
# --------------------------------------------------

mkdir -p ../../../supplementary_debris/scenarios/HGSOC/30pc/debris20pc/bulkBcftools_demuxlet

# run demuxlet

demuxlet \
--sam ../../../supplementary_debris/scenarios/HGSOC/30pc/bam_merged_HGSOC_doublets30pc_debris20pc.bam \
--group-list ../../../supplementary_debris/scenarios/HGSOC/30pc/barcodes_merged_HGSOC_doublets30pc_debris20pc.tsv \
--alpha 0 --alpha 0.5 \
--vcf ../../../genotype/bcftools/bcftools_HGSOC_rehead.vcf \
--field GT \
--out ../../../supplementary_debris/scenarios/HGSOC/30pc/debris20pc/bulkBcftools_demuxlet/demuxlet


# end runtime
end=`date +%s`
runtime=`expr $end - $start`

# save runtime
mkdir -p ../../../supplementary_debris/scenarios/HGSOC/30pc/debris20pc/bulkBcftools_demuxlet/runtimes
echo runtime: $runtime seconds > ../../../supplementary_debris/scenarios/HGSOC/30pc/debris20pc/bulkBcftools_demuxlet/runtimes/runtime_bulkBcftools_demuxlet_HGSOC_doublets30pc_debris20pc.txt

