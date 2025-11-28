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
  bigwigs/suz110-suz12-RPGC.merged.bw \
  bigwigs/suz110-ezhip-KO-2x-input_S20.RPGC.bw \
  bigwigs/suz110-ezhip-KO-suz12-RPGC.merged.bw \
  -R ../MF06_ChIP/bed_files/K562_me3_peaks_genes.bed \
  -a 5000 \
  -b 5000 \
  -m 10000 \
  -o results/DTmatrix_SUZ12_MF06K562me3peakGenes_GR_merged.gz \
  -p max

plotHeatmap -m results/DTmatrix_SUZ12_MF06K562me3peakGenes_GR_merged.gz \
  --sortUsingSamples 2 \
  --sortUsing sum \
  --samplesLabel suz110-2x-input suz110-suz12 \
  suz110-ezhip-KO-2x-input suz110-ezhip-KO-suz12 \
  --colorMap Greens \
  --regionsLabel "K562me3 peak genes" \
  --heatmapHeight 15 \
  -o plots/Heatmap_SUZ12_MF06K562me3peakGenes_GR_merged.pdf \
  --plotTitle "SUZ12 ChIPs over MF06 K562me3 peak genes, suz110-suz12 sorted"

plotProfile -m results/DTmatrix_SUZ12_MF06K562me3peakGenes_GR_merged.gz \
  --samplesLabel suz110-2x-input suz110-suz12 \
  suz110-ezhip-KO-2x-input suz110-ezhip-KO-suz12 \
  --colors darkred red darkblue blue \
  --plotHeight 15 \
  --regionsLabel "K562me3 peak genes" \
  --plotTitle "SUZ12 ChIPs over MF06 K562me3 peak genes" \
  -o plots/Profile_SUZ12_MF06K562me3peakGenes_GR_merged.pdf \
  --perGroup 
