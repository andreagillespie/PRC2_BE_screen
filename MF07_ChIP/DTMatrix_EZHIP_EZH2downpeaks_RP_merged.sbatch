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
  -R bdgdiff/EZH2-SUZ110-EZHIPKOvsSUZ110_c3.0_cond2.bed \
  -a 5000 \
  -b 5000 \
  -o results/DTmatrix_EZHIP_EZH2downpeaks_RP_merged.gz \
  -p max

plotHeatmap -m results/DTmatrix_EZHIP_EZH2downpeaks_RP_merged.gz \
  --sortUsingSamples 1 \
  --sortUsing sum \
  --samplesLabel suz110-ezhip suz110-ezhip-KO-ezhip \
  --colorMap Reds \
  --regionsLabel "SUZ110-EZHIPKO EZH2 down peaks" \
  --heatmapHeight 15 \
  -o plots/Heatmap_EZHIP_EZH2downpeaks_RP_merged.pdf \
  --plotTitle "EZHIP ChIPs over EZH2 peaks down in KO, suz110-ezhip sorted"

plotProfile -m results/DTmatrix_EZHIP_EZH2downpeaks_RP_merged.gz \
  --samplesLabel suz110-ezhip suz110-ezhip-KO-ezhip \
  --colors red blue \
  --plotHeight 15 \
  --regionsLabel "SUZ110-EZHIPKO EZH2 down peaks" \
  --plotTitle "EZHIP ChIPs over EZH2 peaks down in KO" \
  -o plots/Profile_EZHIP_EZH2downpeaks_RP_merged.pdf \
  --perGroup 
