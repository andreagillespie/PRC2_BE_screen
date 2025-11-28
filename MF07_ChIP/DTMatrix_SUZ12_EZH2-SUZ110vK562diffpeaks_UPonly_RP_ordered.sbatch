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

computeMatrix reference-point --referencePoint center -S \
  bigwigs/suz110-suz12-RPGC.merged.bw \
  bigwigs/suz110-ezhip-KO-suz12-RPGC.merged.bw \
  -R bed_files/SUZ110vsK562_EZH2_peaks_UPonly_MUTordered.bed \
  -a 5000 \
  -b 5000 \
  -o results/DTmatrix_SUZ12_EZH2-SUZ110vK562diffpeaks_UPonly_RP_ordered.gz \
  -p max

plotHeatmap -m results/DTmatrix_SUZ12_EZH2-SUZ110vK562diffpeaks_UPonly_RP_ordered.gz \
  --sortRegions keep \
  --samplesLabel suz110-suz12 suz110-ezhip-KO-suz12 \
  --colorMap Greens \
  --regionsLabel "mut up peaks" \
  --heatmapHeight 15 \
  -o plots/Heatmap_SUZ12_EZH2-SUZ110vK562diffpeaks_UPonly_RP_ordered.pdf \
  --plotTitle "SUZ12 ChIPs over EZH2 SUZ110vK562 diff peaks, K562 EZH2 sorted"

plotProfile -m results/DTmatrix_SUZ12_EZH2-SUZ110vK562diffpeaks_UPonly_RP_ordered.gz \
  --samplesLabel suz110-suz12 suz110-ezhip-KO-suz12 \
  --colors red blue \
  --plotHeight 15 \
  --regionsLabel "mut up peaks" \
  --plotTitle "SUZ12 ChIPs over EZH2 SUZ110vK562 diff peaks" \
  -o plots/Profile_SUZ12_EZH2-SUZ110vK562diffpeaks_UPonly_RP_ordered.pdf \
  --perGroup 
