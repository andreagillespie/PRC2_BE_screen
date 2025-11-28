#!/bin/bash

#SBATCH --partition=rhel_short
#SBATCH --container=/config/spack/containers/centos7/container.sif
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=32G
#SBATCH --time=1-00:00:00
#SBATCH --output=logs/trimalign%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80,FAIL
#SBATCH --job-name="trimalign"

source /etc/profile.d/modules.sh

module purge
module load fastqc/0.11.6
module load bowtie2/2.3.4.1
module load trimgalore/0.4.4
module load picard/2.6.0
module load samtools/1.9
module load igvtools/2.3.95

bname=`basename $1 _R1_001.fastq.gz`

# align & process spike-in reads
DmRef=/data/reference/dawson_labs/genomes/FastQ_Screen_Genomes/Drosophila/BDGP6

bowtie2 --sensitive-local \
  --no-unal \
  --no-mixed \
  --no-discordant \
  --phred33 -I 10 \
  -X 700 \
  -p 4 \
  -t \
  -x $DmRef \
  -U trimmed_fastqs/${bname}_R1_001_trimmed.fq.gz \
  -S alignment/${bname}_Dm.sam

samtools view -b -q 10 -o alignment/${bname}_Dm.bam alignment/${bname}_Dm.sam

samtools sort -o alignment/${bname}_Dm.sort.bam alignment/${bname}_Dm.bam

MarkDuplicates.sh I=alignment/${bname}_Dm.sort.bam \
  O=alignment/${bname}_Dm.sort.rmdup.bam \
  M=alignment/${bname}_Dm.txt \
  REMOVE_DUPLICATES=true \
  VALIDATION_STRINGENCY=SILENT

# remove intermediate files 
rm alignment/${bname}_Dm.sam
rm alignment/${bname}_Dm.bam
