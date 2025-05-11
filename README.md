# NPS_broll_videos
quick &amp; dirty Powershell script to get b-roll videos for an NPS park by park code (e.g. DENA, YELL) thru public data api

## Note:
This script requires an API key before it can be used. Get yours at https://www.nps.gov/subjects/developer/get-started.htm.

## Usage:

In Windows PowerShell, invoke the script with the four letter park code you're trying to find b-roll videos for.
```
./getBRollVids.ps1 DENA
```
If DENA currently has any b-roll videos available, you'll see something like this in the console output:
```
Title: Sheep Gap (No Audio)

Description: In this short clip, a band of ewes and lambs race across the road to reach 
high ground. Sheep are particularly sensitive to traffic as they move from lambing grounds (generally north of the road) to steeper protective terrain (generally south of the road). Maintaining gaps in traffic ("sheep gaps") preserves these seasonal migration patterns, without which fewer sheep would be visible for visitor enjoyment. Sheep gaps benefit wildlife and Denali visitors alike!

Permalink: https://www.nps.gov/media/video/view.htm?id=DE34968C-57B3-4C58-B14B-A3FF00E2D7D5
```

If you need to save the results in a textfile, you can do so via the redirection operator in PowerShell.

```
./getBRollVids.ps1 YELL
```

