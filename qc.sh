#! /bin/bash
#SBATCH --account=def-kladams
#SBATCH --job-name=qc.sh
#SBATCH --time 6:00:00
#SBATCH --mem-per-cpu=4096
#SBATCH --mincpus=4
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=FAIL
#SBATCH --mail-type=END
#SBATCH --mail-user=iamthelm@gmail.com

#to be run on the "TrimmedReads/paired" directory 

# run fastqc on all input samples

# the $1 variable specifies the first thing entered on the standard input of the command line
# after executing the shell script by name. This input $1 variable is a place holder for the
# text file containing names of fastq files formatted in a vertical list 

# the while loop reads each line in the text file line by line
# and the appropriate name of the fastq file is plugged in, replacing the ${name} variable 

ls $1 | grep 1.fastq | sed s/1.fastq//g > $1/sample_list.txt

while read name
do

echo ${name}

fastqc -q --outdir $1/TrimmedQC  $1/${name}1.fastq $1/${name}2.fastq
done < $1/sample_list.txt


