# getBRollVids.ps1

Get **b-roll video metadata** for a U.S. National Park from the [National Park Service API](https://www.nps.gov/subjects/developer/api-documentation.htm), using its official four-letter park code.

## What It Does

- Queries the NPS public API using the provided park code
- Filters the returned videos for b-roll (`isBRoll: true`)
- Outputs Title, Description, and Permalink for each match
- Displays results in a readable table format on the console
- Supports output redirection to a file via `>` (e.g., `> output.txt`)

## Requirements

- PowerShell 5.1+ (Windows) or PowerShell Core 7+ (cross-platform)
- Internet access
- A valid NPS API key

## Setup

Set your API key as an environment variable:

```powershell
$env:NPS_API_KEY = "your_actual_api_key"
```

For persistent use on Windows:

```powershell
[Environment]::SetEnvironmentVariable("NPS_API_KEY", "your_actual_api_key", "User")
```

## Usage

```powershell
.\getBRollVids.ps1 DENA
```

Or redirect output to a file:

```powershell
.\getBRollVids.ps1 DENA > dena_videos.txt
```

## Notes

- The script validates the park code to ensure it's exactly four letters (case-insensitive).
- Invalid or unknown park codes will show a helpful error and exit.
- If no b-roll videos are found, the script exits gracefully with a message.

## Author

Andrew (with an assist from ChatGPT and a side of mom jokes)
