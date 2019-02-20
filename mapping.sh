#! /bin/bash
#SBATCH --account=def-kladams
#SBATCH --job-name=mapping.sh
#SBATCH --mem=30G
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --time 12:00:00
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=FAIL
#SBATCH --mail-type=END
#SBATCH --mail-user=iamthelm@gmail.com

# to be run on "TrimmedReads/paired" directory 

# map the directory of trimmed FastQ files to the genome 

ls $1 | grep _P1.fastq | sed s/_P1.fastq//g > $1/sample_list.txt

while read name 

do

echo ${name}

STAR \
--runThreadN 8 \
--genomeDir $1/Alignments/indexes \
--readFilesIn \
$1/${name}_P1.fastq \
$1/${name}_P2.fastq \
--outFileNamePrefix $1/Alignments/${name} \
--outFilterMultimapNmax 20 \
--quantMode GeneCounts \
--alignSJoverhangMin 8 \
--alignSJDBoverhangMin 8 \
--outFilterMismatchNmax 20 \
--alignIntronMin 35 \
--alignIntronMax 2000 \
--alignMatesGapMax 20000 \
--alignEndsType EndToEnd \
--outSAMstrandField intronMotif
done < $1/sample_list.txt 


