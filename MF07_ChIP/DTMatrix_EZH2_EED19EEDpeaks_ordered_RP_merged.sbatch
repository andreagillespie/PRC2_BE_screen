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
  -R bed_files/EED19_EED_peaks_ordered.bed \
  -a 5000 \
  -b 5000 \
  -o results/DTmatrix_EZH2_EED19EEDpeaks_ordered_RP_merged.gz \
  -p max

plotHeatmap -m results/DTmatrix_EZH2_EED19EEDpeaks_ordered_RP_merged.gz \
  --sortRegions keep \
  --samplesLabel k562-2x-ezh22 eed19-ezh2 \
  --colorMap Oranges \
  --regionsLabel "EED-19 EED peaks" \
  --heatmapHeight 15 \
  -o plots/Heatmap_EZH2_EED19EEDpeaks_ordered_RP_merged.pdf \
  --plotTitle "EZH2 ChIPs over EED-19 EED peaks, EED19-EED sorted"

plotProfile -m results/DTmatrix_EZH2_EED19EEDpeaks_ordered_RP_merged.gz \
  --samplesLabel k562-2x-ezh22 eed19-ezh2 \
  --colors red blue \
  --plotHeight 15 \
  --regionsLabel "EED-19 EED peaks" \
  --plotTitle "EZH2 ChIPs over EED-19 EED peaks" \
  -o plots/Profile_EZH2_EED19EEDpeaks_ordered_RP_merged.pdf \
  --perGroup 
