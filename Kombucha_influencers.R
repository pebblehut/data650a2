# Have to run LoadKombucha.R first

# install.packages("wordcloud")
# install.packages("tm")
library(wordcloud)
library(tm)

#docs <- Corpus(VectorSource(influencers.df$USER_SUMMARY))
docs <- Corpus(VectorSource(influencers.df$MESSAGE_BODY))


# Remove Punctuation and Special Characters -------------------------------
docs <- tm_map(docs, removePunctuation)
# data.frame(text=unlist(sapply(docs, '[', "content")), stringsAsFactors = F)
docs <- tm_map(docs, content_transformer(tolower))

# Remove numeric characters -----------------------------------------------
docs<-tm_map(docs, removeNumbers)

# Remove Stopwords --------------------------------------------------------
docs<-tm_map(docs, removeWords, c(stopwords("english"), "kombucha", "amp"))
inspect(docs)

# Strip WhiteSpace --------------------------------------------------------
docs<-tm_map(docs, stripWhitespace)
inspect(docs)

# Stemming ----------------------------------------------------------------
#install.packages("SnowballC")
library(SnowballC)
docs <- tm_map(docs, stemDocument)

docs.tdm <- TermDocumentMatrix(docs)
docs.tdm.m <- as.matrix(docs.tdm)
docs.tf <- rowSums(docs.tdm.m)
docs.tf <- sort(docs.tf, decreasing=TRUE)


# View the top 20  words
# Example code from Data Camp: print(term_frequency[1:10])
print(docs.tf[1:40])

plot.new()
library(wordcloud)

wordcloud(names(docs.tf), docs.tf, max.words=100, rot.per=0.5, random.order = FALSE)
text(x=0.5, y=0.2, "Sentiment Terms Word Cloud")

pal <- brewer.pal(8, "Dark2")
# pal <- brewer.pal(9, "BuGn")
pal <- pal[-(1:2)]
wordcloud(names(docs.tf), docs.tf, 
          # scale=c(8,.3),
          min.freq=2,max.words=50, 
          random.order=T, rot.per=.15, colors=pal, 
          vfont=c("sans serif","plain"))


