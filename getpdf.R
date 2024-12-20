library(data.table)
library(pdftools)
setwd("~/GIT/mee.git/mee.git")
command<-'curl -L -H "Wiley-TDM-Client-Token: %s" -D ~/GIT/mee.git/log/%s-headers.txt https://api.wiley.com/onlinelibrary/tdm/v1/articles/%s -o ~/GIT/mee.git/PDF/%s.pdf'
token<-"token.bak"
articles<-readRDS("../Crossref/mee.rda")
articles[, c("doi0", "doi1") := tstrsplit(doi, "[/]", fixed = FALSE)]
downloaded<-list.files("../PDF", pattern="\\.pdf")
downloaded<-gsub("\\.pdf", "", downloaded)
articles$doi
articles_left<-articles[!doi1 %in% downloaded]
commands<-sprintf(command, token,
                  articles_left$doi1,
                  articles_left$doi,
                  articles_left$doi1)
i=1
for (i in c(1:nrow(articles_left))){
  print(paste(i, nrow(articles_left)))
  item<-articles_left[i]
  target<-sprintf("~/GIT/mee.git/PDF/%s.pdf", item$doi1)
  if (file.exists(target)){
    next()
  }
  cmd<-sprintf(command, token,
               item$doi1,
               item$doi,
               item$doi1)
  system(cmd)
  head<-sprintf("~/GIT/mee.git/log/%s-headers.txt", item$doi1)
  xx<-readLines(head)
  if (xx[1]!="HTTP/2 302 "){
    print(sprintf("error, remove %s", target))
    unlink(target)
  }
  n<-round(runif(1, 1, 10))
  print(sprintf("Sleep %ds", n))
  Sys.sleep(n)
}
write(paste(commands, collapse = "\n"), "../download.txt")

if (F){
  pdfs<-list.files("../PDF", pattern="\\.pdf", full.names = T)
  for (i in c(1:length(pdfs))){
    print(i)
    pdf<-pdfs[i]
    
    text<-pdf_text(pdf)
    text<-unlist(text)
    text<-paste(text, collapse = '')
    text<-gsub("\n", "", text)
    
    text<-gsub(" ", "", text)
    if (grepl("AcceptedArticle", text)){
      unlink(pdf)
    }
    if (grepl("articlehasbeenacceptedforpublication", text)){
      unlink(pdf)
    }
    
  }
  pdfs[2576]
}