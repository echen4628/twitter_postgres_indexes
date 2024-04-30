select
tag,
count(*) as count
from (
SELECT DISTINCT
		data->>'id',
		'#' || (jsonb_array_elements(
                COALESCE(data->'entities'->'hashtags','[]') ||
                COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]')
            ) ->> 'text') AS tag
from tweets_jsonb
where (to_tsvector('english',data->'extended_tweet'->>'full_text') @@ to_tsquery('english', 'coronavirus')
OR to_tsvector('english', data->>'text') @@ to_tsquery('english', 'coronavirus'))
AND data->>'lang'='en'
) t
group by tag
order by count desc, tag
limit 1000;
		
