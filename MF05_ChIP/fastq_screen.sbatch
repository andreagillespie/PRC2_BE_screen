#!/bin/bash

#SBATCH --partition=rhel_short
#SBATCH --container=/config/spack/containers/centos7/container.sif
#SBATCH --nodes=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=48G
#SBATCH --time=1-00:00:00
#SBATCH --output=logs/trimalign%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80,FAIL
#SBATCH --job-name="trimalign"

source /etc/profile.d/modules.sh

module purge

module load fastq-screen/0.15.3

fastq_screen --conf /data/reference/dawson_labs/genomes/FastQ_Screen_Genomes/fastq_screen.conf \
  --threads 2 --outdir fastq_screen $1