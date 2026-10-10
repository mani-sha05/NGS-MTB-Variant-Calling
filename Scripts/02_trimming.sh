#!/bin/bash

# trimming using fastp
fastp -i NGS_Data/TB_R1.fastq -I NGS_Data/TB_R2.fastq -o Trimmed/TB_R1.fastq -O Trimmed/TB_R2.fastq -h Trimmed/fastp.html -j Trimmed/fastp.json 


# MultiQC report for QC results
multiqc Trimmed/ -o QC/Multiqc_trimmed/
