<#
    Name: getBRollVids.ps1
    Purpose: Get b-roll videos for an NPS Park via public data API (using park code)
    Author: Andrew Mills/Chat GPT 4.x collaboration 
#>

param(
    [ValidatePattern('^[A-Z]{4}$')]
    [string]$parkCode
)

if (-not $parkCode) {
    Write-Error "Error: No park code provided. Please run the script with a valid 4-letter park code."
    exit 1
}

$apiKey = $env:NPS_API_KEY
if (-not $apiKey) {
    Write-Error "Error: API key not found. Set the 'NPS_API_KEY' environment variable."
    exit 1
}

$parkCode = $parkCode.ToUpper()

$url1 = "https://developer.nps.gov/api/v1/multimedia/videos?parkCode=$parkCode&limit=1&api_key=$apiKey"

try {
    $response1 = Invoke-RestMethod -Uri $url1 -Method Get
} catch {
    Write-Error "Failed to fetch data from the API. Error: $_"
    exit 2
}

if (-not $response1.total -or $response1.total -eq 0) {
    Write-Host "No videos found for park code '$parkCode'. Check that it's valid."
    exit 0
}

$url2 = "https://developer.nps.gov/api/v1/multimedia/videos?parkCode=$parkCode&limit=$($response1.total)&api_key=$apiKey"

try {
    $response2 = Invoke-RestMethod -Uri $url2 -Method Get
} catch {
    Write-Error "Failed to fetch data from the API. Error: $_"
    exit 2
}

$allVideos = $response2.data
$bRollVids = $allVideos | Where-Object { $_.isBRoll -eq $true -and $_.title -and $_.description -and $_.permalinkURL }

if (-not $bRollVids) {
    Write-Host "No b-roll videos found for park code '$parkCode'."
    exit 0
}

$bRollVids | ForEach-Object {
    "Title: $($_.title)"
    "Description: $($_.description)"
    "Permalink: $($_.permalinkURL)"
    ""
}
