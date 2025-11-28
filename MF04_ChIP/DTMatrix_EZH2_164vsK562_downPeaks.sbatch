#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=12G
#SBATCH --time=0-02:00:00
#SBATCH --output=logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="DTMatrix"
#SBATCH --partition=rhel_short
#SBATCH --container=/config/spack/containers/centos7/container.sif

source /etc/profile.d/modules.sh

module load deeptools/3.5.0

computeMatrix reference-point --referencePoint center -S \
  bigwigs/k562-eed_merged.MACSnorm.bw bigwigs/ezh2-164-eed_merged.MACSnorm.bw \
  bigwigs/k562-ezh2_merged.MACSnorm.bw bigwigs/ezh2-164-ezh2-23-05_S37.MACSnorm.bw \
  bigwigs/k562-suz12_merged.MACSnorm.bw bigwigs/ezh2-164-suz12_merged.MACSnorm.bw \
  -R bdgdiff/EED-EZH2-164vsK562_c3.0_cond2.bed \
  bdgdiff/EZH2-EZH2-164vsK562_c3.0_cond2.bed \
  bdgdiff/SUZ12-EZH2-164vsK562_c3.0_cond2.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_EZH2_164vsK562_downPeaks.gz

plotHeatmap -m results/DTmatrix_EZH2_164vsK562_downPeaks.gz \
  --sortUsingSamples 1 3 5 \
  --sortUsing sum \
  --samplesLabel k562-eed_merged ezh2-164-eed_merged k562-ezh2_merged \
  ezh2-164-ezh2-23 k562-suz12_merged ezh2-164-suz12_merged \
  --colorMap Purples Purples Oranges Oranges Greens Greens \
  --regionsLabel "EED down" "EZH2 down" "SUZ12 down" \
  --heatmapHeight 15 \
  -o plots/Heatmap_EZH2_164vsK562.pdf \
  --plotTitle "EZH2_164vsK562 down peaks"

plotProfile -m results/DTmatrix_EZH2_164vsK562_downPeaks.gz \
  --samplesLabel k562-eed_merged ezh2-164-eed_merged k562-ezh2_merged \
  ezh2-164-ezh2-23 k562-suz12_merged ezh2-164-suz12_merged \
  --regionsLabel "EED down" "EZH2 down" "SUZ12 down" \
  --plotTitle "EZH2_164vsK562 down peaks" \
  -o plots/Profile_EZH2_164vsK562_downPeaks.pdf \
  --perGroup 
