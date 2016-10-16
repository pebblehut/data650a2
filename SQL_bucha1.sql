
select message_id, message_posted_time, message_retweet_count,
 message_country
from DASH5590.Kombucha_tweets
where message_action = 'post';

-- Maybe add reteweet?
select message_action,
count(message_id) as num_messages,
from kombucha_tweets
group by message_action
;

-- select *  into kombucha2_tweets from kombucha_tweets;
-- select * into kombucha2_users from kombucha_users;
-- select * into  kombucha2_hashtags from kombucha_hashtags ;
-- select * into kombucha2_sentiment from kombucha_sentiment;
-- select * into kombucha2_media from kombucha_media;
-- select * into kombucha2_links from kombucha_links;
-- select * into kombucha2_locations from kombucha_locations;

-- drop table kombucha_tweets;
-- drop table kombucha_users;
-- drop table kombucha_hashtags;
-- drop table kombucha_sentiment;
-- drop table kombucha_media;
-- drop table kombucha_locations;
-- drop table kombucha_links;


create or replace view sentiment 
as (
select s.message_ID, s.sentiment_polarity,
m.type,
s.sentiment_term,
t.user_gender,
upper(t.user_country) as user_country_u,
t.user_friends_count,
t.user_followers_count,
t.user_statuses_count, 
t.message_retweet_count,
t.message_favorites_count
from Kombucha_tweets t
join Kombucha_sentiments s on t.message_id = s.message_id
left join Kombucha_media m on t.message_id= m.message_id
);

SELECT sentiment_polarity, sentiment_term FROM DASH5590.KOMBUCHA_SENTIMENTS where sentiment_polarity = 'NEGATIVE';

SELECT sentiment_polarity, 
count(message_id) as num_messages,
count(distinct sentiment_term) as Distinct_Term_Count,
count(sentiment_term) as Term_Count
FROM KOMBUCHA_SENTIMENTS GROUP BY sentiment_polarity;

-- Good
SELECT min(sentiment_polarity) as sentiment_polarity_min, 
sentiment_term,
count(message_id) as num_messages
FROM KOMBUCHA_SENTIMENTS 
where sentiment_polarity = 'NEGATIVE'
GROUP BY sentiment_term
order by num_messages desc
;

-- Great
select message_body 
from kombucha_tweets
where message_body like '%addiction%' or 
      message_body like '%stop%' or
      message_body like '%bad%' or
      message_body like '%obsessed%'
;

select user_country_u,
integer(avg(s.user_followers_count)) as avg_follower_cnt, 
integer(avg(s.user_statuses_count)) as avg_statuses_cnt, 
integer(avg(s.message_retweet_count)) as avg_retweet_cnt, 
integer(avg(s.message_favorites_count)) as avg_favorite_cnt, 
integer(avg(s.user_friends_count)) as avg_friend_cnt
from sentiment s
group by user_country_u
order by avg_retweet_cnt desc
;

select 
min(message_body) as message_body,
user_summary,
min(user_followers_count) as followers_count,
min(user_statuses_count) as user_statuses_count,
min(user_friends_count)  as user_friends_count
from kombucha_tweets

where 
(user_followers_count > 3800 or
user_statuses_count  > 13000 or
user_friends_count   > 1400)
group by user_summary;


-- View for influencers
create or replace view influencers
as (
select 
max(message_body) as message_body,
user_summary,
count(message_id) as num_messages,
min(user_display_name) as display_name,
min(user_followers_count) as followers,
min(user_statuses_count) as user_statuses,
min(user_friends_count)  as user_friends
from kombucha_tweets

where 
(
message_language = 'en' and
(user_followers_count > 3800 or
user_statuses_count  > 13000 or
user_friends_count   > 1400)
)
group by user_summary
order by followers desc
);

-- Just the query for influencers
select 
max(message_body) as message_body,
user_summary,
count(message_id) as num_messages,
min(user_display_name) as display_name,
min(user_followers_count) as followers,
min(user_statuses_count) as user_statuses,
min(user_friends_count)  as user_friends
from kombucha_tweets

