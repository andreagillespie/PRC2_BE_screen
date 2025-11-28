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
  -R bdgdiff/EED-EED19vsK562_c3.0_common.bed \
  bdgdiff/EED-EED19vsK562_c3.0_cond1.bed \
  bdgdiff/EED-EED19vsK562_c3.0_cond2.bed \
  -a 5000 \
  -b 5000 \
  -o results/DTmatrix_EED_EED19vK562diffpeaks_RP_merged.gz \
  -p max

plotHeatmap -m results/DTmatrix_EED_EED19vK562diffpeaks_RP_merged.gz \
  --sortUsingSamples 1 \
  --sortUsing sum \
  --samplesLabel k562-2x-eed eed19-2x-eed \
  --colorMap Purples \
  --regionsLabel "common peaks" "EED-19 up peaks" "EED-19 down peaks" \
  --heatmapHeight 15 \
  -o plots/Heatmap_EED_EED19vK562diffpeaks_RP_merged.pdf \
  --plotTitle "EED ChIPs over EED-19vK562 diff peaks, K562-EED sorted"

plotProfile -m results/DTmatrix_EED_EED19vK562diffpeaks_RP_merged.gz \
  --samplesLabel k562-2x-eed eed19-2x-eed \
  --colors red blue \
  --plotHeight 15 \
  --regionsLabel "common peaks" "EED-19 up peaks" "EED-19 down peaks"  \
  --plotTitle "EED ChIPs over EED-19vK562 diff peaks" \
  -o plots/Profile_EED_EED19vK562diffpeaks_RP_merged.pdf \
  --perGroup 
