#!/bin/bash

#########################################
# Shell script to run doublets simulation
#########################################

# This script runs cellSNP and Vireo for the doublets simulations (using the 
# modified BAM file from the previous script "parse_BAM_doublets_X.sh").


# qsub -V -cwd -pe local 20 -l mem_free=2G,h_vmem=3G,h_fsize=100G run_cellSNP_Vireo_doublets.sh


# ----------------------------------------------------------
# Scenario 1: VCF from 1000 Genomes Project, filtered 3' UTR
# ----------------------------------------------------------

# run cellSNP

# note: more stable to run cellSNP interactively using qrsh instead of qsub
cellSNP \
-s ../../doublets/HGSOC/30pc/bam_merged_doublets_HGSOC_30pc.bam \
-b ../../doublets/HGSOC/30pc/barcodes_merged_HGSOC_30pc.tsv \
-O ../../doublets/HGSOC/30pc/genotype_1000genomes_filt/cellSNP \
-R ../../data/cellSNP/genome1K.phase3.SNP_AF5e2.chr1toX.hg38.threeUTRs.vcf \
-p 20 \
--minMAF=0.01 \
--minCOUNT=10

# run Vireo

# note: parameter for known number of samples (3 for HGSOC dataset, 6 for lung dataset)
vireo \
-c ../../doublets/HGSOC/30pc/genotype_1000genomes_filt/cellSNP \
-N 3 \
-o ../../doublets/HGSOC/30pc/genotype_1000genomes_filt/vireo \
--randSeed=123


# -------------------------------------------------------
# Scenario 2: VCF from 1000 Genomes Project, no filtering
# -------------------------------------------------------

# run cellSNP

# note: more stable to run cellSNP interactively using qrsh instead of qsub
cellSNP \
-s ../../doublets/HGSOC/30pc/bam_merged_doublets_HGSOC_30pc.bam \
-b ../../doublets/HGSOC/30pc/barcodes_merged_HGSOC_30pc.tsv \
-O ../../doublets/HGSOC/30pc/genotype_1000genomes_nofilt/cellSNP \
-R ../../data/cellSNP/genome1K.phase3.SNP_AF5e2.chr1toX.hg38.vcf \
-p 20 \
--minMAF=0.01 \
--minCOUNT=100

# run Vireo

# note: parameter for known number of samples (3 for HGSOC dataset, 6 for lung dataset)
vireo \
-c ../../doublets/HGSOC/30pc/genotype_1000genomes_nofilt/cellSNP \
-N 3 \
-o ../../doublets/HGSOC/30pc/genotype_1000genomes_nofilt/vireo \
--randSeed=123


# -----------------------------------------
# Scenario 3: VCF from matched bulk samples
# -----------------------------------------

# run cellSNP

# note: more stable to run cellSNP interactively using qrsh instead of qsub
cellSNP \
-s ../../doublets/HGSOC/30pc/bam_merged_doublets_HGSOC_30pc.bam \
-b ../../doublets/HGSOC/30pc/barcodes_merged_HGSOC_30pc.tsv \
-O ../../doublets/HGSOC/30pc/genotype_bulk/cellSNP \
-R ../../genotype_bulk/cellSNP_bulk_merged/cellSNP.cells-merged.vcf \
-p 20 \
--minMAF=0.01 \
--minCOUNT=10

# run Vireo

# note: parameter for known number of samples (3 for HGSOC dataset, 6 for lung dataset)
vireo \
-c ../../doublets/HGSOC/30pc/genotype_bulk/cellSNP \
-N 3 \
-o ../../doublets/HGSOC/30pc/genotype_bulk/vireo \
--randSeed=123


# --------------------------------------------------------------
# Scenario 4: VCF from matched bulk samples (without duplicates)
# --------------------------------------------------------------

# run cellSNP

# note: more stable to run cellSNP interactively using qrsh instead of qsub
cellSNP \
-s ../../doublets/HGSOC/30pc/bam_merged_doublets_HGSOC_30pc.bam \
-b ../../doublets/HGSOC/30pc/barcodes_merged_HGSOC_30pc.tsv \
-O ../../doublets/HGSOC/30pc/genotype_bulk_nodups/cellSNP \
-R ../../genotype_bulk/cellSNP_bulk_merged/cellSNP.cells-merged-nodups.vcf \
-p 20 \
--minMAF=0.01 \
--minCOUNT=10

# run Vireo

# note: parameter for known number of samples (3 for HGSOC dataset, 6 for lung dataset)
vireo \
-c ../../doublets/HGSOC/30pc/genotype_bulk_nodups/cellSNP \
-N 3 \
-o ../../doublets/HGSOC/30pc/genotype_bulk_nodups/vireo \
--randSeed=123


# ----------------------------------------------------------------------------------------------
# Scenario 5: combined VCF from bulk samples (no duplicates) and 1000 Genomes Project (filtered)
# ----------------------------------------------------------------------------------------------

# run cellSNP

# note: more stable to run cellSNP interactively using qrsh instead of qsub
cellSNP \
-s ../../doublets/HGSOC/30pc/bam_merged_doublets_HGSOC_30pc.bam \
-b ../../doublets/HGSOC/30pc/barcodes_merged_HGSOC_30pc.tsv \
-O ../../doublets/HGSOC/30pc/genotype_bulknodups_and_1000genomesfilt/cellSNP \
-R ../../genotype_bulknodups_and_1000genomesfilt/cellSNP.cells-combined.vcf \
-p 20 \
--minMAF=0.01 \
--minCOUNT=50

# run Vireo

# note: parameter for known number of samples (3 for HGSOC dataset, 6 for lung dataset)
vireo \
-c ../../doublets/HGSOC/30pc/genotype_bulknodups_and_1000genomesfilt/cellSNP \
-N 3 \
-o ../../doublets/HGSOC/30pc/genotype_bulknodups_and_1000genomesfilt/vireo \
--randSeed=123

