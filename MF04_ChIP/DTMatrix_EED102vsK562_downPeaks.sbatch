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
  bigwigs/k562-eed_merged.MACSnorm.bw bigwigs/eed102-eed_merged.MACSnorm.bw \
  bigwigs/k562-ezh2_merged.MACSnorm.bw bigwigs/eed102-ezh2-03-05_S22.MACSnorm.bw \
  bigwigs/k562-suz12_merged.MACSnorm.bw bigwigs/eed102-suz12-03-06_S53.MACSnorm.bw \
  -R bdgdiff/EED-EED102vsK562_c3.0_cond2.bed \
  bdgdiff/EZH2-EED102vsK562_c3.0_cond2.bed \
  bdgdiff/SUZ12-EED102vsK562_c3.0_cond2.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_EED102vsK562_downPeaks.gz

plotHeatmap -m results/DTmatrix_EED102vsK562_downPeaks.gz \
  --sortUsingSamples 1 3 5 \
  --sortUsing sum \
  --samplesLabel k562-eed_merged eed102-eed_merged k562-ezh2_merged \
  eed102-ezh2-03 k562-suz12_merged eed102-suz12-03 \
  --colorMap Purples Purples Oranges Oranges Greens Greens \
  --regionsLabel "EED down" "EZH2 down" "SUZ12 down" \
  --heatmapHeight 15 \
  -o plots/Heatmap_EED102vsK562_downPeaks.pdf \
  --plotTitle "EED102vsK562 down peaks"

plotProfile -m results/DTmatrix_EED102vsK562_downPeaks.gz \
  --samplesLabel k562-eed_merged eed102-eed_merged k562-ezh2_merged \
  eed102-ezh2-03 k562-suz12_merged eed102-suz12-03 \
  --regionsLabel "EED down" "EZH2 down" "SUZ12 down" \
  --plotTitle "EED102vsK562 down peaks" \
  -o plots/Profile_EED102vsK562_downPeaks.pdf \
  --perGroup 
