# G4Hunter
App related to G4Hunter published in [Bedrat et al NAR 2016](http://doi.org/10.1093/nar/gkw006).  
Supplementary Data can be downloaded from [here](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4770238/bin/supp_44_4_1746__index.html).  
The EF184640.1.fa corresponds to the human mitochondrial genome used in the publication.

The app requires the following packages:
* Biostrings
* GenomicRanges
* (S4Vectors)
* (shiny)

As this is a simple Shiny app, there is a limit to the size you can upload (5Mb).  
If necessary (but might not be good for the host), the size limit can be increased  to XX Mbby adding  
_options(shiny.maxRequestSize=XX*1024^2)_  
at the top of the server.R file
