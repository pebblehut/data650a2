# Have to run LoadKombucha.R first

# install.packages("wordcloud")
# install.packages("tm")
library(wordcloud)
library(tm)

tweetCorpus <- Corpus(VectorSource(influencers.df$USER_SUMMARY))

tweet_tdm <- TermDocumentMatrix(tweetCorpus)
tweet_m <- as.matrix(tweet_tdm)
tweet_tf <- rowSums(tweet_m)
tweet_tf <- sort(tweet_tf, decreasing=TRUE)


# View the top 20  words
# Example code from Data Camp: print(term_frequency[1:10])
print(tweet_tf[1:20])

plot.new()
wordcloud(names(tweet_tf), tweet_tf, max.words=100, rot.per=0.5, random.order = FALSE)
text(x=0.5, y=0.2, "Sentiment Terms Word Cloud")
