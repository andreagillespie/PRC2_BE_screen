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

computeMatrix reference-point --referencePoint center -S \
  bigwigs/k562-2x-ezh2-RPGC.merged.bw \
  bigwigs/eed19-ezh2-RPGC.merged.bw \
  -R macs/broadpeaks/k562-2x-ezh2_peaks.broadPeak \
  -a 5000 \
  -b 5000 \
  -o results/DTmatrix_EZH2_K562EZH2peaks_RP_merged.gz \
  -p max

plotHeatmap -m results/DTmatrix_EZH2_K562EZH2peaks_RP_merged.gz \
  --sortUsingSamples 1 \
  --sortUsing sum \
  --samplesLabel k562-2x-ezh22 eed19-ezh2 \
  --colorMap Oranges \
  --regionsLabel "K562 EZH2 peaks" \
  --heatmapHeight 15 \
  -o plots/Heatmap_EZH2_K562EZH2peaks_RP_merged.pdf \
  --outFileSortedRegions bed_files/K562_EZH2_peaks_ordered.bed \
  --plotTitle "EZH2 ChIPs over K562 EZH2 peaks, K562-EZH2 sorted"

plotProfile -m results/DTmatrix_EZH2_K562EZH2peaks_RP_merged.gz \
  --samplesLabel k562-2x-ezh22 eed19-ezh2 \
  --colors red blue \
  --plotHeight 15 \
  --regionsLabel "K562 EZH2 peaks" \
  --plotTitle "EZH2 ChIPs over K562 EZH2 peaks" \
  -o plots/Profile_EZH2_K562EZH2peaks_RP_merged.pdf \
  --perGroup 
