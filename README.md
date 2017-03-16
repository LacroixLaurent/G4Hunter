# G4Hunter
App related to G4Hunter published in [Bedrat et al NAR 2016][paper ref].  
Supplementary Data can be downloaded from [here](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4770238/bin/supp_44_4_1746__index.html).  
The EF184640.1.fa corresponds to the human mitochondrial genome used in the publication.

The app requires the following packages:
* Biostrings
* GenomicRanges
* (S4Vectors)
* (shiny)

The file to download has to be a **single** fasta file that do not exceeds the size limit imposed by Shiny (default is 5Mb, see below how to change it)  
Letter in the sequence have to belong the the DNA alphabet (A,C,T,G,M,R,W,S,Y,K,V,H,D,B,N). Gaps (- or .) and hard masking (+) are also accepted.  

The _Threshold_ and _Window size_ fixe the parameters for the sequence search as described in the [publication][paper ref].

>As this is a simple Shiny app, there is a limit to the size you can upload (5Mb).  
>If necessary (but might not be good for the host), the size limit can be increased  to XX Mb by adding  
>```{r}
>options(shiny.maxRequestSize=XX*1024^2)
>```
>at the top of the server.R file  
>_adapted [from stackoverflow](http://stackoverflow.com/questions/18037737/how-to-change-maximum-upload-size-exceeded-restriction-in-shiny-and-save-user)_  


[paper ref]:http://doi.org/10.1093/nar/gkw006
