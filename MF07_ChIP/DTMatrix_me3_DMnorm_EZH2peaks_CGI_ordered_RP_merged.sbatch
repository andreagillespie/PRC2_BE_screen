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
  bigwigs/suz110-me3-Dmnorm.merged.bw \
  bigwigs/suz110-ezhip-KO-me3-Dmnorm.merged.bw \
  -R bed_files/K562_EZH2_peaks_ordered_CGIstatus.bed  \
  -a 5000 \
  -b 5000 \
  -o results/DTmatrix_me3_DMnorm_EZH2peaks_CGI_ordered_RP_merged.gz \
  -p max

plotHeatmap -m results/DTmatrix_me3_DMnorm_EZH2peaks_CGI_ordered_RP_merged.gz \
  --sortRegions keep \
  --samplesLabel suz110-me3 suz110-ezhip-KO-me3 \
  --colorMap Blues \
  --regionsLabel "WT EZH2 CGI peaks" "WT EZH2 non-CGI peaks" \
  --heatmapHeight 15 \
  --zMax 15 \
  -o plots/Heatmap_me3_DMnorm_EZH2peaks_CGI_ordered_RP_merged.pdf \
  --plotTitle "me3 ChIPs over EZH2 peaks by CGI status, K562-EZH2 sorted, Dm normalised"

plotProfile -m results/DTmatrix_me3_DMnorm_EZH2peaks_CGI_ordered_RP_merged.gz \
  --samplesLabel suz110-me3 suz110-ezhip-KO-me3 \
  --colors red blue \
  --plotHeight 15 \
  --regionsLabel "WT EZH2 CGI peaks" "WT EZH2 non-CGI peaks" \
  --plotTitle "me3 ChIPs over EZH2 peaks by CGI status, Dm normalised" \
  -o plots/Profile_me3_DMnorm_EZH2peaks_CGI_ordered_RP_merged.pdf \
  --perGroup 
