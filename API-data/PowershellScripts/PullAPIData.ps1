$limit=25
$offset=50
$key="b1ec95c5594c7d0ac4dc871755150a46e6bc54b4"

##Checks Offset
if ($offset -eq 0){
$response_shows = curl http://api-public.guidebox.com/v2/shows?api_key=$key"&"limit=$limit -UseBasicParsing
}

if ($offset -ne 0){
$response_shows = curl http://api-public.guidebox.com/v2/shows?api_key=$key"&"limit=$limit"&"offset=$offset -UseBasicParsing
}

$response_shows.Content | ConvertFrom-Json | ConvertTo-Json | out-file C:\JamesGrover\GuideUnified\API-data\Shows-limit-$limit-offset-$offset.json

$shows = $response_shows |ConvertFrom-Json


for ($i=0;$i -lt $limit; $i++) {
    write-host "ID: "$shows.results.id[$i]
    $show_id=$shows.results.id[$i] #had to convert to variable.  URL didn't like array notation
    $response_episode = curl http://api-public.guidebox.com/v2/shows/$show_id/episodes?api_key=$key
    $response_episode.Content | ConvertFrom-Json | ConvertTo-Json | out-file C:\JamesGrover\GuideUnified\API-data\Episodes-Show-$show_id.json

}


