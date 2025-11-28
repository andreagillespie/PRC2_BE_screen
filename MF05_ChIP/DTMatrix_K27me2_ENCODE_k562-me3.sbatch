#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=80G
#SBATCH --time=4-00:00:00
#SBATCH --output=logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="DTMatrix"
#SBATCH --partition=rhel_long
#SBATCH --container=/config/spack/containers/centos7/container.sif

source /etc/profile.d/modules.sh

module load deeptools/3.5.0

computeMatrix reference-point --referencePoint center  -S \
  bigwigs/input-1_S38.RPGC.bw bigwigs/1-me2-r1_S16.RPGC.bw bigwigs/1-me2-r2_S17.RPGC.bw \
  bigwigs/input-2_S39.RPGC.bw bigwigs/2-me2-r1_S18.RPGC.bw bigwigs/2-me2-r2_S19.RPGC.bw \
  bigwigs/input-3_S40.RPGC.bw bigwigs/3-me2-r1_S21.RPGC.bw bigwigs/3-me2-r2_S23.RPGC.bw \
  bigwigs/input-4_S41.RPGC.bw bigwigs/4-me2-r1_S28.RPGC.bw bigwigs/4-me2-r2_S29.RPGC.bw \
  bigwigs/input-5_S42.RPGC.bw bigwigs/5-me2-r1_S36.RPGC.bw bigwigs/5-me2-r2_S37.RPGC.bw \
  bigwigs/k562-ezh2-r1_S45.RPGC.bw bigwigs/k562-ezh2-r2_S46.RPGC.bw \
  bigwigs/k562-me3-r1_S47.RPGC.bw bigwigs/k562-me3-r2_S48.RPGC.bw \
  -R /dawson_genomics/Projects/PRC2_BE_screen/data/ENCODE/USC_ENCODE_K562_K27me3_replicated_peaks_Hg38.bed \
  -a 5000 \
  -b 5000 \
  -o results/DTmatrix_K27me2_ENCODE_k562-me3-Peaks.gz \
  -p max

plotHeatmap -m results/DTmatrix_K27me2_ENCODE_k562-me3-Peaks.gz \
  --sortUsingSamples 19 \
  --sortUsing sum \
  --samplesLabel input-1 1-me2-r1 1-me2-r2 \
  input-2 2-me2-r1 2-me2-r2 \
  input-3 3-me2-r1 3-me2-r2 \
  input-4 4-me2-r1 4-me2-r2 \
  input-5 5-me2-r1 5-me2-r2 \
  k562-ezh2-r1 k562-ezh2-r2 k562-me3-r1 k562-me3-r2 \
  --colorMap Reds \
  --regionsLabel "ENCODE K562me3 peaks" \
  --heatmapHeight 15 \
  --zMax 5 \
  --yMax 15 \
  --refPointLabel center \
  -o plots/Heatmap_K27me2_ENCODE_k562-me3.pdf \
  --plotTitle "K27me2 ChIPs over ENCODE K562me3 peaks, k562-me3-r2 sorted"

plotProfile -m results/DTmatrix_K27me2_ENCODE_k562-me3-Peaks.gz \
  --samplesLabel input-1 1-me2-r1 1-me2-r2 \
  input-2 2-me2-r1 2-me2-r2 \
  input-3 3-me2-r1 3-me2-r2 \
  input-4 4-me2-r1 4-me2-r2 \
  input-5 5-me2-r1 5-me2-r2 \
  k562-ezh2-r1 k562-ezh2-r2 k562-me3-r1 k562-me3-r2 \
  --colors darkgray red red darkgray orange orange darkgray gold gold \
  darkgray green green darkgray blue blue purple purple magenta magenta \
  --regionsLabel "ENCODE K562me3 peaks" \
  --plotTitle "K27me2 ChIPs over ENCODE K562me3 peaks" \
  --plotHeight 15 \
  -o plots/Profile_K27me2_ENCODE_k562-me3.pdf \
  --perGroup 
