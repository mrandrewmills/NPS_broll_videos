<#
    Name: getBRollVids.ps1
    Purpose: get b-roll videos for an NPS Park via public data API (using park code)
    Author: Your mom ;) kidding obviously, Happy Mother's Day btw

    Note: this script requires an API key before it can be used. Get yours at https://www.nps.gov/subjects/developer/get-started.htm
#>

param([string]$parkCode)

$parkCode = $parkCode.ToUpper()

if (-not $parkCode -or $parkCode -notmatch '^[A-Z]{4}$') {
    Write-Error "Error: Provide a valid 4-letter park code (e.g., DENA, YELL). Letters only."
    exit 1
}

$apiKey = "PLS_REGISTER_YOUR_OWN_APIKEY"
$url1 = "https://developer.nps.gov/api/v1/multimedia/videos?parkCode=$parkCode&limit=1&api_key=$apiKey"
$response1 = Invoke-RestMethod -Uri $url1 -Method Get
$total = $response1.total

if (-not $response1.total -or $response1.total -eq 0) {
    Write-Host "No videos found for park code '$parkCode'. Check that it's valid."
    exit 1
}

$url2 = "https://developer.nps.gov/api/v1/multimedia/videos?parkCode=$parkCode&limit=$total&api_key=$apiKey"
$response2 = Invoke-RestMethod -Uri $url2 -Method Get
$allVideos = $response2.data

$bRollVids = $allVideos | Where-Object { $_.isBRoll -eq $true }

$bRollVids | ForEach-Object {
    "Title: $($_.title)"
    "Description: $($_.description)"
    "Permalink: $($_.permalinkURL)"
    ""
}
