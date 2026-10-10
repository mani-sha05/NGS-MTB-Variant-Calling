# NGS-MTB-Variant-Calling

## 1. Project Overview

This project demonstrates an end-to-end next-generation sequencing (NGS) bioinformatics workflow for identifying, filtering, and annotating genomic variants in *Mycobacterium tuberculosis* H37Rv.

The analysis uses command-line bioinformatics tools to process paired-end sequencing reads, assess read quality, align reads to a reference genome, call variants, filter low-quality calls, and predict potential functional effects.

## 2. Project Objective

The objectives of this project are to:

- Assess the quality of raw sequencing reads.
- Perform read trimming and filtering.
- Align paired-end reads to the *M. tuberculosis* H37Rv reference genome.
- Process alignment files and evaluate alignment statistics and sequencing depth.
- Identify genomic variants using bcftools.
- Filter variants using quality and read-depth thresholds.
- Annotate variants and examine their predicted functional effects using SnpEff.

## 3. Dataset and Reference Genome

- **Organism:** *Mycobacterium tuberculosis*
- **Reference genome:** *Mycobacterium tuberculosis* H37Rv
- **Sequencing data:** Paired-end FASTQ reads (`TB_R1.fastq` and `TB_R2.fastq`)
- **Reference files:** FASTA, GFF3, and GenBank-format files were used in the workflow.

The analysis was performed on bacterial sequencing data. It did not involve a human sequencing dataset.

*Note: The exact accession or download source for the sequencing reads should be added once verified.*

## 4. Tools and Software Used

| Tool | Purpose |
|---|---|
| FastQC | Assess sequencing-read quality |
| fastp | Trim and filter sequencing reads |
| MultiQC | Summarize quality-control reports |
| BWA-MEM | Align reads to the reference genome |
| samtools | Convert, sort, index, and evaluate alignment files |
| bcftools | Call and filter genomic variants |
| SnpEff | Predict potential functional effects of variants |
| Bash | Execute command-line workflows |
| Git and GitHub | Version control and project sharing |

## 5. Analysis Workflow

The workflow follows these steps:

1. **Initial quality control:** FastQC was used to assess the quality of the raw paired-end reads.
2. **Read preprocessing:** fastp was used to trim and filter sequencing reads.
3. **Post-trimming quality control:** FastQC and MultiQC were used to review read quality.
4. **Reference indexing:** BWA indexing was performed for the reference FASTA.
5. **Read alignment:** BWA-MEM was used to align the cleaned reads to the reference genome.
6. **BAM processing:** samtools was used to convert SAM to BAM, sort and index the BAM file, and generate alignment statistics.
7. **Coverage assessment:** samtools depth was used to calculate read depth across reference positions.
8. **Variant calling:** bcftools mpileup and bcftools call were used to identify candidate variants.
9. **Variant filtering:** Variants were retained when `QUAL >= 20` and `DP >= 10`.
10. **Variant annotation:** SnpEff was used to predict potential functional effects.

### Workflow summary

```text
Raw FASTQ reads
       |
       v
FastQC quality assessment
       |
       v
fastp trimming and filtering
       |
       v
Post-trimming QC
       |
       v
BWA-MEM alignment
       |
       v
SAM/BAM processing with samtools
       |
       v
bcftools variant calling
       |
       v
Variant filtering
       |
       v
SnpEff annotation
       |
       v
Variant summary and interpretation
```

## 6. Important Results

### 6.1 Read quality and preprocessing

The fastp report showed the following results:

- Mean read length before filtering: 150 bp
- Mean read length after filtering: 149 bp
- Q20 before filtering: approximately 95.34%
- Q30 before filtering: approximately 90.33%
- Reads passing the reported fastp filters: 100%

The report showed very little change in the overall quality metrics after preprocessing.

### 6.2 Alignment statistics

The samtools flagstat output reported:

- Total alignment records: 1,167,285
- Mapped records: 1,161,899
- Mapping rate: approximately 99.54%
- Properly paired reads: approximately 98.89%

These results indicate a high mapping rate for the analysed sequencing reads.

### 6.3 Variant calling and filtering

- Raw variants identified: **1,178**
- Filtered variants retained: **1,042**
- Variants removed by filtering: **136**
- Percentage retained after filtering: approximately **88.45%**

The filtering criteria were `QUAL >= 20` and `DP >= 10`.

## 7. Variant Interpretation

### 7.1 Number of variants identified

