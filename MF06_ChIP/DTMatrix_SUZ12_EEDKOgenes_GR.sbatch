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
#SBATCH --container=/config/spack/containers/centos7/container.sif

source /etc/profile.d/modules.sh

module load deeptools/3.5.0

computeMatrix scale-regions -S \
  bigwigs/input-k562-2x_S64.RPGC.bw bigwigs/k562-suz12-r1_S47.RPGC.bw bigwigs/k562-suz12-r2_S48.RPGC.bw \
  bigwigs/input-ezh2-164-2x_S66.RPGC.bw bigwigs/ezh2-164-suz12-r1_S49.RPGC.bw bigwigs/ezh2-164-suz12-r2_S50.RPGC.bw \
  bigwigs/input-164-EZHIP-KO-2x_S67.RPGC.bw bigwigs/164-EZHIP-KO-suz12-r1_S51.RPGC.bw bigwigs/164-EZHIP-KO-suz12-r2_S52.RPGC.bw \
  -R bed_files/EEDKO_genes.bed \
  -a 5000 \
  -b 5000 \
  -m 10000 \
  -o results/DTmatrix_SUZ12_EEDKOgenes_GR.gz \
  -p max

plotHeatmap -m results/DTmatrix_SUZ12_EEDKOgenes_GR.gz \
  --sortUsingSamples 2 3 \
  --sortUsing sum \
  --samplesLabel input-k562-2x k562-suz12-r1 k562-suz12-r2 \
  input-ezh2-164-2x ezh2-164-suz12-r1 ezh2-164-suz12-r2 \
  input-164-EZHIP-KO-2x 164-EZHIP-KO-suz12-r1 164-EZHIP-KO-suz12-r2 \
  --colorMap Greens \
  --regionsLabel "EED KO genes" \
  --heatmapHeight 15 \
  -o plots/Heatmap_SUZ12_EEDKOgenes_GR.pdf \
  --plotTitle "SUZ12 ChIPs over EED KO genes, k562-suz12 sorted"

plotProfile -m results/DTmatrix_SUZ12_EEDKOgenes_GR.gz \
  --samplesLabel input-k562-2x k562-suz12-r1 k562-suz12-r2 \
  input-ezh2-164-2x ezh2-164-suz12-r1 ezh2-164-suz12-r2 \
  input-164-EZHIP-KO-2x 164-EZHIP-KO-suz12-r1 164-EZHIP-KO-suz12-r2 \
  --colors darkgray red red darkgray gold gold darkgray blue blue \
  --plotHeight 15 \
  --regionsLabel "EED KO genes" \
  --plotTitle "SUZ12 ChIPs over EED KO genes" \
  -o plots/Profile_SUZ12_EEDKOgenes_GR.pdf \
  --perGroup 
