# calcdinuclfrequency

This repository serves as an example of two code snippets I contributed to from [GenomicDistributions](https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-022-08467-y) [(Github Repo)](https://github.com/databio/GenomicDistributions)

The first function, calcdinuclfreq, calculates the frequency of dinucleotides (base pairs, such as A, T, G, or C) in a given GRanges object, an object of genomic regions and associated metadata. 

Input: a reference genome, such as hg38, and a GRanges object. 
Output: a numeric vector with % of C's and G's, for example.

The second function, plotdinucleotidefreq, generates a density plot with ggplot2 showing the density of dinucleotides in the given genomic range.

These functions were merged into the GenomicDistributions package, and updated consistently. The current code can be seen [here](https://github.com/databio/GenomicDistributions/blob/devel/R/content-plots.R), and the vignette can be seen [here](https://code.databio.org/GenomicDistributions/articles/full-power.html#dinucleotide-frequencies).


