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
  bigwigs/input-k562-1x_S61.RPGC.bw bigwigs/k562-me3-r1_S54_Dmnorm.bw bigwigs/k562-me3-r2_S65_Dmnorm.bw \
  bigwigs/input-ezh2-164-1x_S62.RPGC.bw bigwigs/ezh2-164-me3-r1_S76_Dmnorm.bw bigwigs/ezh2-164-me3-r2_S87_Dmnorm.bw \
  bigwigs/input-5-1x_S63.RPGC.bw bigwigs/164-EZHIP-KO-me3-r1_S91_Dmnorm.bw bigwigs/164-EZHIP-KO-me3-r2_S92_Dmnorm.bw \
  bigwigs/Input-EZH2-WT-OE_S77.RPGC.bw bigwigs/EZH2-WT-OE-me3-r1_S68_Dmnorm.bw bigwigs/EZH2-WT-OE-me3-r2_S69_Dmnorm.bw \
  bigwigs/Input-EZH2-677v_S78.RPGC.bw bigwigs/EZH2-677v-me3-r1_S72_Dmnorm.bw bigwigs/EZH2-677v-me3-r2_S73_Dmnorm.bw \
  -R bed_files/EEDKO_genes.bed \
  -a 5000 \
  -b 5000 \
  -m 10000 \
  -o results/DTmatrix_K27me3_DMnorm_EEDKOgenes_GR.gz \
  -p max

plotHeatmap -m results/DTmatrix_K27me3_DMnorm_EEDKOgenes_GR.gz \
  --sortUsingSamples 2 3 \
  --sortUsing sum \
  --samplesLabel input-k562-1x k562-me3-r1 k562-me3-r2 \
  input-ezh2-164-1x ezh2-164-me3-r1 ezh2-164-me3-r2 \
  input-5-1x 164-EZHIP-KO-me3-r1 164-EZHIP-KO-me3-r2 \
  Input-EZH2-WT-OE EZH2-WT-OE-me3-r1 EZH2-WT-OE-me3-r2 \
  Input-EZH2-677v EZH2-677v-me3-r1 EZH2-677v-me3-r2 \
  --colorMap Blues \
  --regionsLabel "EED KO genes" \
  --heatmapHeight 15 \
  -o plots/Heatmap_K27me3_DmNorm_EEDKOgenes_GR.pdf \
  --plotTitle "K27me3 ChIPs over EED KO genes, k562-me3 sorted, Dm normalised"

plotProfile -m results/DTmatrix_K27me3_DMnorm_EEDKOgenes_GR.gz \
  --samplesLabel input-k562-1x k562-me3-r1 k562-me3-r2 \
  input-ezh2-164-1x ezh2-164-me3-r1 ezh2-164-me3-r2 \
  input-5-1x 164-EZHIP-KO-me3-r1 164-EZHIP-KO-me3-r2 \
  Input-EZH2-WT-OE EZH2-WT-OE-me3-r1 EZH2-WT-OE-me3-r2 \
  Input-EZH2-677v EZH2-677v-me3-r1 EZH2-677v-me3-r2 \
  --colors darkgray red red darkgray orange orange darkgray gold gold \
  darkgray green green darkgray blue blue \
  --plotHeight 15 \
  --regionsLabel "EED KO genes" \
  --plotTitle "K27me3 ChIPs over EED KO genes, Dm normalised" \
  -o plots/Profile_K27me3_DmNorm_EEDKOgenes_GR.pdf \
  --perGroup 
