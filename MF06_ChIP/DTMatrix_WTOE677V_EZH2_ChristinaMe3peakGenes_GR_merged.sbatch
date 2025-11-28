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
  bigwigs/Input-EZH2-WT-OE_S77.RPGC.bw \
  bigwigs/EZH2-WT-OE-1xEZH2-RPGC.merged.bw \
  bigwigs/Input-EZH2-677v_S78.RPGC.bw \
  bigwigs/EZH2-677v-1xEZH2-RPGC.merged.bw \
  bigwigs/EZH2-WT-2xInput_S86.RPGC.bw \
  bigwigs/EZH2-WT-OE-2x-EZH2-RPGC.merged.bw \
  bigwigs/EZH2-677v-2xinput_S90.RPGC.bw \
  bigwigs/EZH2-677v-2x-EZH2-RPGC.merged.bw \
  -R ../sparbier_et_al/ReChIP_220511/macs/broadpeaks/MHC-ReChIP2-K562-SINGLE-H3K27me3_S3_peaks.broadPeak \
  -a 5000 \
  -b 5000 \
  -o results/DTmatrix_WTOE677V_EZH2_ChristinaMe3peakGenes_RP_merged.gz \
  -p max

plotHeatmap -m results/DTmatrix_WTOE677V_EZH2_ChristinaMe3peakGenes_RP_merged.gz \
  --sortUsingSamples 6 \
  --sortUsing sum \
  --samplesLabel Input-EZH2-WT-OE EZH2-WT-OE-1xEZH2 \
  Input-EZH2-677v EZH2-677v-1xEZH2 \
  EZH2-WT-2xInput EZH2-WT-OE-2x-EZH2 \
  EZH2-677v-2xinput EZH2-677v-2x-EZH2 \
  --colorMap Oranges \
  --regionsLabel "Christina's K27me3 peaks" \
  --heatmapHeight 15 \
  -o plots/Heatmap_WTOE677V_EZH2_ChristinaMe3peakGenes_RP_merged.pdf \
  --plotTitle "EZH2 ChIPs over Christina's K27me3 peaks, EZH2-WT-OE-2x-EZH2 sorted"

plotProfile -m results/DTmatrix_WTOE677V_EZH2_ChristinaMe3peakGenes_RP_merged.gz \
  --samplesLabel Input-EZH2-WT-OE EZH2-WT-OE-1xEZH2 \
  Input-EZH2-677v EZH2-677v-1xEZH2 \
  EZH2-WT-2xInput EZH2-WT-OE-2x-EZH2 \
  EZH2-677v-2xinput EZH2-677v-2x-EZH2 \
  --colors darkred red darkblue blue darkred red darkblue blue \
  --plotHeight 15 \
  --regionsLabel "Christina's K27me3 peaks" \
  --plotTitle "EZH2 ChIPs over Christina's K27me3 peaks" \
  -o plots/Profile_WTOE677V_EZH2_ChristinaMe3peakGenes_RP_merged.pdf \
  --perGroup 
