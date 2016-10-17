# Have to run LoadKombucha.R first

# install.packages("multcomp")
library(multcomp)
# install.packages("gplots")
require(gplots)

summary(tweets.df$MESSAGE_RETWEET_COUNT)
summary(tweets.df$USER_FRIENDS_COUNT)
summary(tweets.df$USER_FOLLOWERS_COUNT)
summary(tweets.df$USER_LISTED_COUNT)
summary(tweets.df$USER_STATUSES_COUNT)


attach(tweets.df)
plotmeans(USER_FOLLOWERS_COUNT ~ USER_GENDER)
boxplot(USER_FOLLOWERS_COUNT ~ USER_GENDER)
detach(tweets.df)

tweets.subset.df <- subset(tweets.df, 
                      (tweets.df$USER_FOLLOWERS_COUNT < 300000))
summary(tweets.subset.df$USER_FOLLOWERS_COUNT)

attach(tweets.subset.df)
plotmeans(USER_FOLLOWERS_COUNT ~ USER_GENDER)
boxplot(USER_FOLLOWERS_COUNT ~ USER_GENDER)
boxplot(USER_FOLLOWERS_COUNT ~ USER_GENDER, log = "y")

friend.fit <- aov(USER_FOLLOWERS_COUNT ~ USER_GENDER)
summary(friend.fit)
TukeyHSD(friend.fit)
par(mar=c(5,4,6,2))
tuk <- glht(friend.fit, linfct=mcp(USER_GENDER="Tukey"))
plot(cld(tuk, level=.05),col="lightgrey")
detach(tweets.subset.df)

attach(tweets.df)
plotmeans(USER_FRIENDS_COUNT ~ USER_GENDER)
boxplot(USER_FRIENDS_COUNT ~ USER_GENDER)
detach(tweets.df)

tweets.subset.df <- subset(tweets.df, 
                           (tweets.df$USER_FRIENDS_COUNT < 50000))
summary(tweets.subset.df$USER_FRIENDS_COUNT)


attach(tweets.subset.df)
plotmeans(USER_FRIENDS_COUNT ~ USER_GENDER)
boxplot(USER_FRIENDS_COUNT ~ USER_GENDER)
detach(tweets.subset.df)

friend.fit <- aov(USER_FRIENDS_COUNT ~ USER_GENDER)
summary(friend.fit)
TukeyHSD(friend.fit)
par(mar=c(5,4,6,2))
tuk <- glht(friend.fit, linfct=mcp(USER_GENDER="Tukey"))
plot(cld(tuk, level=.05),col="lightgrey")
detach(tweets.subset.df)
