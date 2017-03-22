library(shiny)
require(GenomicRanges)
library(Biostrings)

source('./seekG4hunt.r')


ui =fluidPage(
	headerPanel("G4Hunter Apps"),
	p('by L. Lacroix, laurent.lacroix@inserm.fr'),
	hr(),
	h2('Quick G4Hunter calculator'),
	textInput("seq0",label= h4("Sequence"),value="GGGTTAGGGTTAGGGTTAGGG",width='100%'),
	h4("Score (length)"),textOutput("text1"),
	hr(),
	h2('G4Hunter Seeker'),
	fluidRow(
		column(2,
					 radioButtons("intype",h4("Input Type"),c('Manual entry'='man','Fasta File entry'='fas'),inline=F)
		),
		column(3,
					 radioButtons("seqtype",h4("Sequence Type"),c('DNA alphabet'='DNA','RNA alphabet'='RNA'),inline=F)
		),
		column(3,
					 textInput("hl",label= h4("Threshold"),value=1.5)
		),
		column(3,
					 textInput("k",label= h4("Window size"),value=20)
		)
	),

	hr(),
	textInput("seqname",label= h4("Target name"),value="My_Target"),
	em('copy/paste a sequence. Up to 5Mb is OK. '),
	em(paste0('Accepted letters are ',paste(DNA_ALPHABET[1:15],collapse=','),' with U instead of T if RNA alphabet is chosen. Spaces are automatically removed. +,- and . are not accepted.')),
	textInput("seq",label= h4("Sequence"),value="TTTGGGGTGGGGTGGGGTGGGGTTAAAAAATATGCATGCATTGGTGGTGTGGTGGTTTTCCCTAACCCTAACCCTAACCCT",width='100%'),
	textOutput('seqcheck'),
	hr(),
	fluidRow(
		column(4,
					 fileInput('file1', label= h4('Choose a FASTA File'))
		),
		column(3,
					 checkboxInput('altnames', 'Alternate Seqname', F)
		),
		column(3,
					 textInput('altnam',label=h4('New Seqname'),value='YourName')
		)
	),
	em('Choose a Fasta file with your DNA or RNA sequence. Up to 5Mb is OK. MultiFasta are not supported.'),
	hr(),
	h3('Results'),
	fluidRow(
		column(3,
					 checkboxInput('withseq', 'Report sequences', T)
		),
		column(3,
					 checkboxInput('Gseq', 'Report G-sequences', F)
		)
	),
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
