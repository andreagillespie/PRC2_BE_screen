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
  -R macs/broadpeaks/eed19-2x-eed_peaks.broadPeak \
  -a 5000 \
  -b 5000 \
  -o results/DTmatrix_EED_EED19EEDpeaks_RP_merged.gz \
  -p max

plotHeatmap -m results/DTmatrix_EED_EED19EEDpeaks_RP_merged.gz \
  --sortUsingSamples 2 \
  --sortUsing sum \
  --samplesLabel k562-2x-eed eed19-2x-eed \
  --colorMap Purples \
  --regionsLabel "EED-19 EED peaks" \
  --heatmapHeight 15 \
  -o plots/Heatmap_EED_EED19EEDpeaks_RP_merged.pdf \
  --outFileSortedRegions bed_files/EED19_EED_peaks_ordered.bed \
  --plotTitle "EED ChIPs over EED-19 EED peaks, EED19-EED sorted"

plotProfile -m results/DTmatrix_EED_EED19EEDpeaks_RP_merged.gz \
  --samplesLabel k562-2x-eed eed19-2x-eed \
  --colors red blue \
  --plotHeight 15 \
  --regionsLabel "EED-19 EED peaks" \
  --plotTitle "EED ChIPs over EED-19 EED peaks" \
  -o plots/Profile_EED_EED19EEDpeaks_RP_merged.pdf \
  --perGroup 
