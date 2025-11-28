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
  bigwigs/suz110-ezh2-RPGC.merged.bw \
  bigwigs/suz110-ezhip-KO-ezh2-RPGC.merged.bw \
  -R bdgdiff/EZH2-SUZ110-EZHIPKOvsSUZ110_c3.0_common.bed \
  bdgdiff/EZH2-SUZ110-EZHIPKOvsSUZ110_c3.0_cond1.bed \
  bdgdiff/EZH2-SUZ110-EZHIPKOvsSUZ110_c3.0_cond2.bed \
  -a 5000 \
  -b 5000 \
  -o results/DTmatrix_EZH2_SUZ110-EZHIPKOvSUZ110diffpeaks_RP_merged.gz \
  -p max

plotHeatmap -m results/DTmatrix_EZH2_SUZ110-EZHIPKOvSUZ110diffpeaks_RP_merged.gz \
  --sortUsingSamples 1 \
  --sortUsing sum \
  --samplesLabel k562-2x-ezh2 suz110-ezh2 suz110-ezhip-KO-ezh2 \
  --colorMap Oranges \
  --regionsLabel "common peaks" "SUZ110-EZHIPKO up peaks" "SUZ110-EZHIPKO down peaks" \
  --heatmapHeight 15 \
  -o plots/Heatmap_EZH2_SUZ110-EZHIPKOvSUZ110diffpeaks_RP_merged.pdf \
  --plotTitle "EZH2 ChIPs over SUZ110-EZHIPKOvSUZ110 diff peaks, K562-EZH2 sorted"

plotProfile -m results/DTmatrix_EZH2_SUZ110-EZHIPKOvSUZ110diffpeaks_RP_merged.gz \
  --samplesLabel k562-2x-ezh2 suz110-ezh2 suz110-ezhip-KO-ezh2 \
  --colors darkgreen red blue \
  --plotHeight 15 \
  --regionsLabel "common peaks" "SUZ110-EZHIPKO up peaks" "SUZ110-EZHIPKO down peaks" \
  --plotTitle "EZH2 ChIPs over SUZ110-EZHIPKOvSUZ110 diff peaks" \
  -o plots/Profile_EZH2_SUZ110-EZHIPKOvSUZ110diffpeaks_RP_merged.pdf \
  --perGroup 
