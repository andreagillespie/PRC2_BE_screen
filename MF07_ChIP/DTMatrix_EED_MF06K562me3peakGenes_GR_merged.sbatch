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
  bigwigs/eed19-2x-input_S21.RPGC.bw \
  bigwigs/k562-2x-eed-RPGC.merged.bw \
  bigwigs/eed19-2x-eed-RPGC.merged.bw \
  -R ../MF06_ChIP/bed_files/K562_me3_peaks_genes.bed \
  -a 5000 \
  -b 5000 \
  -m 10000 \
  -o results/DTmatrix_EED_MF06K562me3peakGenes_GR_merged.gz \
  -p max

plotHeatmap -m results/DTmatrix_EED_MF06K562me3peakGenes_GR_merged.gz \
  --sortUsingSamples 2 \
  --sortUsing sum \
  --samplesLabel eed19-2x-input k562-2x-eed eed19-2x-eed \
  --colorMap Purples \
  --regionsLabel "K562me3 peak genes" \
  --heatmapHeight 15 \
  -o plots/Heatmap_EED_MF06K562me3peakGenes_GR_merged.pdf \
  --plotTitle "EED ChIPs over MF06 K562me3 peak genes, K562-EED sorted"

plotProfile -m results/DTmatrix_EED_MF06K562me3peakGenes_GR_merged.gz \
  --samplesLabel eed19-2x-input k562-2x-eed eed19-2x-eed \
  --colors darkred red blue \
  --plotHeight 15 \
  --regionsLabel "K562me3 peak genes" \
  --plotTitle "EED ChIPs over MF06 K562me3 peak genes" \
  -o plots/Profile_EED_MF06K562me3peakGenes_GR_merged.pdf \
  --perGroup 
