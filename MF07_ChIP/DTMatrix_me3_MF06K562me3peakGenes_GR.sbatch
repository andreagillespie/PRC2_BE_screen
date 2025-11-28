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
  bigwigs/suz110-1x-input_S17.RPGC.bw \
  bigwigs/suz110-me3-r1_S11.RPGC.bw bigwigs/suz110-me3-r2_S22.RPGC.bw \
  bigwigs/suz110-ezhip-KO-1x-input_S18.RPGC.bw \
  bigwigs/suz110-ezhip-KO-me3-r1_S23.RPGC.bw bigwigs/suz110-ezhip-KO-me3-r2_S24.RPGC.bw \
  -R ../MF06_ChIP/bed_files/K562_me3_peaks_genes.bed \
  -a 5000 \
  -b 5000 \
  -m 10000 \
  -o results/DTmatrix_me3_MF06K562me3peakGenes_GR.gz \
  -p max

plotHeatmap -m results/DTmatrix_me3_MF06K562me3peakGenes_GR.gz \
  --sortUsingSamples 2 3 \
  --sortUsing sum \
  --samplesLabel suz110-1x-input \
  suz110-me3-r1 suz110-me3-r2 \
  suz110-ezhip-KO-1x-input \
  suz110-ezhip-KO-me3-r1 suz110-ezhip-KO-me3-r2 \
  --colorMap Blues \
  --regionsLabel "K562me3 peak genes" \
  --heatmapHeight 15 \
  -o plots/Heatmap_me3_MF06K562me3peakGenes_GR.pdf \
  --plotTitle "K562me3 ChIPs over MF06 K562me3 peak genes, suz110-me3 sorted"

plotProfile -m results/DTmatrix_me3_MF06K562me3peakGenes_GR.gz \
  --samplesLabel suz110-1x-input \
  suz110-me3-r1 suz110-me3-r2 \
  suz110-ezhip-KO-1x-input \
  suz110-ezhip-KO-me3-r1 suz110-ezhip-KO-me3-r2 \
  --colors darkred red red darkblue blue blue \
  --plotHeight 15 \
  --regionsLabel "K562me3 peak genes" \
  --plotTitle "K562me3 ChIPs over MF06 K562me3 peak genes" \
  -o plots/Profile_me3_MF06K562me3peakGenes_GR.pdf \
  --perGroup 
