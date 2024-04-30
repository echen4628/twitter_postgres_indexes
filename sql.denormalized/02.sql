select
tag,
count(*) as count
from
(
select distinct
data ->> 'id',
'#' || (jsonb_array_elements(
                COALESCE(data->'entities'->'hashtags','[]') ||
                COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]')
            ) ->> 'text') AS tag
from tweets_jsonb
where (data->'entities'->'hashtags' @> '[{"text":"coronavirus"}]'::jsonb
    or
    data->'extended_tweet'->'entities'->'hashtags' @> '[{"text":"coronavirus"}]'::jsonb)
) t
group by tag
order by count DESC, tag
LIMIT 1000;
