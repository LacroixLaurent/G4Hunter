
library(shiny)

server = (function(input, output) {

	showModal(modalDialog(
		title = "G4Hunter notes",
		"The top part of this page allows you to compute the G4Hunter score of a single sequence. This main App (G4Hunter Seeker) identifies DNA or RNA regions in a longer sequence for which the G4Hunter score is above the threshold in windows of the selected size. Please cite Bedrat A, Lacroix L & Mergny JL (2016) Re-evaluation of G-quadruplex propensity with G4Hunter. Nucleic Acids Res 44(4):1746-1759, when reporting results obtained with this App.",
		easyClose = TRUE
	))
	# Quick Score
	QuickScore <- reactive({
		resu <- c(signif(G4Hscore(toupper(gsub(' ','',input$seq0))),3),'(',length(strsplit(as.character(gsub(' ','',input$seq0)),NULL)[[1]]),')')
	})

	output$text1 <- renderText({QuickScore()})

	# Seeker part
	## Checking input text
	checkInLength <- reactive({
		checlen <- NULL
		if (nchar(input$seq)<as.numeric(input$k) & input$intype=='man') {checlen <- 'Input sequence shorter than the window size'}
		return(checlen)
	})

	checkInput <- reactive({
		if (input$seqtype=='DNA')
		{
			chec <- grepl(paste0('[^(',paste(DNA_ALPHABET[1:15],collapse=','),')]'),gsub('[[:space:]]','',input$seq),ignore.case=T)
			if (!chec) {chectext <- 'DNA OK'} else {chectext <- 'wrong letter in your DNA'}
		}
		if (input$seqtype=='RNA')
		{
			chec <- grepl(paste0('[^(',paste(RNA_ALPHABET[1:15],collapse=','),')]'),gsub('[[:space:]]','',input$seq),ignore.case=T)
			if (!chec) {chectext <- 'RNA OK'} else {chectext <- 'wrong letter in your RNA'}
		}
		return(chectext)
	})
	# importing input seq to biostring
	dataInput <- reactive({
		dataseq <- NULL
		if (input$intype=='man')
		{
			if (grepl('OK',checkInput()) & is.null(checkInLength()))
			{
				if (input$seqtype=='DNA')
				{dataseq <- DNAStringSet(gsub(' ','',input$seq))}
				if (input$seqtype=='RNA')
				{dataseq <- RNAStringSet(gsub(' ','',input$seq))}
			}
		}
		if (input$intype=='fas')
		{
			inFile <- input$file1
			if (is.null(inFile))
			{return(NULL)}
			if (input$seqtype=='DNA')
			{dataseq <- readDNAStringSet(inFile$datapath,'fasta')}
			if (input$seqtype=='RNA')
			{dataseq <- readRNAStringSet(inFile$datapath,'fasta')}
		}
		return(dataseq)
	})

# seeking G4Hunt sequences
	dataProcessed <- reactive({
		if (!is.null(dataInput()))
		{
			if (input$intype=='man')
			{
				if (grepl('OK',checkInput()) & is.null(checkInLength())) {
					hunted <- modG4huntref(k=as.numeric(input$k),hl=as.numeric(input$hl),chr=dataInput()[[1]],seqname=input$seqname,with.seq=input$withseq,Gseq.only=input$Gseq)
					if (length(hunted)!=0)
						{
						res <- as.data.frame(hunted)
						colnames(res)[8] <- 'threshold'
						colnames(res)[9] <- 'window'
						}
						else
						{res <- NULL}
				}
			}
			if (input$intype=='fas')
			{
				if (input$altnames) {senam <- input$altnam}else{senam <-names(dataInput())[1]}
				hunted <- modG4huntref(k=as.numeric(input$k),hl=as.numeric(input$hl),chr=dataInput()[[1]],seqname=senam,with.seq=input$withseq,Gseq.only=input$Gseq)
				if (length(hunted)!=0)
				{
					res <- as.data.frame(hunted)
					colnames(res)[8] <- 'threshold'
					colnames(res)[9] <- 'window'
				}
				else
				{res <- NULL}
				}
		}else{
			res <- NULL
		}
		return(res)
	})


	output$seqcheck <- renderText(checkInput())
	output$seqchecklen <- renderText(checkInLength())

	output$result <- renderTable(dataProcessed())
	output$seqlength <- renderText(length(dataInput()[[1]]))
	output$hits <- renderText(length(dataProcessed()[,1]))

	output$downloadData <- downloadHandler(
		filename = function() {paste0(dataProcessed()[1,1],'_',input$seqtype,'_hl=',input$hl,'_k=',input$k,'_G4Hseeked_',Sys.Date(),'.txt')},
		content = function(file) {
			write.table(dataProcessed(), file,sep='\t',col.names=T,row.names=F)
		})
})
