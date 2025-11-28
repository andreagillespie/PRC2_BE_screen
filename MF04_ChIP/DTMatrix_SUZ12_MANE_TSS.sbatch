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
  bigwigs/k562-suz12-03-06_S50.RPGC.bw bigwigs/k562-suz12-12-05_S40.RPGC.bw \
  bigwigs/k562-suz12-23-05_S28.RPGC.bw bigwigs/suz95-suz12-03-06_S51.RPGC.bw \
  bigwigs/suz95-suz12-23-05_S29.RPGC.bw bigwigs/suz110-suz12-03-06_S52.RPGC.bw \
  bigwigs/suz110-suz-23-05_S30.RPGC.bw bigwigs/ezh2-156-suz12-03-06_S54.RPGC.bw \
  bigwigs/ezh3-156-suz12-29-05_S41.RPGC.bw bigwigs/ezh2-164-suz12-03-06_S11.RPGC.bw \
  bigwigs/ezh2-164-suz12-29-05_S41.RPGC.bw bigwigs/eed102-suz12-03-06_S53.RPGC.bw \
  -R /data/reference/dawson_labs/bed_files/Hg38/Hg38_MANE_ProteinCoding.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_SUZ12_MANE_TSS.gz

plotHeatmap -m results/DTmatrix_SUZ12_MANE_TSS.gz \
  --sortUsingSamples 1 2 3 \
  --sortUsing sum \
  --samplesLabel k562-suz12-03 k562-suz12-12 k562-suz12-23 suz95-suz12-03 \
  suz95-suz12-23 suz110-suz12-03 suz110-suz-23 ezh2-156-suz12-03 \
  ezh3-156-suz12-29 ezh2-164-suz12-03 ezh2-164-suz12-29 eed102-suz12-03 \
  --colorMap Greens \
  --regionsLabel "MANE genes" \
  --heatmapHeight 15 \
  -o plots/Heatmap_SUZ12_MANE_TSS.pdf \
  --plotTitle "SUZ12 ChIPs, K562 sorted"

plotProfile -m results/DTmatrix_SUZ12_MANE_TSS.gz \
  --samplesLabel k562-suz12-03 k562-suz12-12 k562-suz12-23 suz95-suz12-03 \
  suz95-suz12-23 suz110-suz12-03 suz110-suz-23 ezh2-156-suz12-03 \
  ezh3-156-suz12-29 ezh2-164-suz12-03 ezh2-164-suz12-29 eed102-suz12-03 \
  --regionsLabel "MANE genes" \
  --plotTitle "SUZ12 ChIPs" \
  -o plots/Profile_SUZ12_MANE_TSS.pdf \
  --perGroup \
  --legendLocation upper-left
