#!bin/bash
genome="$1"
id="$2"


samtools view -b -h $genome $id > $id.bam
samtools index $id.bam
htsbox samview -p $id.bam | less -S > $id.bam.mappins.paf
cat $id.bam.mappins.paf | awk '{print $2}' | sort -n > $id.bam.mappins.paf.sizes
cat $id.bam.mappins.paf | awk '{print $1 " " ( $4 - $3)*100/$2}' > $id.bam.mappins.paf.percentageMapping
cat $id.bam.mappins.paf.percentageMapping | awk '{ if ($2<=90) print $0}' > $id.bam.mappins.paf.percentageMapping.numts
