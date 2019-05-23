$limit=25
$offset=0
$key="b1ec95c5594c7d0ac4dc871755150a46e6bc54b4"

##Checks Offset
if ($offset -eq 0){
$response = curl http://api-public.guidebox.com/v2/movies?api_key=$key"&"limit=$limit"&"sources=amazon_prime","hbo","netflix","hulu"&"include_links=true -UseBasicParsing
}

if ($offset -ne 0){
$response = curl http://api-public.guidebox.com/v2/movies?api_key=$key"&"limit=$limit"&"offset=$offset"&"sources=amazon_prime","hbo","netflix","hulu"&"include_links=true -UseBasicParsing
}

$response.Content | ConvertFrom-Json | ConvertTo-Json | out-file C:\JamesGrover\GuideUnified\API-data\movies2\Movies-limit-$limit-offset-$offset.json

$media = $response |ConvertFrom-Json


for ($i=0;$i -lt $limit; $i++) {
    write-host "ID: "$media.results.id[$i]
    $id=$media.results.id[$i] #had to convert to variable.  URL didn't like array notation
    $response_episode = curl http://api-public.guidebox.com/v2/movies/$id/?api_key=$key
    $response_episode.Content | ConvertFrom-Json | ConvertTo-Json -Depth 10| out-file C:\JamesGrover\GuideUnified\API-data\Movies2\Movie-data-ID-$id.json

}


