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
  bigwigs/input-k562-2x_S64.RPGC.bw bigwigs/k562-suz12-RPGC.merged.bw \
  bigwigs/input-ezh2-164-2x_S66.RPGC.bw bigwigs/ezh2-164-suz12-RPGC.merged.bw \
  bigwigs/input-164-EZHIP-KO-2x_S67.RPGC.bw bigwigs/164-EZHIP-KO-suz12-RPGC.merged.bw \
  -R bed_files/K562_me3_peaks_genes.bed \
  -a 5000 \
  -b 5000 \
  -m 10000 \
  -o results/DTmatrix_SUZ12_K562me3peakGenes_GR_merged.gz \
  -p max

plotHeatmap -m results/DTmatrix_SUZ12_K562me3peakGenes_GR_merged.gz \
  --sortUsingSamples 2 \
  --sortUsing sum \
  --samplesLabel input-k562-2x k562-suz12 \
  input-ezh2-164-2x ezh2-164-suz12 \
  input-164-EZHIP-KO-2x 164-EZHIP-KO-suz12 \
  --colorMap Greens \
  --regionsLabel "K562me3 peak genes" \
  --heatmapHeight 15 \
  -o plots/Heatmap_SUZ12_K562me3peakGenes_GR_merged.pdf \
  --plotTitle "SUZ12 ChIPs over K562me3 peak genes, k562-suz12 sorted"

plotProfile -m results/DTmatrix_SUZ12_K562me3peakGenes_GR_merged.gz \
  --samplesLabel input-k562-2x k562-suz12 \
  input-ezh2-164-2x ezh2-164-suz12 \
  input-164-EZHIP-KO-2x 164-EZHIP-KO-suz12 \
  --colors darkgray red darkgray gold darkgray blue \
  --plotHeight 15 \
  --regionsLabel "K562me3 peak genes" \
  --plotTitle "SUZ12 ChIPs over K562me3 peak genes" \
  -o plots/Profile_SUZ12_K562me3peakGenes_GR_merged.pdf \
  --perGroup 
