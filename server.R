
library(shiny)

server = (function(input, output) {


	dataInput <- reactive({
		inFile <- input$file1
		if (is.null(inFile))
			return(NULL)
		dataseq <- readDNAStringSet(inFile$datapath,'fasta')
	})
	dataProcessed <- reactive({
		if (!is.null(dataInput()))
		{
			if (input$altnames) {senam <- input$altnam}else{senam <-names(dataInput())[1]}
			toto <- modG4huntref(k=as.numeric(input$k),hl=as.numeric(input$hl),chr=dataInput()[[1]],seqname=senam)
			res <- as.data.frame(toto)
		}else{
				res <- NULL
		}
		return(res)
	})

	output$result <- renderTable(dataProcessed())
	output$seqlength <- renderText(length(dataInput()[[1]]))
	output$downloadData <- downloadHandler(
		filename = function() {paste0(input$altnam,'_hl=',input$hl,'_k=',input$k,'_G4Hseeked_',Sys.Date(),'.txt')},
		content = function(file) {
			write.table(dataProcessed(), file,sep='\t',col.names=T,row.names=F)
		})
})
