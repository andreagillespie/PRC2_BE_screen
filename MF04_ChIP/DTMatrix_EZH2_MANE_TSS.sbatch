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

module load deeptools/3.5.0ls -lh

computeMatrix reference-point --referencePoint TSS -S \
  bigwigs/k562-ezh2-03-05_S18.RPGC.bw bigwigs/k562-ezh2-23-05_S35.RPGC.bw \
  bigwigs/suz95-ezh2-03-05_S19.RPGC.bw bigwigs/suz110-ezh2-03-05_S20.RPGC.bw \
  bigwigs/ezh2-156-ezh2-23-05_S36.RPGC.bw bigwigs/ezh2-164-ezh2-23-05_S37.RPGC.bw \
  bigwigs/eed102-ezh2-03-05_S22.RPGC.bw \
  -R /data/reference/dawson_labs/bed_files/Hg38/Hg38_MANE_ProteinCoding.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_EZH2_MANE_TSS.gz

plotHeatmap -m results/DTmatrix_EZH2_MANE_TSS.gz \
  --sortUsingSamples 1 2 \
  --sortUsing sum \
  --samplesLabel k562-ezh2-03 k562-ezh2-23 suz95-ezh2-03 suz110-ezh2-03 \ 
  ezh2-156-ezh2-23 ezh2-164-ezh2-23 eed102-ezh2-03 \
  --colorMap Oranges \
  --regionsLabel "MANE genes" \
  --heatmapHeight 15 \
  -o plots/Heatmap_EZH2_MANE_TSS.pdf \
  --plotTitle "EZH2 ChIPs, K562 sorted"

plotProfile -m results/DTmatrix_EZH2_MANE_TSS.gz \
  --samplesLabel k562-ezh2-03 k562-ezh2-23 suz95-ezh2-03 suz110-ezh2-03 \
  ezh2-156-ezh2-23 ezh2-164-ezh2-23 eed102-ezh2-03 \
  --regionsLabel "MANE genes" \
  --plotTitle "EZH2 ChIPs" \
  -o plots/Profile_EZH2_MANE_TSS.pdf \
  --perGroup 
