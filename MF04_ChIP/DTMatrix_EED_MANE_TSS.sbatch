#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=12G
#SBATCH --time=0-06:00:00
#SBATCH --output=logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="DTMatrix"
#SBATCH --partition=rhel_short
#SBATCH --container=/config/spack/containers/centos7/container.sif

source /etc/profile.d/modules.sh

module load deeptools/3.5.0

computeMatrix reference-point --referencePoint TSS -S \
  bigwigs/k562-eed-03-06_S12.RPGC.bw bigwigs/k562-eed-23-05_S31.RPGC.bw \
  bigwigs/k562-eed-29-05_S44.RPGC.bw bigwigs/suz95-eed-23-05_S33.RPGC.bw \
  bigwigs/suz96-eed-03-06_S13.RPGC.bw bigwigs/suz110-eed-03-06_S14.RPGC.bw \
  bigwigs/ezh2-156-eed-03-06_S16.RPGC.bw bigwigs/ezh2-156-eed-29-05_S45.RPGC.bw \
  bigwigs/ezh2-164-eed-03-06_S17.RPGC.bw bigwigs/ezh3-164-eed-29-05_S46.RPGC.bw \
  bigwigs/eed102-eed-03-06_S15.RPGC.bw bigwigs/eed102-eed-23-05_S33.RPGC.bw \
  -R /data/reference/dawson_labs/bed_files/Hg38/Hg38_MANE_ProteinCoding.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_EED_MANE_TSS.gz

plotHeatmap -m results/DTmatrix_EED_MANE_TSS.gz \
  --sortUsingSamples 1 2 3 \
  --sortUsing sum \
  --samplesLabel k562-eed-03 k562-eed-23 k562-eed-29 suz95-eed-23 \
  suz96-eed-03 suz110-eed-03 ezh2-156-eed-03 ezh2-156-eed-29 \
  ezh2-164-eed-03 ezh3-164-eed-29 eed102-eed-03 eed102-eed-23 \
  --colorMap Purples \
  --regionsLabel "EED genes" \
  --heatmapHeight 15 \
  -o plots/Heatmap_EED_MANE_TSS.pdf \
  --plotTitle "EED ChIPs, K562 sorted"

plotProfile -m results/DTmatrix_EED_MANE_TSS.gz \
  --samplesLabel k562-eed-03 k562-eed-23 k562-eed-29 suz95-eed-23 \
  suz96-eed-03 suz110-eed-03 ezh2-156-eed-03 ezh2-156-eed-29 \
  ezh2-164-eed-03 ezh3-164-eed-29 eed102-eed-03 eed102-eed-23 \
  --regionsLabel "MANE genes" \
  --plotTitle "EED ChIPs" \
  -o plots/Profile_EED_MANE_TSS.pdf \
  --perGroup 
