#! /bin/bash
#SBATCH --account=def-kladams
#SBATCH --job-name=featureCounts.sh
#SBATCH --time 12:00:00
#SBATCH --mem-per-cpu=4096
#SBATCH --mincpus=8
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=FAIL
#SBATCH --mail-type=END
#SBATCH --mail-user=iamthelm@gmail.com

# run this script on the Alignments directory that contains as subdirectories both "sam" directory and "annotation" directory

# remove the suffix from each sample name in the provided directory and redirect output into
# the sample list text file
#($1 variable is the direcotry of choice where I want to remove remove suffix names)

ls $1/sam | grep Aligned.out.sam | sed s/Aligned.out.sam//g > $1/sam/sample_list.txt

# run featureCounts on each sam file in the input text file

while read name

do
echo ${name}

featureCounts -p -a $1/annotation/Araport11_GFF3_genes_transposons.201606.gtf -o $1/sam/featureCounts.txt $1/sam/${name}Aligned.out.sam

done < $1/sam/sample_list.txt