where 
(
message_language = 'en' and
(user_followers_count > 3800 or
user_statuses_count  > 13000 or
user_friends_count   > 1400)
)
group by user_summary
order by followers desc
;

select distinct 


-- This query has a problem - kombucha_users has duplicate message_id values
select user_country_u,
count (s.message_id) as num_tweets,
count (distinct(u.user_screen_name)) as num_distinct_users,
integer(avg(s.user_followers_count)) as avg_follower_cnt, 
integer(max(s.user_followers_count)) as max_follower_cnt, 
integer(avg(s.user_statuses_count)) as avg_statuses_cnt, 
integer(max(s.user_statuses_count)) as max_statuses_cnt, 
integer(avg(s.message_retweet_count)) as avg_retweet_cnt, 
integer(max(s.message_retweet_count)) as max_retweet_cnt, 
integer(avg(s.message_favorites_count)) as avg_favorite_cnt, 
integer(max(s.message_favorites_count)) as max_favorite_cnt, 
integer(avg(s.user_friends_count)) as avg_friend_cnt,
integer(max(s.user_friends_count)) as max_friend_cnt
from sentiment s
inner join Kombucha_users u on u.message_id = s.message_id
group by user_country_u
order by max_follower_cnt desc
;


-- GOOD ONE!
select s.user_country_u,
sum(s.message_retweet_count) as total_retweet_cnt, 
integer(avg(s.message_retweet_count)) as avg_retweet_cnt, 
integer(avg(s.user_friends_count)) as avg_friend_cnt, 
count(message_id) as num_messages
from sentiment s
group by s.user_country_u
order by total_retweet_cnt desc
;


-- Hunt down duplicates - start with the new sentiment table:
select min(s.user_country_u) as country, count(*) as num_messages
  from   sentiment s
  group  by s.message_id
  having count(*) > 1; 

select min(user_country) as country, 
       count(*) as num_messages
  from   kombucha_tweets
  group  by message_id
  having count(*) > 1; 

-- Run this query to find kombucha_tweets dups:
select *
  from   kombucha_tweets
   where message_id in (
    select message_id
      from   kombucha_tweets
      group  by message_id
      having count(*) > 1
   )
   order by message_id
; 



select s.message_id, s.user_country
  from   sentiment s
  where s.user_country like 'Burkina%'
  ; 
	 - group  by s.message_id, s.user_country
 -- having count(*) > 1


select s.*, u.user_screen_name
from sentiment s
right join Kombucha_users u on u.message_id = s.message_id
where s.user_country like 'Burkina%'
;

select *
from Kombucha_users
where s.message_id = 'tag:search.twitter.com,2005:522831585612025858'
;

select s.message_id, s.user_country, u.user_screen_name
from sentiment s
inner join Kombucha_users u on u.message_id = s.message_id
where s.message_id = 'tag:search.twitter.com,2005:522831585612025858'
;


select message_id
from Kombucha_users
group  by message_id
  having count(*) > 1; 

select * 
from sentiment
where message_id in (
select message_id
from Kombucha_users
group  by message_id
  having count(*) > 1 
);


select
t.table_schema as Library
,t.table_name
,t.table_type
,c.column_name
,c.ordinal_position
,c.data_type
,c.character_maximum_length as Length
,c.numeric_precision as Precision
,c.numeric_scale as Scale
,c.column_default
,t.is_insertable_into
from sysibm.tables t
join sysibm.columns c
on t.table_schema = c.table_schema
and t.table_name = c.table_name
where t.table_schema = 'DASH5590'
and t.table_name = 'KOMBUCHA_SENTIMENTS'
order by t.table_name, c.ordinal_position



select s.sentiment_polarity, avg(s.message_retweet_count) as avg_retweet_count
from sentiment s
group by s.sentiment_polarity
;


select s.sentiment_polarity, s.type, avg(s.message_retweet_count) as avg_retweet_count
from sentiment s
group by s.sentiment_polarity, s.type
;


select s.user_gender, s.sentiment_polarity, avg(s.user_followers_count) as avg_follower_cnt
from sentiment s
group by s.user_gender, s.sentiment_polarity
order by s.sentiment_polarity, s.user_gender
; 

where retweet_count > 2;
