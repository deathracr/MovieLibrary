<#
 .Synopsis
 Returns a deliminator from a string.

 .Description
 Analyzes a string a returns the probable deliminator, based on occurence and a pre-defined list of 

 .Parameter folder_name

 .Example
$Deliminator = Get-Deliminator $folder_name

#>
function Get-Deliminator {
    Param([string]$folder_name)

    $split_on_count = 0
    $split_on = 0
    $matches_count = 0

    #finds the character that is most likely to be the delimeter.  Problem with junk in front of movie title that needs to be solved.
    for ($i = 0; $i -lt $Global:Delimiters.Count; $i++)
    {
        $matches_count = ([regex]::Matches($folder_name, $Global:Delimiters.item($i))).count
        if ($split_on_count -lt $matches_count)
        {
            $split_on = $i
            $split_on_count = $matches_count
        }
    }
    $Global:Delimiters.item($split_on)
}