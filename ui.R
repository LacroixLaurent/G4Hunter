library(shiny)
require(GenomicRanges)
library(Biostrings)

source('./seekG4hunt.r')


ui =fluidPage(
	headerPanel("G4Hunter Seeker"),
	p('by L. Lacroix, laurent.lacroix@inserm.fr'),
	hr(),
	fluidRow(
		column(4,
					 radioButtons("intype",h3("Input Type"),c('Manual entry'='man','Fasta File entry'='fas'),inline=T)
		),
		column(3,
					 textInput("hl",label= h3("Threshold"),value=1.5)
		),
		column(3,
					 textInput("k",label= h3("Window size"),value=20)
		)
	),

	hr(),
	textInput("seqname",label= h4("Target name"),value="My_Target"),
	em('copy/paste a DNA sequence. Up to 5Mb is OK. '),
	em(paste0('Accepted letters are ',paste(DNA_ALPHABET[1:15],collapse=','))),
	textInput("seq",label= h4("Sequence"),value="TTTGGGGTGGGGTGGGGTGGGGTTAAAAAATATGCATGCATTGGTGGTGTGGTGGTTTTCCCTAACCCTAACCCTAACCCT",width='100%'),
	textOutput('seqcheck'),
	hr(),
	fluidRow(
		column(4,
					 fileInput('file1', label= h4('Choose a DNA FASTA File'))
		),
		column(3,
					 checkboxInput('altnames', 'Alternate Seqname', F)
		),
		column(3,
					 textInput('altnam',label=h4('New Seqname'),value='YourName')
		)
	),
	em('Choose a Fasta file with your DNA sequence. Up to 5Mb is OK. MultiFasta are not supported (yet).'),
	hr(),
	fluidRow(
		column(3,
					 checkboxInput('withseq', 'Report sequences', T)
		),
		column(3,
					 checkboxInput('Gseq', 'Report G-sequences', F)

		)

	),
	hr(),
	fluidRow(
		column(3,
					 h5('Number of hits'),
					 textOutput('hits')
		),
		column(3,
					 h5('Length of the Input Sequence'),
					 textOutput('seqlength')
		)
	),

	downloadButton('downloadData', 'Download Results'),
	tableOutput('result')
)
