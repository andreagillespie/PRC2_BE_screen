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
  bigwigs/input-k562-1x_S61.RPGC.bw bigwigs/k562-ezh2-r1_S93.RPGC.bw bigwigs/k562-ezh2-r2_S94.RPGC.bw \
  bigwigs/input-ezh2-164-1x_S62.RPGC.bw bigwigs/ezh2-164-ezh2-r1_S95.RPGC.bw bigwigs/ezh2-164-ezh2-r2_S44.RPGC.bw \
  bigwigs/input-5-1x_S63.RPGC.bw bigwigs/164-EZHIP-KO-ezh2-r1_S45.RPGC.bw bigwigs/164-EZHIP-KO-ezh2-r2_S46.RPGC.bw \
  bigwigs/Input-EZH2-WT-OE_S77.RPGC.bw bigwigs/EZH2-WT-OE-1xEZH2-r1_S70.RPGC.bw bigwigs/EZH2-WT-OE-1xEZH2-r2_S71.RPGC.bw \
  bigwigs/Input-EZH2-677v_S78.RPGC.bw bigwigs/EZH2-677v-1xEZH2-r1_S74.RPGC.bw bigwigs/EZH2-677v-1xEZH2-r2_S75.RPGC.bw \
  bigwigs/EZH2-WT-2xInput_S86.RPGC.bw bigwigs/EZH2-WT-OE-2x-EZH2-r1_S84.RPGC.bw bigwigs/EZH2-WT-OE-2x-EZH2-r2_S85.RPGC.bw \
  bigwigs/EZH2-677v-2xinput_S90.RPGC.bw bigwigs/EZH2-677v-2x-EZH2-r1_S88.RPGC.bw bigwigs/EZH2-677v-2x-EZH2-R2_S89.RPGC.bw \
  -R bed_files/EEDKO_genes.bed \
  -a 5000 \
  -b 5000 \
  -m 10000 \
  -o results/DTmatrix_EZH2_EEDKOgenes_GR.gz \
  -p max

plotHeatmap -m results/DTmatrix_EZH2_EEDKOgenes_GR.gz \
  --sortUsingSamples 2 3 \
  --sortUsing sum \
  --samplesLabel input-k562-1x k562-ezh2-r1 k562-ezh2-r2 \
  input-ezh2-164-1x ezh2-164-ezh2-r1 ezh2-164-ezh2-r2 \
  input-5-1x 164-EZHIP-KO-ezh2-r1 164-EZHIP-KO-ezh2-r2 \
  Input-EZH2-WT-OE EZH2-WT-OE-1xEZH2-r1 EZH2-WT-OE-1xEZH2-r2 \
  Input-EZH2-677v EZH2-677v-1xEZH2-r1 EZH2-677v-1xEZH2-r2 \
  EZH2-WT-2xInput EZH2-WT-OE-2x-EZH2-r1 EZH2-WT-OE-2x-EZH2-r2 \
  EZH2-677v-2xinput EZH2-677v-2x-EZH2-r1 EZH2-677v-2x-EZH2-R2 \
  --colorMap Oranges \
  --regionsLabel "EED KO genes" \
  --heatmapHeight 15 \
  -o plots/Heatmap_EZH2_EEDKOgenes_GR.pdf \
  --plotTitle "EZH2 ChIPs over EED KO genes, k562-EZH2 sorted"

plotProfile -m results/DTmatrix_EZH2_EEDKOgenes_GR.gz \
  --samplesLabel input-k562-1x k562-ezh2-r1 k562-ezh2-r2 \
  input-ezh2-164-1x ezh2-164-ezh2-r1 ezh2-164-ezh2-r2 \
  input-5-1x 164-EZHIP-KO-ezh2-r1 164-EZHIP-KO-ezh2-r2 \
  Input-EZH2-WT-OE EZH2-WT-OE-1xEZH2-r1 EZH2-WT-OE-1xEZH2-r2 \
  Input-EZH2-677v EZH2-677v-1xEZH2-r1 EZH2-677v-1xEZH2-r2 \
  EZH2-WT-2xInput EZH2-WT-OE-2x-EZH2-r1 EZH2-WT-OE-2x-EZH2-r2 \
  EZH2-677v-2xinput EZH2-677v-2x-EZH2-r1 EZH2-677v-2x-EZH2-R2 \
  --colors darkgray red red darkgray orange orange darkgray gold gold \
  darkgray green green darkgray blue blue darkgray purple purple darkgray magenta magenta \
  --plotHeight 15 \
  --regionsLabel "EED KO genes" \
  --plotTitle "EZH2 ChIPs over EED KO genes" \
  -o plots/Profile_EZH2_EEDKOgenes_GR.pdf \
  --perGroup 
