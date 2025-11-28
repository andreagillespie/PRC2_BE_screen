#!/bin/bash
 
#SBATCH --partition=rhel_short
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=16G
#SBATCH --time=0-8:00:00
#SBATCH --output=logs/DTBamCov%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END
#SBATCH --job-name="DTBamCov"

module load py-deeptools/3.5.3-gcc-13.2.0

bname=`basename $1 .sort.rmdup.bam`

# RPGC norm
bamCoverage --bam $1 \
  -o bigwigs/${bname}.RPGC.bw \
  --binSize 10 \
  --normalizeUsing RPGC \
  --effectiveGenomeSize 2805636231

