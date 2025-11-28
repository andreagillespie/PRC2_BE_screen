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
  bigwigs/suz110-ezhip-RPGC.merged.bw \
  bigwigs/suz110-ezhip-KO-ezhip-RPGC.merged.bw \
  -R bed_files/SUZ110vsK562_EZH2_peaks_ordered.bed  \
  -a 5000 \
  -b 5000 \
  -o results/DTmatrix_EZHIP_EZH2diffpeaks_MTvWT_ordered_RP_merged.gz \
  -p max

plotHeatmap -m results/DTmatrix_EZHIP_EZH2diffpeaks_MTvWT_ordered_RP_merged.gz \
  --sortRegions keep \
  --samplesLabel suz110-ezhip suz110-ezhip-KO-ezhip \
  --colorMap Reds \
  --regionsLabel "common EZH2 peaks" "mut up EZH2 peaks" "mut down EZH2 peaks" \
  --heatmapHeight 15 \
  -o plots/Heatmap_EZHIP_EZH2diffpeaks_MTvWT_ordered_RP_merged.pdf \
  --plotTitle "EZHIP ChIPs over EZH2 SUZ110vsK562-WT diff peaks, K562-EZH2 sorted"
  
# also make one ordered by EZHIP and output bed file
plotHeatmap -m results/DTmatrix_EZHIP_EZH2diffpeaks_MTvWT_ordered_RP_merged.gz \
  --sortUsingSamples 1 \
  --sortUsing sum \
  --samplesLabel suz110-ezhip suz110-ezhip-KO-ezhip \
  --colorMap Reds \
  --regionsLabel "common EZH2 peaks" "mut up EZH2 peaks" "mut down EZH2 peaks" \
  --heatmapHeight 15 \
  -o plots/Heatmap_EZHIP_EZH2diffpeaks_MTvWT_EZHIPordered_RP_merged.pdf \
  --outFileSortedRegions bed_files/K562_EZH2_peaks_SUZ110EZHIPordered.bed \
  --plotTitle "EZHIP ChIPs over EZH2 SUZ110vsK562-WT diff peaks, SUZ110-EZHIP sorted"

plotProfile -m results/DTmatrix_EZHIP_EZH2diffpeaks_MTvWT_ordered_RP_merged.gz \
  --samplesLabel suz110-ezhip suz110-ezhip-KO-ezhip \
  --colors red blue \
  --plotHeight 15 \
  --regionsLabel "common EZH2 peaks" "mut up EZH2 peaks" "mut down EZH2 peaks" \
  --plotTitle "EZHIP ChIPs over EZH2 SUZ110vsK562-WT diff peaks" \
  -o plots/Profile_EZHIP_EZH2diffpeaks_MTvWT_ordered_RP_merged.pdf \
  --perGroup 
