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
  bigwigs/suz110-2x-input_S19.RPGC.bw \
  bigwigs/suz110-ezhip-r1_S4.RPGC.bw bigwigs/suz110-ezhip-r2_S5.RPGC.bw \
  bigwigs/suz110-ezhip-KO-2x-input_S20.RPGC.bw \
  bigwigs/suz110-ezhip-KO-ezhip-r1_S6.RPGC.bw bigwigs/suz110-ezhip-KO-ezhip-r2_S7.RPGC.bw \
  -R ../MF06_ChIP/bed_files/K562_me3_peaks_genes.bed \
  -a 5000 \
  -b 5000 \
  -m 10000 \
  -o results/DTmatrix_EZHIP_MF06K562me3peakGenes_GR.gz \
  -p max

plotHeatmap -m results/DTmatrix_EZHIP_MF06K562me3peakGenes_GR.gz \
  --sortUsingSamples 2 3 \
  --sortUsing sum \
  --samplesLabel suz110-2x-input \
  suz110-ezhip-r1 suz110-ezhip-r2 \
  suz110-ezhip-KO-2x-input \
  suz110-ezhip-KO-ezhip-r1 suz110-ezhip-KO-ezhip-r2 \
  --colorMap Reds \
  --regionsLabel "K562me3 peak genes" \
  --heatmapHeight 15 \
  -o plots/Heatmap_EZHIP_MF06K562me3peakGenes_GR.pdf \
  --plotTitle "EZHIP ChIPs over MF06 K562me3 peak genes, suz110-ezhip sorted"

plotProfile -m results/DTmatrix_EZHIP_MF06K562me3peakGenes_GR.gz \
  --samplesLabel suz110-2x-input \
  suz110-ezhip-r1 suz110-ezhip-r2 \
  suz110-ezhip-KO-2x-input \
  suz110-ezhip-KO-ezhip-r1 suz110-ezhip-KO-ezhip-r2 \
  --colors darkred red red darkblue blue blue \
  --plotHeight 15 \
  --regionsLabel "K562me3 peak genes" \
  --plotTitle "EZHIP ChIPs over MF06 K562me3 peak genes" \
  -o plots/Profile_EZHIP_MF06K562me3peakGenes_GR.pdf \
  --perGroup 
