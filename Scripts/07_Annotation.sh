#!/bin/bash

# configure SnpEff
nano $CONDA_PREFIX/share/snpeff-5.4.0c-0/snpEff.config

#build a database
snpEff build -genbank -v wildtype

#Variant annotation
snpEff wildtype Variant.filtered.vcf > Variant.ann.vcf
