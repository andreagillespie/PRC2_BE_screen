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
  bigwigs/input-k562-1x_S61.RPGC.bw bigwigs/k562-ezh2-RPGC.merged.bw \
  bigwigs/input-ezh2-164-1x_S62.RPGC.bw bigwigs/ezh2-164-ezh2-RPGC.merged.bw \
  bigwigs/input-5-1x_S63.RPGC.bw bigwigs/164-EZHIP-KO-ezh2-RPGC.merged.bw \
  bigwigs/EZH2-WT-2xInput_S86.RPGC.bw bigwigs/EZH2-WT-OE-2x-EZH2-RPGC.merged.bw \
  bigwigs/EZH2-677v-2xinput_S90.RPGC.bw bigwigs/EZH2-677v-2x-EZH2-RPGC.merged.bw \
  -R bed_files/K562_me3_peaks_genes.bed \
  -a 5000 \
  -b 5000 \
  -m 10000 \
  -o results/DTmatrix_EZH2_K562me3peakGenes_GR_merged.gz \
  -p max

plotHeatmap -m results/DTmatrix_EZH2_K562me3peakGenes_GR_merged.gz \
  --sortUsingSamples 2 \
  --sortUsing sum \
  --samplesLabel input-k562-1x k562-ezh2 \
  input-ezh2-164-1x ezh2-164-ezh2 \
  input-5-1x 164-EZHIP-KO-ezh2 \
  EZH2-WT-2xInput EZH2-WT-OE-2x-EZH2 \
  EZH2-677v-2xinput EZH2-677v-2x-EZH2 \
  --colorMap Oranges \
  --regionsLabel "K562me3 peak genes" \
  --heatmapHeight 15 \
  -o plots/Heatmap_EZH2_K562me3peakGenes_GR_merged.pdf \
  --plotTitle "EZH2 ChIPs over K562me3 peak genes, k562-EZH2 sorted"

plotProfile -m results/DTmatrix_EZH2_K562me3peakGenes_GR_merged.gz \
  --samplesLabel input-k562-1x k562-ezh2 \
  input-ezh2-164-1x ezh2-164-ezh2 \
  input-5-1x 164-EZHIP-KO-ezh2 \
  EZH2-WT-2xInput EZH2-WT-OE-2x-EZH2 \
  EZH2-677v-2xinput EZH2-677v-2x-EZH2 \
  --colors darkgray red darkgray orange darkgray gold \
  darkgray green darkgray blue \
  --plotHeight 15 \
  --regionsLabel "K562me3 peak genes" \
  --plotTitle "EZH2 ChIPs over K562me3 peak genes" \
  -o plots/Profile_EZH2_K562me3peakGenes_GR_merged.pdf \
  --perGroup 
