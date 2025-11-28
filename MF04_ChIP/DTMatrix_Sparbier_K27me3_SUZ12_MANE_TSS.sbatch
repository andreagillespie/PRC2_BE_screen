#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=12G
#SBATCH --time=0-02:00:00
#SBATCH --output=logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="DTMatrix"
#SBATCH --partition=rhel_short
#SBATCH --container=/config/spack/containers/centos7/container.sif

source /etc/profile.d/modules.sh

module load deeptools/3.5.0

computeMatrix reference-point --referencePoint TSS -S \
  /dawson_genomics/Projects/PRC2_BE_screen/data/sparbier_et_al/CUTandTAG_220328_NB501056_0777_AHNGTWBGXL/MHC-CSCT05-K562-NT2-H3K27me3_S5.RPGC.bw \
  /dawson_genomics/Projects/PRC2_BE_screen/data/sparbier_et_al/ChIPseq_210422_NB501056_0625_AHGNFTBGXJ/MHC-CS04-K562-3B-DUAL-SUZ12_S7.bw \
  -R /data/reference/dawson_labs/bed_files/Hg19/Hg19EnsGene.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_Sparbier_K27me3_SUZ12_MANE_TSS.gz

plotHeatmap -m results/DTmatrix_Sparbier_K27me3_SUZ12_MANE_TSS.gz \
  --sortUsingSamples 1 2 \
  --sortUsing sum \
  --samplesLabel CSCT05-K562-NT2-H3K27me3 CAS-SUZ12 \
  --colorMap Blues Greens \
  --regionsLabel "Ensembl genes, Hg19" \
  --heatmapHeight 15 \
  --zMax 5 \
  -o plots/Heatmap_Sparbier_K27me3_SUZ12_MANE_TSS.pdf \
  --plotTitle "Data from Sparbier, et al"

plotProfile -m results/DTmatrix_Sparbier_K27me3_SUZ12_MANE_TSS.gz \
  --samplesLabel CSCT05-K562-NT2-H3K27me3 CAS-SUZ12 \
  --regionsLabel "Ensembl genes, Hg19" \
  --plotTitle "Data from Sparbier, et al" \
  -o plots/Profile_Sparbier_K27me3_SUZ12_MANE_TSS.pdf \
  --perGroup 
