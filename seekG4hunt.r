##########################################################
G4translate <- function(y,v1=1,v2=2,v3=3,v4=4)		
# x a DNAString or a DNAStringSet (or just a string of char)
{
require(S4Vectors)
x= Rle(strsplit(as.character(y),NULL)[[1]])
xres=x
runValue(xres)[runValue(x)=='C' & runLength(x)>3] <- -v4
runValue(xres)[runValue(x)=='C' & runLength(x)==3] <- -v3
runValue(xres)[runValue(x)=='C' & runLength(x)==2] <- -v2
runValue(xres)[runValue(x)=='C' & runLength(x)==1] <- -v1
runValue(xres)[runValue(x)=='G' & runLength(x)>3] <- v4
runValue(xres)[runValue(x)=='G' & runLength(x)==3] <- v3
runValue(xres)[runValue(x)=='G' & runLength(x)==2] <- v2
runValue(xres)[runValue(x)=='G' & runLength(x)==1] <- v1
runValue(xres)[runValue(x)!='C' & runValue(x)!='G'] <- 0	# N or U are not a problem
Rle(as.numeric(xres))
}
################################################################################

################################################################################
##### return the G4Hscore. y is a string of char (DNA sequence)
G4Hscore <- function(y)
	{
		y3=G4translate(y)
		mean(y3)
	}
################################################################################

################################################################################
##### function to refine G4hunt results

G4startrun=function(y,chrom=chr,letter='C')	#y is a START
	{
		if (letter(chrom,y)==letter)
			{
			while (letter(chrom,y)==letter & y!=1) 
				{
					if (letter(chrom,y-1)==letter) 
					{
						y <- y-1
					}else{
						break
					}
				}
			}else{
			y=y+1
			while (letter(chrom,y)!=letter) {y=y+1}
			}	
		return(y)
	}

G4endrun=function(y,chrom=chr,letter='C')	#y is a END
	{
		if (letter(chrom,y)==letter)
			{
			
				while (letter(chrom,y)==letter & y!=length(chrom))
					{
						if (letter(chrom,y+1)==letter)
						{
						y <- y+1
						}else{
						break
						}
					}
								
			}else{
			y=y-1
			while (letter(chrom,y)!=letter) {y=y-1}
			}
		return(y)
	}
################################################################################


################################################################################
## modified mG4hunt to add the refining procedure

modG4huntref <- function(k=25,hl=1.5,chr,seqname='target',with.seq=T,Gseq.only=F)
{
require(GenomicRanges,Biostrings)
#### k=RUNMEAN WINDOW SIZE, hl=threshold

tchr <- G4translate(chr)
chr_G4hk <- runmean(tchr,k)

j <- hl
chrCh <- Views(chr_G4hk, chr_G4hk<=(-j))
chrGh <- Views(chr_G4hk, chr_G4hk>=j)

IRC <- reduce(IRanges(start=start(chrCh),end=(end(chrCh)+k-1)))
if (length(IRC)==0)
	{
	nxC <- GRanges()                                
	}else{
	nnIRC=IRC
	start(nnIRC)=sapply(start(IRC),G4startrun,letter='C',chrom=chr)
	end(nnIRC)=sapply(end(IRC),G4endrun,letter='C',chrom=chr)
	seqC=as.character(Views(chr,nnIRC))
	if (Gseq.only) 
		{
			nnseqC=as.character(reverseComplement(Views(chr,nnIRC)))
		}else{
			nnseqC=as.character(Views(chr,nnIRC))
		}
	nG4scoreC=sapply(seqC,function(x) signif(G4Hscore(x),3))
	mscoreC <- signif(min(Views(chr_G4hk,IRC)),3)
	straC <- Rle(rep('-',length(IRC)))
	hlC <- Rle(rep(j,length(IRC)))
	kC <- Rle(rep(k,length(IRC)))
	nxC <- GRanges(seqnames=Rle(seqname),  
    ranges=nnIRC,
    strand=straC,
    score=nG4scoreC,
    max_score=mscoreC,
    hl=hlC,
    k=kC,
    sequence=nnseqC)
	}

IRG <- reduce(IRanges(start=start(chrGh),end=(end(chrGh)+k-1)))
if (length(IRG)==0)
	{
	nxG <- GRanges()                                
	}else{
	nnIRG=IRG
	start(nnIRG)=sapply(start(IRG),G4startrun,letter='G',chrom=chr)
	end(nnIRG)=sapply(end(IRG),G4endrun,letter='G',chrom=chr)
	nnseqG=as.character(Views(chr,nnIRG))
	nG4scoreG=sapply(nnseqG,function(x) signif(G4Hscore(x),3))
	mscoreG <- signif(max(Views(chr_G4hk,IRG)),3)
	straG <- Rle(rep('+',length(IRG)))
	hlG <- Rle(rep(j,length(IRG)))
	kG <- Rle(rep(k,length(IRG)))
	nxG <- GRanges(seqnames=Rle(seqname),  
    ranges=nnIRG,
    strand=straG,
    score=nG4scoreG,
    max_score=mscoreG,
    hl=hlG,
    k=kG,
    sequence=nnseqG)
	}

nx <- sort(c(nxC,nxG),ignore.strand=T)
names(nx) <- NULL
if (with.seq==F) {nx$sequence=NULL}
return(nx)
}


############

