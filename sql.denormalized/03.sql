select 
data ->> 'lang' as lang,
count(distinct data->> 'id') as count
from tweets_jsonb
where (data->'entities'->'hashtags' @> '[{"text":"coronavirus"}]'::jsonb
    or
    data->'extended_tweet'->'entities'->'hashtags' @> '[{"text":"coronavirus"}]'::jsonb)
group by lang
order by count desc, lang;

