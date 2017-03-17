
library(shiny)

server = (function(input, output) {

	#showModal(modalDialog(
	#	title = "G4Hunter seeker",
	#	"This app identifies DNA regions in a longer DNA sequence for which the G4Hunter score is above the threshold in the window selected size",
	#	easyClose = TRUE
	#))
	checkInput <- reactive({
		grepl(paste0('[^(',paste(DNA_ALPHABET[1:15],collapse=','),')]'),gsub('[[:space:]]','',input$seq),ignore.case=T)
	})
	dataInput <- reactive({
		dataseq <- NULL
		if (input$intype=='man')
		{
			dataseq <- DNAStringSet(gsub(' ','',input$seq))
		}
		if (input$intype=='fas')
		{
			inFile <- input$file1
			if (is.null(inFile))
			{return(NULL)}
			dataseq <- readDNAStringSet(inFile$datapath,'fasta')
		}
		return(dataseq)
	})

	dataProcessed <- reactive({
		if (!is.null(dataInput()))
		{
			if (input$intype=='man')
			{
				if (!checkInput()) {
					hunted <- modG4huntref(k=as.numeric(input$k),hl=as.numeric(input$hl),chr=dataInput()[[1]],seqname=input$seqname,with.seq=input$withseq,Gseq.only=input$Gseq)
					res <- as.data.frame(hunted)
				}
			}
			if (input$intype=='fas')
			{
				if (input$altnames) {senam <- input$altnam}else{senam <-names(dataInput())[1]}
				hunted <- modG4huntref(k=as.numeric(input$k),hl=as.numeric(input$hl),chr=dataInput()[[1]],seqname=senam,with.seq=input$withseq,Gseq.only=input$Gseq)
				res <- as.data.frame(hunted)}
		}else{
			res <- NULL
		}
		return(res)
	})


	output$seqcheck <- renderText(if (!checkInput()) {'DNA OK'}else{'Wrong letter in your DNA'})
	output$result <- renderTable(dataProcessed())
	output$seqlength <- renderText(length(dataInput()[[1]]))
	output$hits <- renderText(length(dataProcessed()[,1]))

	output$downloadData <- downloadHandler(
		filename = function() {paste0(dataProcessed()[1,1],'_hl=',input$hl,'_k=',input$k,'_G4Hseeked_',Sys.Date(),'.txt')},
		content = function(file) {
			write.table(dataProcessed(), file,sep='\t',col.names=T,row.names=F)
		})
})
