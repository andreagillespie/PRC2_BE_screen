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
  -R ../sparbier_et_al/ReChIP_220511/macs/broadpeaks/MHC-ReChIP2-K562-SINGLE-H3K27me3_S3_peaks.broadPeak \
  -a 5000 \
  -b 5000 \
  -o results/DTmatrix_EED19_EZH2_ChristinaMe3peakGenes_RP_merged.gz \
  -p max

plotHeatmap -m results/DTmatrix_EED19_EZH2_ChristinaMe3peakGenes_RP_merged.gz \
  --sortUsingSamples 1 \
  --sortUsing sum \
  --samplesLabel k562-2x-ezh22 eed19-ezh2 \
  --colorMap Oranges \
  --regionsLabel "Christina's K27me3 peaks" \
  --heatmapHeight 15 \
  -o plots/Heatmap_EED19_EZH2_ChristinaMe3peakGenes_RP_merged.pdf \
  --plotTitle "EZH2 ChIPs over Christina's K27me3 peaks, K562-EZH2 sorted"

plotProfile -m results/DTmatrix_EED19_EZH2_ChristinaMe3peakGenes_RP_merged.gz \
  --samplesLabel k562-2x-ezh22 eed19-ezh2 \
  --colors red blue \
  --plotHeight 15 \
  --regionsLabel "Christina's K27me3 peaks" \
  --plotTitle "EZH2 ChIPs over Christina's K27me3 peaks" \
  -o plots/Profile_EED19_EZH2_ChristinaMe3peakGenes_RP_merged.pdf \
  --perGroup 
