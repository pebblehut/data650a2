# Have to run LoadKombucha.R first

library(ibmdbR)

con <- idaConnect('BLUDB','','')
idaInit(con)

# Analyze country vs. gender ----------------------------------------------

table(tweets.df$USER_GENDER)
summary(tweets.df$MESSAGE_COUNTRY)
table(tweets.df$USER_GENDER, tweets.df$MESSAGE_COUNTRY)
table(sentiment.df$USER_GENDER, sentiment.df$USER_COUNTRY_U)
table(sentiment.df$USER_COUNTRY_U)
# Filter down to countries that had more than 10 tweets
x <- table(sentiment.df$USER_COUNTRY_U)
x[x>10]
x2 <- table(sentiment.df$USER_GENDER, sentiment.df$USER_COUNTRY_U)


# Time analysis of Tweets -------------------------------------------------

posts <-strftime(tweets.df$MESSAGE_POSTED_TIME, '%Y-%m-%d')
posts <-as.Date(posts)
table(format(posts, "%Y-%m"))
table(format(posts, "%w"))

pie(table(kombucha.sentiments.df$SENTIMENT_POLARITY))

table(format(posts))
which.max(table(posts))

plot(table(posts), xlab="Date", ylab="Posts per Day")
#plot(table(format(posts, "%Y-%m")), xlab="Date", ylab="Posts per Month")
