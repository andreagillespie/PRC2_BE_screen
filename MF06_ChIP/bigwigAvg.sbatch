#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --output=logs/bigwigAvg%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="bigwigAvg"
#SBATCH --partition=rhel_short

module load py-deeptools/3.5.3-gcc-13.2.0

bigwigAverage -b bigwigs/$1 bigwigs/$2 \
  -o bigwigs/$3.merged.bw \
  --binSize 10 \
  -p max \
  -of bigwig

