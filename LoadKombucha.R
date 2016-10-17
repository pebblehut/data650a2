library(ibmdbR)
mycon <- idaConnect("BLUDB", "", "")
idaInit(mycon)

sentiment.df <- as.data.frame(ida.data.frame('"DASH5590"."SENTIMENT"')[ ,c('MESSAGE_FAVORITES_COUNT', 'MESSAGE_ID', 'MESSAGE_RETWEET_COUNT', 'SENTIMENT_POLARITY', 'SENTIMENT_TERM', 'TYPE', 'USER_COUNTRY_U', 'USER_FOLLOWERS_COUNT', 'USER_FRIENDS_COUNT', 'USER_GENDER', 'USER_STATUSES_COUNT')])

influencers.df <- as.data.frame(ida.data.frame('"DASH5590"."INFLUENCERS"')[ ,c('DISPLAY_NAME', 'FOLLOWERS', 'MESSAGE_BODY', 'NUM_MESSAGES', 'USER_FRIENDS', 'USER_STATUSES', 'USER_SUMMARY')])

hashtags.df <- as.data.frame(ida.data.frame('"DASH5590"."KOMBUCHA_HASHTAGS"')[ ,c('HASHTAG', 'MESSAGE_ID')])

links.df <- as.data.frame(ida.data.frame('"DASH5590"."KOMBUCHA_LINKS"')[ ,c('EXPANDED_URL', 'MESSAGE_ID', 'URL')])

locations.df <- as.data.frame(ida.data.frame('"DASH5590"."KOMBUCHA_LOCATIONS"')[ ,c('MESSAGE_ID', 'MESSAGE_LOCATION', 'USER_LOCATION')])

media.df <- as.data.frame(ida.data.frame('"DASH5590"."KOMBUCHA_MEDIA"')[ ,c('IMAGE_URL', 'MEDIA_ID', 'MESSAGE_ID', 'SOURCE_MESSAGE_ID', 'TYPE', 'URL', 'VIDEO_URL')])

kombucha.sentiments.df <- as.data.frame(ida.data.frame('"DASH5590"."KOMBUCHA_SENTIMENTS"')[ ,c('MESSAGE_ID', 'SENTIMENT_POLARITY', 'SENTIMENT_TERM')])

tweets.df <- as.data.frame(ida.data.frame('"DASH5590"."KOMBUCHA_TWEETS"')[ ,c('MESSAGE_ACTION', 'MESSAGE_BODY', 'MESSAGE_COUNTRY', 'MESSAGE_COUNTRY_CODE', 'MESSAGE_FAVORITES_COUNT', 'MESSAGE_GENERATOR_DISPLAY_NAME', 'MESSAGE_ID', 'MESSAGE_INREPLYTO_URL', 'MESSAGE_LANGUAGE', 'MESSAGE_LOCATION', 'MESSAGE_LOCATION_DISPLAY_NAME', 'MESSAGE_POSTED_TIME', 'MESSAGE_RETWEET_COUNT', 'MESSAGE_URL', 'USER_CITY', 'USER_COUNTRY', 'USER_COUNTRY_CODE', 'USER_DISPLAY_NAME', 'USER_FAVORITES_COUNT', 'USER_FOLLOWERS_COUNT', 'USER_FRIENDS_COUNT', 'USER_GENDER', 'USER_ID', 'USER_IMAGE_URL', 'USER_LISTED_COUNT', 'USER_LOCATION_DISPLAY_NAME', 'USER_REGISTER_TIME', 'USER_SCREEN_NAME', 'USER_STATE', 'USER_STATUSES_COUNT', 'USER_SUB_REGION', 'USER_SUMMARY', 'USER_URL')])

users.df <- as.data.frame(ida.data.frame('"DASH5590"."KOMBUCHA_USERS"')[ ,c('MESSAGE_ID', 'USER_ID', 'USER_NAME', 'USER_SCREEN_NAME')])

# Validate the data for a couple of the tables 
# These should match what is seen from the summary graphs when 
# data was loaded into dashDB
tweets.df$USER_COUNTRY <- as.factor(tweets.df$USER_COUNTRY)
summary(tweets.df$USER_COUNTRY)
tweets.df$MESSAGE_COUNTRY <- as.factor(tweets.df$MESSAGE_COUNTRY)
summary(tweets.df$USER_COUNTRY)
tweets.df$USER_GENDER <- as.factor(tweets.df$USER_GENDER)
summary(tweets.df$USER_GENDER)
summary(tweets.df)
str(tweets.df)
kombucha.sentiments.df$SENTIMENT_POLARITY <- as.factor(kombucha.sentiments.df$SENTIMENT_POLARITY)
kombucha.sentiments.df$SENTIMENT_TERM <- as.factor(kombucha.sentiments.df$SENTIMENT_TERM)
summary(kombucha.sentiments.df)
str(kombucha.sentiments.df)


