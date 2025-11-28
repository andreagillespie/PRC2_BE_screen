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

computeMatrix scale-regions -S \
  bigwigs/input-k562-1x_S61.RPGC.bw bigwigs/k562-me3-Dmnorm.merged.bw \
  bigwigs/input-ezh2-164-1x_S62.RPGC.bw bigwigs/ezh2-164-me3-Dmnorm.merged.bw \
  bigwigs/input-5-1x_S63.RPGC.bw bigwigs/164-EZHIP-KO-me3-Dmnorm.merged.bw \
  bigwigs/Input-EZH2-WT-OE_S77.RPGC.bw bigwigs/EZH2-WT-OE-me3-Dmnorm.merged.bw \
  bigwigs/Input-EZH2-677v_S78.RPGC.bw bigwigs/EZH2-677v-me3-Dmnorm.merged.bw \
  -R bed_files/K562_me3_peaks_genes.bed \
  -a 5000 \
  -b 5000 \
  -m 10000 \
  -o results/DTmatrix_K27me3_DMnorm_K562me3peakGenes_GR_merged.gz \
  -p max

plotHeatmap -m results/DTmatrix_K27me3_DMnorm_K562me3peakGenes_GR_merged.gz \
  --sortUsingSamples 2 \
  --sortUsing sum \
  --samplesLabel input-k562-1x k562-me3 \
  input-ezh2-164-1x ezh2-164-me3 \
  input-5-1x 164-EZHIP-KO-me3 \
  Input-EZH2-WT-OE EZH2-WT-OE-me3 \
  Input-EZH2-677v EZH2-677v-me3 \
  --colorMap Blues \
  --regionsLabel "K562me3 peak genes" \
  --heatmapHeight 15 \
  -o plots/Heatmap_K27me3_DmNorm_K562me3peakGenes_GR_merged.pdf \
  --plotTitle "K27me3 ChIPs over K562me3 peak genes, k562-me3 sorted, Dm normalised"

plotProfile -m results/DTmatrix_K27me3_DMnorm_K562me3peakGenes_GR_merged.gz \
  --samplesLabel input-k562-1x k562-me3 \
  input-ezh2-164-1x ezh2-164-me3 \
  input-5-1x 164-EZHIP-KO-me3 \
  Input-EZH2-WT-OE EZH2-WT-OE-me3 \
  Input-EZH2-677v EZH2-677v-me3 \
  --colors darkgray red darkgray orange darkgray gold \
  darkgray green darkgray blue \
  --plotHeight 15 \
  --regionsLabel "K562me3 peak genes" \
  --plotTitle "K27me3 ChIPs over K562me3 peak genes, Dm normalised" \
  -o plots/Profile_K27me3_DmNorm_K562me3peakGenes_GR_merged.pdf \
  --perGroup 
