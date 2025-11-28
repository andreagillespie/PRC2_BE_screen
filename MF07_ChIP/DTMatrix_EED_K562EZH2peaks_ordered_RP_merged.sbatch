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
  bigwigs/k562-2x-eed-RPGC.merged.bw \
  bigwigs/eed19-2x-eed-RPGC.merged.bw \
  -R bed_files/K562_EZH2_peaks_ordered.bed\
  -a 5000 \
  -b 5000 \
  -o results/DTmatrix_EED_K562EZH2peaks_ordered_RP_merged.gz \
  -p max

plotHeatmap -m results/DTmatrix_EED_K562EZH2peaks_ordered_RP_merged.gz \
  --sortRegions keep \
  --samplesLabel k562-2x-eed eed19-2x-eed \
  --colorMap Purples \
  --regionsLabel "K562 EZH2 peaks" \
  --heatmapHeight 15 \
  -o plots/Heatmap_EED_K562EZH2peaks_ordered_RP_merged.pdf \
  --plotTitle "EED ChIPs over K562 EZH2 peaks, K562-EZH2 sorted"

plotProfile -m results/DTmatrix_EED_K562EZH2peaks_ordered_RP_merged.gz \
  --samplesLabel k562-2x-eed eed19-2x-eed \
  --colors red blue \
  --plotHeight 15 \
  --regionsLabel "K562 EZH2 peaks" \
  --plotTitle "EED ChIPs over K562 EZH2 peaks" \
  -o plots/Profile_EED_K562EZH2peaks_ordered_RP_merged.pdf \
  --perGroup 
