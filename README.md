# G4Hunter
App related to G4Hunter published in [Bedrat et al NAR 2016](doi.org/10.1093/nar/gkw006)  
Supplementary Data can be downloaded from [here](www.ncbi.nlm.nih.gov/pmc/articles/PMC4770238/bin/supp_44_4_1746__index.html)  
The EF184640.1.fa corresponds to the human mitochondrial genome used in the publication.

The app requires the following packages:
* Biostrings
* GenomicRanges
* (S4Vectors)
* (shiny)

The file size limit might need to be hardcoded. I have tried fasta file up to 5Mb and it seems to work.  
Above this, there is an upload limit error message
