library(shiny)
require(GenomicRanges)
library(Biostrings)

source('./seekG4hunt.r')


ui =fluidPage(
	headerPanel("G4Hunter FastaSeeker (DNA)"),
	p('by L. Lacroix, laurent.lacroix@inserm.fr'),
	hr(),
	fluidRow(
		column(6,
					 fileInput('file1', label= h3('Choose a FASTA File'))
		),
		column(3,
					 textInput("hl",label= h3("Threshold"),value=1.5)
		),
		column(3,
					 textInput("k",label= h3("Window size"),value=25)
		)
	),
	fluidRow(
		column(6,
					 checkboxInput('altnames', 'Alternate Seqname', F)
					 ),
		column(6,
					 textInput('altnam',label=h4('New Seqname'),value='YourName')
					 )
	),
	em('Choose a Fasta file with your DNA sequence. Up to 200kb is OK. MultiFasta are not supported (yet)'),
	h5('Length of the Input Sequence'),
	textOutput('seqlength'),
	# I tried up to 200kb and it seems OK
	hr(),
	tableOutput('result'),
	downloadButton('downloadData', 'Download Results')
)
