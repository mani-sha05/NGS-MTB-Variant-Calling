#!/bin/bash

#command counts the number of variant records
grep -v "^#" Variant.raw.vcf | wc -l


# Variant Filtering
bcftools filter -i 'Qual>=20 &&DP>=10' Variant.raw.vcf -o Variant.filtered.vcf