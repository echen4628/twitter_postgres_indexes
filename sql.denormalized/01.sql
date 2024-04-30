SELECT count(distinct data->>'id')
from tweets_jsonb
where (data->'entities'->'hashtags' @> '[{"text":"coronavirus"}]'::jsonb
    or
    data->'extended_tweet'->'entities'->'hashtags' @> '[{"text":"coronavirus"}]'::jsonb);
