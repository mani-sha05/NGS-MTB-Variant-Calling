#!/bin/bash

# Convert SAM to BAM
samtools view -b Alignment.sam -o Alignment.bam

# Sort BAM
samtools sort Alignment.bam -o Alignment.sorted.bam

# Index sorted BAM
samtools index Alignment.sorted.bam

# Alignment QC
samtools flagstat Alignment.sorted.bam

# Per-base coverage
samtools depth Alignment.sorted.bam > coverage_depth.txt

