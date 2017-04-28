library(shiny)
require(GenomicRanges)
library(Biostrings)

source('./seekG4hunt.r')


ui =fluidPage(
	headerPanel("G4Hunter Apps",windowTitle='Apps for G4Hunter'),
	p('by L. Lacroix, laurent.lacroix@inserm.fr'),
	helpText(a("Click Here to open the README",href="README.html",target="_blank")),

	wellPanel(h2('Quick G4Hunter calculator'),
						textInput("seq0",label= h4("Sequence"),value="GGGTTAGGGTTAGGGTTAGGG",width='100%'),
						fluidRow(
							column(2,
										 h4("Score (length)")),
							column(4,
										 h4(textOutput("text1"),style="color:red"))),
							style="background-color:lightgreen;"),

	wellPanel(style="background-color:lightblue;",h2('G4Hunter Seeker'),
						fluidRow(
							column(2,
										 radioButtons("intype",h4("Input Type"),c('Manual entry'='man','Fasta File entry'='fas'),inline=F)
							),
							column(3,
										 radioButtons("seqtype",h4("Sequence Type"),c('DNA alphabet'='DNA','RNA alphabet'='RNA'),inline=F)
							),
							column(2,
										 textInput("hl",label= h4("Threshold"),value=1.5,width='80px')
							),
							column(3,
										 textInput("k",label= h4("Window size"),value=20,width='120px')
							)
						),

						wellPanel(textInput("seqname",label= h4("Target name"),value="My_Target",width='25%'),
											em('Copy/paste a sequence below. Up to 5Mb is OK. '),
											em(paste0('Accepted letters are ',paste(DNA_ALPHABET[1:15],collapse=','),' with U instead of T if RNA alphabet is chosen. Spaces are automatically removed. +,- and . are not accepted.')),
											textInput("seq",label= h4("Sequence"),value="TTTGGGGTGGGGTGGGGTGGGGTTAAAAAATATGCATGCATTGGTGGTGTGGTGGTTTTCCCTAACCCTAACCCTAACCCT",width='100%'),
											strong(textOutput('seqcheck'),style="color:blue"),
											strong(textOutput('seqchecklen'),style="color:blue;"),
											style="background-color:pink;"),

						wellPanel(fluidRow(
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
						em('Choose a Fasta file with your DNA or RNA sequence. Up to 5Mb is OK. MultiFasta are not supported.'),style="background-color:pink;"),

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
	))
