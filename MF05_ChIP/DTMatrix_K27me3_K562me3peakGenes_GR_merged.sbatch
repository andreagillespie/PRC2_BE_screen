#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=48G
#SBATCH --time=1-00:00:00
#SBATCH --output=logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="DTMatrix"
#SBATCH --partition=rhel_short

module load py-deeptools/3.5.3-gcc-13.2.0

computeMatrix scale-regions -S \
  bigwigs/k562-me3-RPGC.merged.bw \
  ../MF06_ChIP/bigwigs/Original-input-1_S79.RPGC.bw bigwigs/EZH2-WT-RPGC.merged.bw \
  ../MF06_ChIP/bigwigs/Original-input-2_S80.RPGC.bw bigwigs/EZH2-677V-RPGC.merged.bw \
  ../MF06_ChIP/bigwigs/Original-input-3_S81.RPGC.bw bigwigs/EZH2-677V-WT-RPGC.merged.bw \
  ../MF06_ChIP/bigwigs/Original-input-4_S82.RPGC.bw bigwigs/EZH2-677G-WT-RPGC.merged.bw \
  ../MF06_ChIP/bigwigs/Original-input-5_S83.RPGC.bw bigwigs/EZH2-641-WT-RPGC.merged.bw \
  -R ../MF06_ChIP/bed_files/K562_me3_peaks_genes.bed \
  -a 5000 \
  -b 5000 \
  -m 10000 \
  -o results/DTmatrix_K27me3_RPGC_K562me3peakGenes_GR_merged.gz \
  -p max

plotHeatmap -m results/DTmatrix_K27me3_RPGC_K562me3peakGenes_GR_merged.gz \
  --sortUsingSamples 1 \
  --sortUsing sum \
  --samplesLabel k562-me3 \
  Original-input-1 EZH2-WT \
  Original-input-2 EZH2-677V \
  Original-input-3 EZH2-677V-WT \
  Original-input-4 EZH2-677G-WT \
  Original-input-5 EZH2-641-WT \
  --colorMap Blues \
  --regionsLabel "MF06 K562me3 peak genes" \
  --heatmapHeight 15 \
  -o plots/Heatmap_K27me3_DmNorm_K562me3peakGenes_GR_merged.pdf \
  --plotTitle "K27me3 ChIPs over MF06 K562me3 peak genes, k562-me3 sorted, RPGC normalised"

plotProfile -m results/DTmatrix_K27me3_RPGC_K562me3peakGenes_GR_merged.gz \
 --samplesLabel k562-me3 \
  Original-input-1 EZH2-WT \
  Original-input-2 EZH2-677V \
  Original-input-3 EZH2-677V-WT \
  Original-input-4 EZH2-677G-WT \
  Original-input-5 EZH2-641-WT \
  --colors red darkgray orange darkgray gold \
  darkgray green darkgray blue darkgray purple \
  --plotHeight 15 \
  --regionsLabel "MF06 K562me3 peak genes" \
  --plotTitle "K27me3 ChIPs over MF06 K562me3 peak genes, Dm normalised" \
  -o plots/Profile_K27me3_DmNorm_K562me3peakGenes_GR_merged.pdf \
  --perGroup 
