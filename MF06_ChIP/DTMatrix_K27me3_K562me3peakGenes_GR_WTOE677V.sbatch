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
  bigwigs/EZH2-WT-OE-me3-RPGC.merged.bw \
  bigwigs/EZH2-677v-me3-RPGC.merged.bw \
  -R bed_files/K562_me3_peaks_genes.bed \
  -a 5000 \
  -b 5000 \
  -m 10000 \
  -o results/DTmatrix_K27me3_K562me3peakGenes_GR_WTOE677V.gz \
  -p max

plotHeatmap -m results/DTmatrix_K27me3_K562me3peakGenes_GR_WTOE677V.gz \
  --sortUsingSamples 1 \
  --sortUsing sum \
  --samplesLabel EZH2-WT-OE-me3 EZH2-677v-me3 \
  --colorMap Blues \
  --regionsLabel "K562me3 peak genes" \
  --heatmapHeight 15 \
  -o plots/Heatmap_K27me3_K562me3peakGenes_GR_WTOE677V.pdf \
  --plotTitle "K27me3 ChIPs over K562me3 peak genes, EZH2-WT-OE-me3 sorted"

plotProfile -m results/DTmatrix_K27me3_K562me3peakGenes_GR_WTOE677V.gz \
  --samplesLabel EZH2-WT-OE-me3 EZH2-677v-me3 \
  --colors red blue \
  --plotHeight 15 \
  --regionsLabel "K562me3 peak genes" \
  --plotTitle "K27me3 ChIPs over K562me3 peak genes" \
  -o plots/Profile_K27me3_K562me3peakGenes_GR_WTOE677V.pdf \
  --perGroup 
