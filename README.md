# G4Hunter
#### App related to G4Hunter published in [Bedrat et al NAR 2016][paper ref].  
Supplementary Data can be downloaded from [here](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4770238/bin/supp_44_4_1746__index.html).  
The _EF184640.1.fa_ corresponds to the human mitochondrial genome used in the publication.  
The _hTERC.fa_ is the RNA sequence of the human telomerase component.

##### The app requires the following packages:
* Biostrings
* GenomicRanges
* (S4Vectors)
* (shiny)

The file to download has to be a **single** fasta file that do not exceeds the size limit imposed by Shiny (default is 5Mb, see below how to change it).  
Letters in the sequence have to belong the the DNA or RNA alphabet (A,C,T or U,G,M,R,W,S,Y,K,V,H,D,B,N). Gaps (- or .) and hard masking (+) are also accepted.  
You have to choose if your sequence is a **DNA** or **RNA** sequence.  
<<<<<<< HEAD
Chosse **RNA** only if you have **U** in your sequence. If your fasta corresponding to the **RNA** contains **T** and not **U**, please select **DNA**.  
Mix sequences with **T** and **U** are not supported.  
=======
Choose **RNA** only if you have **U** in your sequence. If your fasta corresponding to the **RNA** contains **T** and not **U**, please select **DNA**
>>>>>>> 9d9e7803991c565dd6a5953fb54de257d4fc6aa2

##### There may be a bug if the wrong type is chosen but it is only at the console.


The **Threshold** and **Window size** fixe the parameters for the sequence search as described in the [publication][paper ref].  
The **Report sequences** option adds the nucleotide sequences in the output.  
The **Report G_sequences** option changes sequences with a negative score (C-rich sequences) into their reverse complement. Thus the output reports only G-riche sequences.

The first line of the fasta file (after the > sign) imposes the sequence name (seqname) in the output. This can be changed by checking the **Alternate Seqname** option and entering the chosen sequence name in the **New Seqname** option.

Pleas check that the **Length of the Input Sequence** corresponds to the length of the DNA/RNA sequence you enter with your Fasta file.  
The **hits** report the number of sequences retrieved that match the settings.  

The output table contains the sequence name (**seqnames**), the **start**, **end** and **width** of the _refined_ sequences, that meet the search criteria.  
The **strand** is **+** if the proposed G4 forming sequence is in the Input Sequence and this is set to **-** if the G4 forming sequence in on the reverse complementary strand.  
The **score** is the G4Hunter score of the _refined_ sequence and **max_score** is the highest score in absolute value in a window of the chosen **window size** for the sequence.  
**hl** and **k** are respectively the **Threshold** and **Window size** used for the search.  
_these names could be changed to be more explicit into threshold and window size_  

The **sequence** correspond the the _refined_ sequence in the **Input file**. This field is sensitive to the **Report G-sequences** option. This field is not present if the **Report sequences** option is not selected.  
Please note that the procedure extracts sequences that have a G4Hunter score above the threshold (in absolute value) in a window, fuses the overlapping sequences and then _refines_ theses sequences by removing bases at the extremities that are not G for sequences with a positive score (or C the negative ones). It also looks at the first neigbouring base and adds it to the sequence if it is a G for sequences with a positive score (C for sequences with a negative score).  
Please see the [pulbication][paper ref] and Figure S1B for more details

The output can be exported to a text file that can be directly opened with _Microsoft Excel_.

--------------------------------------------------------------------------
As this is a simple Shiny app, there is a limit to the size you can upload (5Mb).  
If necessary (but might not be good for the host), the size limit can be increased  to XX Mb by adding the following code at the top of the server.R file (_adapted [from stackoverflow](http://stackoverflow.com/questions/18037737/how-to-change-maximum-upload-size-exceeded-restriction-in-shiny-and-save-user)_).  
```{r}
options(shiny.maxRequestSize=XX*1024^2)
```



[paper ref]:http://doi.org/10.1093/nar/gkw006
