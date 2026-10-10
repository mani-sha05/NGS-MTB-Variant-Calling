#!/bin/bash

# Quality control of raw reads
fastqc TB_R1.fastq \ TB_R2.fastq \ -o .. /QC/Raw 

# Combine FastQC reports with MultiQC
multiqc QC/Raw -o QC/Multiqc/
