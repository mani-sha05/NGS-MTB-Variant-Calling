#!/bin/bash

# mpileup
 bcftools mpileup -f NGS_Data/Mycobacterium_tuberculosis_h37rv.ASM19595v2.dna.chromosome.Chromosome.fasta Alignment/Alignment.sorted.bam -o Variant/Variant.mpileup.bcf -O b

# BCFtools
bcftools call -m -v --ploidy 1 -o Variant/Variant.raw.vcf Variant/Variant.mpileup.bcf

