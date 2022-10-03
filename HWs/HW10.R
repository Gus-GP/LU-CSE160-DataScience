# CSE160 - Intro to Data Science
# Lehigh University
# 
# Code to create wordclouds from Twitter search results or URLs

# which for me does the following to establish a session with Twitter:
library(twitteR)
library(ROAuth)
library(base64enc)

# Download "cacert.pem" file
download.file(url="http://curl.haxx.se/ca/cacert.pem",destfile="cacert.pem")

#create an object "cred" that will save the authenticated object that we can use for later sessions
cred <- OAuthFactory$new(consumerKey='Q8JLJWOhmHA8u6rjnYetYKkQe',
                         consumerSecret='oCUOLAtQuIpekn8XPcI6gCBuuk293mB12RYeogQ8HL6ptCzji5',
                         requestURL='https://api.twitter.com/oauth/request_token',
                         accessURL='https://api.twitter.com/oauth/access_token',
                         authURL='https://api.twitter.com/oauth/authorize')

# Executing the next step generates an output --> To enable the connection, please direct your web browser to: <hyperlink> . Note:  You only need to do this part once
cred$handshake(cainfo="cacert.pem")
# and also defines TweetFrame() and CleanTweets() functions


library(tm)
library(wordcloud)

library(RCurl)
library(XML)


mytweetwordcloud <- function(tag,count) {
  tweetDF <- TweetFrame(tag,count)
  cat("Retrieved", length(tweetDF$text), "tweets.\n")
  
  # clean the text
  cleanText<-CleanTweets(tweetDF$text)
  
  # build the corpus
  tweetCorpus<-Corpus(VectorSource(cleanText))
  tweetCorpus <- tm_map(tweetCorpus, content_transformer(tolower))
  
  # normalize and clean further
  tweetCorpus<-tm_map(tweetCorpus, removePunctuation)
  tweetCorpus<-tm_map(tweetCorpus,removeWords, stopwords('english'))
  tweetCorpus<-tm_map(tweetCorpus,removeWords, c("http", "https"))
  
  # build the term-document matrix
  tweetTDM<-TermDocumentMatrix(tweetCorpus)
  #inspect(tweetDM)
  tdMatrix <- as.matrix(tweetTDM)
  
  # determine most frequent words
  sortedMatrix<-sort(rowSums(tdMatrix), decreasing=TRUE)
  
  # create frame of words and frequencies and plot it
  cloudFrame<-data.frame(word=names(sortedMatrix),freq=sortedMatrix)
  wordcloud(cloudFrame$word,cloudFrame$freq,scale=c(3,.5),colors=c("gray","black","blue","green"),rot.per=.2,min.freq=4)
}


# from http://www.r-bloggers.com/htmltotext-extracting-text-from-html-via-xpath/
# Tony Breyal

# convert HTML to plain text
convert_html_to_text <- function(html) {
  doc <- htmlParse(html, asText = TRUE)
  text <- xpathSApply(doc, "//text()[not(ancestor::script)][not(ancestor::style)][not(ancestor::noscript)][not(ancestor::form)]", xmlValue)
  return(text)
}

# format text vector into one character string
collapse_text <- function(txt) {
  return(paste(txt, collapse = " "))
}

wordcloudfromurl <- function(URL) {
  webpage <- getURL(URL,maxredirs = as.integer(20), followlocation = TRUE)
  
  d <- str_replace_all(convert_html_to_text(webpage),"[\n\r\t]","")
  d2 <- str_replace_all(collapse_text(d), "[:space:]+", " ")
  
  docCorpus<-Corpus(VectorSource(d2))
  docCorpus <- tm_map(docCorpus, content_transformer(tolower))
  docCorpus<-tm_map(docCorpus, removePunctuation)
  docCorpus<-tm_map(docCorpus,removeWords, stopwords('english'))
  
  TDM<-TermDocumentMatrix(docCorpus)
  tdMatrix <- as.matrix(TDM)
  sortedMatrix<-sort(rowSums(tdMatrix), decreasing=TRUE)
  cloudFrame<-data.frame(word=names(sortedMatrix),freq=sortedMatrix)
  wordcloud(cloudFrame$word,cloudFrame$freq,scale=c(4,.5),colors=c("grey","black","blue","turquoise","green","red"),rot.per=.2)
}

