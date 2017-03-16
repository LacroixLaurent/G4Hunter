library(shiny)
require(GenomicRanges)
library(Biostrings)

source('./seekG4hunt.r')


ui =fluidPage(
	headerPanel("G4Hunter FastaSeeker (DNA or RNA)"),
	p('by L. Lacroix, laurent.lacroix@inserm.fr'),
	hr(),
	fluidRow(
		column(2,radioButtons("seqtype","Sequence Type",c('DNA'='DNA','RNA'='RNA'),inline=T))
	),
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
		column(3,
					checkboxInput('withseq', 'Report sequences', T)
					 ),
		column(3,
					checkboxInput('Gseq', 'Report G-sequences', F)
					 ),
		column(3,
					checkboxInput('altnames', 'Alternate Seqname', F)
					 ),
		column(3,
					textInput('altnam',label=h4('New Seqname'),value='YourName')
					 )

	),
em('Choose a Fasta file with your DNA/RNA sequence. Up to 5Mb is OK. MultiFasta are not supported (yet)'),
	h5('Length of the Input Sequence'),
	textOutput('seqlength'),
	h5('Number of hits'),
	textOutput('hits'),
	hr(),
	tableOutput('result'),
	downloadButton('downloadData', 'Download Results')
)
