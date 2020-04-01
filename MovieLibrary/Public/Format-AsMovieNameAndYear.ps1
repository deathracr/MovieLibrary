<#
 .Synopsis

 .Description

 .Parameter Root

 .Parameter OMDBAPIKey

 .Example

#>
function Format-AsMovieNameAndYear
{
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$Root,
        [Parameter(Mandatory=$true)]
        [string]$OMDBAPIKey,
        [switch]
        $Test
    )

    $Directories = Get-ChildItem -Path $Root -Directory

    foreach ($Directory in $Directories)
    {
        $i++
        Write-Progress -Activity Updating -Status 'Progress->' -PercentComplete $(($i/$Directories.Length)*100) -CurrentOperation "`n`tEvaluating $($Directory.Name)"
        # #processed => "A Private War (2018)"
        if ( -not ($Directory -match " \(\d{4}\)$") )
        {
            $Movie = ConvertTo-MovieObject -Directory $Directory.Name -Deliminator (Get-Deliminator $Directory.Name)

            # If year value extraction was successful, then use the value in the query. Else, take chances with just a title (mutiple matches possible and potentially problematic)
            $Response = Get-OMDBMovieData -MovieObject $Movie -OMDBAPIKey $OMDBAPIKey

            #region begin Execute write commands - Rename folder using new clean string with title and year values.
            if ( $Response.Response -eq "True" )
            {
                $RenameTo = Rename-SpecialCharTo -TargetString (Get-NewFolderName $Response) -Set FileSystem
                Write-Progress -Activity Updating -Status 'Progress->' -PercentComplete $(($i/$Directories.Length)*100) -CurrentOperation "`t**Determined $RenameTo**`n"
            }

            If ( $RenameTo.Length -gt 1 )
            {
                try
                {
                    if ( -not $Test ) {Rename-Item -LiteralPath $Directory.FullName $RenameTo}
                }
                catch [System.IO.IOException]
                {
                    if ( -not $Test ) {Rename-Item -LiteralPath $Directory.FullName "DUPLICATE :: $RenameTo"}
                }
            }
            Clear-Variable -Name Response
            Clear-Variable -Name Movie
            if ($RenameTo) {Clear-Variable RenameTo}
        }
    }
}