The variant-calling workflow identified 1,178 candidate variants before filtering.

### 7.2 Number of filtered variants

After applying the quality and read-depth criteria, 1,042 variants were retained for downstream analysis.

### 7.3 Variant types

The SnpEff report classified the 1,042 filtered variants as follows:

| Variant type | Count |
|---|---:|
| Single-nucleotide polymorphisms (SNPs) | 956 |
| Insertions (INS) | 47 |
| Deletions (DEL) | 39 |
| **Total** | **1,042** |

SNPs represented the largest category of identified variants.

### 7.4 Genes affected

SnpEff associated the variants with gene-related annotations, including coding-region and upstream/downstream effects. The annotations include gene identifiers such as `Rv` identifiers and gene names.

However, the exact number of distinct genes affected should be calculated from a validated, deduplicated gene-level results table. It should not be inferred from the total number of SnpEff annotations because one variant can produce multiple annotations involving different genes or genomic regions.

### 7.5 Predicted functional effects

SnpEff reported the following annotation entries by predicted impact:

| Predicted impact | Annotation entries |
|---|---:|
| HIGH | 33 |
| MODERATE | 256 |
| LOW | 584 |
| MODIFIER | 9,204 |
| **Total annotation entries** | **10,077** |

These counts represent annotation entries, not necessarily distinct variants.

The report included predicted effects such as:

- **Missense variants:** Potential amino-acid substitutions in protein-coding genes.
- **Synonymous variants:** Coding changes that do not alter the predicted amino acid.
- **Frameshift variants:** Insertions or deletions that may alter the reading frame.
- **Stop-gained variants:** Changes predicted to introduce a premature stop codon.
- **Upstream and downstream variants:** Changes located near annotated genes.
- **Intergenic variants:** Changes located between annotated genes.

These are computational predictions and do not, by themselves, establish a biological effect or a disease phenotype.

### 7.6 Discussion of selected variants

The annotated VCF contains candidate variants that SnpEff predicts may alter protein sequences. Examples include:

| Position in reference | Gene annotation | Predicted effect | Interpretation |
|---|---|---|---|
| 29,482 | `Rv0025` | Frameshift; `p.Thr81fs` | Candidate for further investigation because a frameshift may alter the downstream protein sequence. |
| 30,688 | `Rv0026` | Missense; `p.Ser323Ala` | Predicted amino-acid substitution that requires further assessment. |
| 95,591 | `hycE` / `Rv0087` | Stop-gained; `p.Glu60*` | Predicted premature stop codon that may truncate the protein. |

**Important validation note:** These are preliminary annotation examples, not confirmed functional findings. The SnpEff report contains 3,711 warnings, including warnings that reference alleles do not match the annotation genome and that some transcripts lack start codons. The reference genome, annotation database, and VCF coordinates/alleles must be checked for consistency before these variants are interpreted biologically.

No conclusion about drug resistance, pathogenicity, or altered bacterial phenotype should be drawn from these predictions alone. Such conclusions would require validated annotations and appropriate supporting evidence.

## 8. Results and Files

The repository contains workflow outputs and supporting files, subject to the final repository cleanup.

Relevant outputs include:

- FastQC and MultiQC quality-control reports
- fastp HTML and JSON reports
- Alignment statistics
- Sequencing-depth information
- Raw and filtered VCF files
- SnpEff annotated VCF
- SnpEff summary report

Large raw sequencing and alignment files should be excluded from GitHub where appropriate. The README documents the workflow and summarizes the main results.

## 9. Conclusion

This project demonstrates a command-line NGS workflow for *Mycobacterium tuberculosis*, covering read quality assessment, preprocessing, reference alignment, alignment statistics, variant calling, filtering, and functional annotation.

A total of 1,178 candidate variants were identified, and 1,042 passed the selected filtering criteria. The retained set contained 956 SNPs, 47 insertions, and 39 deletions.

SnpEff provided preliminary predictions of potential functional effects. However, annotation warnings indicate that additional reference and annotation validation is necessary before making definitive gene-level or biological interpretations.

## 10. Future Improvements

- Validate reference genome and annotation-database consistency.
- Resolve SnpEff reference-mismatch and transcript warnings.
- Generate a deduplicated gene-level variant summary.
- Prioritize and validate variants with potentially high-impact effects.
- Generate visual summaries of variant types and annotation impacts.
- Document the exact sequencing dataset source and reference accession.


