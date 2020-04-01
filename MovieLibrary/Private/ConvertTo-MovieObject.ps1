<#
 .Synopsis
    Convert a string to a custom 'Movie' object.

 .Description
 The function accepts a string which includes token which represent a movie release.
 The function returns an object with a Title and Year member.

 .Parameter Directory
A string that represents a movie release, it may include the release year.  It must include the movie title.

 .Parameter Deliminator
A character in type string.  Used to split the Directory parameter into tokens.

 .Example
 $Response = ConvertTo-MovieObject -Directory $folder_name -Deliminator (Get-Deliminator $folder_name)

#>
function ConvertTo-MovieObject {
    Param
    (
        [string]$Directory,
        [ValidateSet("\.","-","_"," ")]
        [string]$Deliminator
    )
    #used to get the date out of the path name sting
    $date_expr =  @("\b\d{4}\b")
    $tokens = $Directory.Split($Deliminator)

    for ($i = 0; $i -lt $tokens.Count; $i++)
    {
        if ( $tokens[$i] -match $date_expr)
        {   <#
            If a date pattern is found test to see if it is first token.
            If not, assuming it is release date and end processing string
            #>
            if ($i -eq 0 -and $tokens[$i])
            {
                $movie = -join ($movie, " ", $tokens[$i])
            }
            else
            {   <#
                not first token and so if pattern 4 digits, then likely date, clean out unwanted chars
                break from loop
                #>
                $year = Set-SpecialCharTo -TargetString $tokens[$i] -Set Custom $Global:DisAllowedChars
                $i = $tokens.Count
            }
        }
        else
        {
            $movie = -join ($movie, " ", $tokens[$i])
        }
    }
    if (-not $year -match $date_expr) { $year = $year.Substring(1,4) }

    $Results = [PSCustomObject]@{
        Title = $movie.Trim()
        Year = $year
    }
    $Results
}