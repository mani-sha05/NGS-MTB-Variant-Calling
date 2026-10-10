#!/bin/bash

# Read Alignment

bwa mem NGS_Data/Mycobacterium_tuberculosis_h37rv.ASM19595v2.dna.chromosome.Chromosome.fasta Trimmed/TB_R1.fastq Trimmed/TB_R2.fastq > Alignment/Alignment.sam
