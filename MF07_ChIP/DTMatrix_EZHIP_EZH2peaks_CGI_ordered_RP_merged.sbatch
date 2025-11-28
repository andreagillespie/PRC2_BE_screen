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
  -R bed_files/K562_EZH2_peaks_ordered_CGIstatus.bed  \
  -a 5000 \
  -b 5000 \
  -o results/DTmatrix_EZHIP_EZH2peaks_CGI_ordered_RP_merged.gz \
  -p max

plotHeatmap -m results/DTmatrix_EZHIP_EZH2peaks_CGI_ordered_RP_merged.gz \
  --sortRegions keep \
  --samplesLabel suz110-ezhip suz110-ezhip-KO-ezhip \
  --colorMap Reds \
  --regionsLabel "WT EZH2 CGI peaks" "WT EZH2 non-CGI peaks" \
  --heatmapHeight 15 \
  -o plots/Heatmap_EZHIP_EZH2peaks_CGI_ordered_RP_merged.pdf \
  --plotTitle "EZHIP ChIPs over EZH2 peaks by CGI status, K562-EZH2 sorted"

plotProfile -m results/DTmatrix_EZHIP_EZH2peaks_CGI_ordered_RP_merged.gz \
  --samplesLabel suz110-ezhip suz110-ezhip-KO-ezhip \
  --colors red blue \
  --plotHeight 15 \
  --regionsLabel "WT EZH2 CGI peaks" "WT EZH2 non-CGI peaks" \
  --plotTitle "EZHIP ChIPs over EZH2 peaks by CGI status" \
  -o plots/Profile_EZHIP_EZH2peaks_CGI_ordered_RP_merged.pdf \
  --perGroup 
