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
  bigwigs/EZH2-WT-OE-me3-Dmnorm.merged.bw \
  bigwigs/EZH2-677v-me3-Dmnorm.merged.bw \
  -R ../sparbier_et_al/ReChIP_220511/macs/broadpeaks/MHC-ReChIP2-K562-SINGLE-H3K27me3_S3_peaks.broadPeak \
  -a 5000 \
  -b 5000 \
  -o results/DTmatrix_WTOE677V_K27me3_DMnorm_ChristinaMe3peakGenes_RP_merged.gz \
  -p max

plotHeatmap -m results/DTmatrix_WTOE677V_K27me3_DMnorm_ChristinaMe3peakGenes_RP_merged.gz \
  --sortUsingSamples 1 \
  --sortUsing sum \
  --samplesLabel EZH2-WT-OE-me3 EZH2-677v-me3 \
  --colorMap Blues \
  --regionsLabel "Christina's K27me3 peaks" \
  --heatmapHeight 15 \
  -o plots/Heatmap_WTOE677V_K27me3_DMnorm_ChristinaMe3peakGenes_RP_merged.pdf \
  --plotTitle "K27me3 ChIPs over Christina's K27me3 peaks, EZH2-WT-OE-me3 sorted, Dm normalised"

plotProfile -m results/DTmatrix_WTOE677V_K27me3_DMnorm_ChristinaMe3peakGenes_RP_merged.gz \
  --samplesLabel EZH2-WT-OE-me3 EZH2-677v-me3 \
  --colors red blue \
  --plotHeight 15 \
  --regionsLabel "K562me3 peak genes" \
  --plotTitle "K27me3 ChIPs over Christina's K27me3 peaks, Dm normalised" \
  -o plots/Profile_WTOE677V_K27me3_DMnorm_ChristinaMe3peakGenes_RP_merged.pdf \
  --perGroup 
