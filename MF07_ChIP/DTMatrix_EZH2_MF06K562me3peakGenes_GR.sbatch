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
  bigwigs/suz110-ezh2-r1_S25.RPGC.bw bigwigs/suz110-ezh2-r2_S26.RPGC.bw \
  bigwigs/suz110-ezhip-KO-1x-input_S18.RPGC.bw \
  bigwigs/suz110-ezhip-KO-ezh2-r1_S27.RPGC.bw bigwigs/suz110-ezhip-KO-ezh2-r2_S28.RPGC.bw \
  bigwigs/eed19-2x-input_S21.RPGC.bw \
  bigwigs/k562-2x-ezh2-r1_S8.RPGC.bw bigwigs/k562-2x-ezh2-r2_S9.RPGC.bw \
  bigwigs/eed19-ezh2-r1_S10.RPGC.bw bigwigs/eed19-ezh2-r2_S12.RPGC.bw \
  -R ../MF06_ChIP/bed_files/K562_me3_peaks_genes.bed \
  -a 5000 \
  -b 5000 \
  -m 10000 \
  -o results/DTmatrix_EZH2_MF06K562me3peakGenes_GR.gz \
  -p max

plotHeatmap -m results/DTmatrix_EZH2_MF06K562me3peakGenes_GR.gz \
  --sortUsingSamples 8 9 \
  --sortUsing sum \
  --samplesLabel suz110-1x-input suz110-ezh2-r1 suz110-ezh2-r2 \
  suz110-ezhip-KO-1x-input suz110-ezhip-KO-ezh2-r1 suz110-ezhip-KO-ezh2-r2 \
  eed19-2x-input k562-2x-ezh2-r1 k562-2x-ezh2-r2 \
  eed19-ezh2-r1 eed19-ezh2-r2 \
  --colorMap Oranges \
  --regionsLabel "K562me3 peak genes" \
  --heatmapHeight 15 \
  -o plots/Heatmap_EZH2_MF06K562me3peakGenes_GR.pdf \
  --plotTitle "EZH2 ChIPs over MF06 K562me3 peak genes, K562-EZH2 sorted"

plotProfile -m results/DTmatrix_EZH2_MF06K562me3peakGenes_GR.gz \
  --samplesLabel suz110-1x-input suz110-ezh2-r1 suz110-ezh2-r2 \
  suz110-ezhip-KO-1x-input suz110-ezhip-KO-ezh2-r1 suz110-ezhip-KO-ezh2-r2 \
  eed19-2x-input k562-2x-ezh2-r1 k562-2x-ezh2-r2 \
  eed19-ezh2-r1 eed19-ezh2-r2 \
  --colors darkred red red darkorange orange orange \
  darkgreen green green blue blue \
  --plotHeight 15 \
  --regionsLabel "K562me3 peak genes" \
  --plotTitle "EZH2 ChIPs over MF06 K562me3 peak genes" \
  -o plots/Profile_EZH2_MF06K562me3peakGenes_GR.pdf \
  --perGroup 
