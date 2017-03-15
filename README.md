# G4Hunter
App related to G4Hunter published in [Bedrat et al NAR 2016](https://doi.org/10.1093/nar/gkw006)  
The EF184640.1.fa corresponds to the human mitochondrial genome used in the publication.

The app requires the following packages:
* Biostrings
* GenomicRanges
* (S4Vectors)
* (shiny)

The file size limit might need to be hardcoded. I have tried fasta file up to 5Mb and it seems to work.  
Above this, there is a upload limit error message
