library(data.table)
library(pdftools)
library(stringr)
setwd("~/GIT/mee.git/mee.git")
rm(list=ls())

if (F){
  text <- "Here are some links: https://github.com/user/repo, https://www.github.com/user/repo, and http://github.io/user/repo?query=1"
  matches <- regmatches(text, gregexpr("https?://(?:[a-zA-Z0-9-]+\\.)*github\\.[a-z]{2,}(/[\\w/?.&=]*)?", text))
  print(matches)
  
  text <- "Visit https://github.com/user/repo or https://www.github.com/user/repo or http://github.io/user/repo?query=1."
  matches <- regmatches(text, gregexpr("https?://(?:www\\.)?github\\.[a-z]+(?:/[\\w\\-./?%&=]*)?", text))
  print(matches)
  
  
  
  url_pattern <- "https?://(?:www\\.)?github\\.[a-z]+(?:/[\\w./?%&=-]*)?"
  
  #urls <- regmatches(text, gregexpr(url_pattern, text))
  matches <- str_extract_all(text, url_pattern)

}
articles<-readRDS("../Crossref/mee.rda")
articles[, c("doi0", "doi1") := tstrsplit(doi, "[/]", fixed = FALSE)]
articles$github<-""
for (i in c(1:nrow(articles))){
  print(paste(i, nrow(articles)))
  item<-articles[i]
  target<-sprintf("~/GIT/mee.git/PDF/%s.pdf", item$doi1)
  if (target=="~/GIT/mee.git/PDF/2041-210x.13062.pdf"){
    articles[i]$github<-"https://github.com/jknape/nmixgof"
    next()
  }
  if (target=="~/GIT/mee.git/PDF/2041-210x.13006.pdf"){
    articles[i]$github<-"https://github.com/mwpennell/geiger-v2/blob/master/R/disparity.R"
    next()
  }
  if (target=="~/GIT/mee.git/PDF/2041-210x.12822.pdf"){
    articles[i]$github<-"https://github.com/charlottesirot/elementR"
    next()
  }
  if (target=="~/GIT/mee.git/PDF/2041-210x.12562.pdf"){
    articles[i]$github<-"https://github.com/avoid3d/morphs"
    next()
  }
  if (target=="~/GIT/mee.git/PDF/2041-210x.12285.pdf"){
    articles[i]$github<-"https://github.com/lamho86/Intrinsic-inference-difficulties-for-trait-evolution-with-Ornstein-Uhlenbeck-models"
    next()
  }
  if (target=="~/GIT/mee.git/PDF/2041-210x.14219.pdf"){
    articles[i]$github<-"https://github.com/MarineOmics/marineomics.github.io"
    next()
  }
  if (target=="~/GIT/mee.git/PDF/2041-210x.12126.pdf"){
    articles[i]$github<-"XXXX"
    next()
  }
  if (target=="~/GIT/mee.git/PDF/2041-210x.13771.pdf"){
    articles[i]$github<-"XXXX"
    next()
  }
  if (target=="~/GIT/mee.git/PDF/2041-210x.14195.pdf"){
    articles[i]$github<-"https://github.com/hmorlon/PANDA/tree/clade.shift.model"
    next()
  }
  if (target=="~/GIT/mee.git/PDF/2041-210x.14006.pdf"){
    articles[i]$github<-"https://github.com/miwipe/ngsLCA"
    next()
  }
  if (target=="~/GIT/mee.git/PDF/2041-210x.13980.pdf"){
    articles[i]$github<-"https://github.com/revbayes/revbayes"
    next()
  }
  if (target=="~/GIT/mee.git/PDF/2041-210x.13761.pdf"){
    articles[i]$github<-"https://github.com/hshimadzu/GrowthModelling"
    next()
  }
  if (target=="~/GIT/mee.git/PDF/2041-210x.13738.pdf"){
    articles[i]$github<-"https://github.com/ChrisBotella/TrophicNetEncoder"
    next()
  }
  if (target=="~/GIT/mee.git/PDF/2041-210x.13745.pdf"){
    articles[i]$github<-"https://github.com/joshcullen/bayesmove"
    next()
  }
  if (target=="~/GIT/mee.git/PDF/2041-210x.13679.pdf"){
    articles[i]$github<-"https://github.com/jayverhoef/POP"
    next()
  }
  if (target=="~/GIT/mee.git/PDF/2041-210x.13663.pdf"){
    articles[i]$github<-"https://github.com/HumBug-Mosquito/HumBugDB"
    next()
  }
  if (target=="~/GIT/mee.git/PDF/2041-210x.13628.pdf"){
    articles[i]$github<-"https://jamie mkass.github.io/ENMeval/"
    next()
  }
  if (target=="~/GIT/mee.git/PDF/2041-210x.13563.pdf"){
    articles[i]$github<-"xxx"
    next()
  }
  if (target=="~/GIT/mee.git/PDF/2041-210x.13529.pdf"){
    articles[i]$github<-"https://github.com/kelseyefisher/locating-large-insects-using-automated-vhf-radio-telemetry-with-multi-antennae-array;"
    next()
  }
  if (target=="~/GIT/mee.git/PDF/2041-210x.13457.pdf"){
    articles[i]$github<-"xxx"
    next()
  }
  
  if (target=="~/GIT/mee.git/PDF/2041-210x.13384.pdf"){
    articles[i]$github<-"https://github.com/TiagoOlivoto/metan"
    next()
  }
  if (target=="~/GIT/mee.git/PDF/2041-210x.13372.pdf"){
    articles[i]$github<-"https://github.com/mbmorrissey/count_data_analysis "
    next()
  }
  
  if (articles[i]$github!=""){
    next()
  }
  
  if (file.exists(target)){
    text<-pdf_text(target)
    text<-unlist(text)
    #write(text, "~/Downloads/asdf.txt")
    text<-paste(text, collapse = '')
    
    
    
    #text<-gsub(" ", "", text)
    text<-gsub("\n", "", text)
    
    articles[i]$with_github<-grepl("github", text)
    url_pattern <- "https?://(?:www\\.)?github\\.[a-z]+(?:/[\\w./?%&=-]*)?"
    github_links <-  str_extract_all(text, url_pattern)[[1]]
    
    if (length(github_links)>0){
      
      github_links<-github_links[github_links!="https://github.com/"]
      github_links<-unique(github_links)
      
      if (length(github_links)>1){
        articles[i]$github<-github_links[1]
        articles[i]$double_check<-T
        
      }else{
        articles[i]$github<-github_links
      }
      
    }
  }
}
