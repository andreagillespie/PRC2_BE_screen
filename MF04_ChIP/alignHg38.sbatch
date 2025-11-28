#!/bin/bash
 
#SBATCH --partition=rhel_short
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --output=../../scripts/MF04_ChIP/logs/trimalign%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80,FAIL
#SBATCH --job-name="trimalign"

module purge

module load fastqc/0.12.1-gcc-13.2.0
module load bowtie2/2.5.2-gcc-13.2.0-celp7jm
module load trimgalore/0.6.10-gcc-13.2.0
module load picard/3.1.1-gcc-13.2.0
module load samtools/1.19.2-gcc-13.2.0
module load igvtools/2.3.98-gcc-13.2.0

bname=`basename $1 _R1_001.fastq.gz`

Reference=/data/reference/dawson_labs/genomes/Hg38/Homo_sapiens.GRCh38.dna.toplevel.fa

fastqc -o fastqc/ -f fastq $1

trim_galore --fastqc -o trimmed_fastqs $1

bowtie2 --sensitive-local \
  --no-unal \
  --no-mixed \
  --no-discordant \
  --phred33 \
  -I 10 \
  -X 700 \
  -p 4 \
  -t \
  -x $Reference \
  -U trimmed_fastqs/${bname}_R1_001_trimmed.fq.gz \
  -S alignment/${bname}.sam

samtools view -b \
  -L /data/reference/dawson_labs/whitelists/Hg38WhitelistV2nochr.bed \
  -q 10 \
  -@ 3 \
  -o alignment/${bname}.bam \
  alignment/${bname}.sam

samtools sort -@ 3 \
  -o alignment/${bname}.sort.bam \
  alignment/${bname}.bam

MarkDuplicates.sh I=alignment/${bname}.sort.bam \
  O=alignment/${bname}.sort.rmdup.bam \
  M=alignment/${bname}.txt \
  REMOVE_DUPLICATES=true \
  VALIDATION_STRINGENCY=SILENT

samtools index -@ 3 alignment/${bname}.sort.rmdup.bam

igvtools count alignment/${bname}.sort.rmdup.bam tdfs/${bname}.tdf hg38

# remove intermediate files 
rm alignment/${bname}.sam
rm alignment/${bname}.bam

