function Get-NewFolderName
{
    Param
    (
        [object]$Movie
    )
    -join($Movie.Title, " (", $Movie.Year, ")")
}