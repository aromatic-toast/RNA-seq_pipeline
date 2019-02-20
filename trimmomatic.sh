#! /bin/bash
#SBATCH --account=def-kladams
#SBATCH --job-name=trimmomatic.sh
#SBATCH --time 7:00:00
#SBATCH --mem-per-cpu=4096
#SBATCH --mincpus=8
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=FAIL
#SBATCH --mail-type=END
#SBATCH --mail-user=iamthelm@gmail.com

# remove the suffix from each sample name in the provided directory and redirect output into
# the sample list text file 
#($1 variable is the direcotry of choice where I want to remove remove suffix names)

ls $1 | grep _1.fastq | sed s/_1.fastq//g > $1/trimmomatic_sample_list.txt

# run trimmomatic on all samples in the input text file 

while read name

do 
echo ${name}
 
java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.36.jar \
PE \
-threads 8 \
$1/${name}_1.fastq $1/${name}_2.fastq \
$1/TrimmedReads/paired/trimmed_${name}_P1.fastq $1/TrimmedReads/unpaired/trimmed_${name}_U1.fastq \
$1/TrimmedReads/paired/trimmed_${name}_P2.fastq $1/TrimmedReads/unpaired/trimmed_${name}_U2.fastq \
AVGQUAL:20 HEADCROP:5 MINLEN:50  

done < $1/trimmomatic_sample_list.txt


