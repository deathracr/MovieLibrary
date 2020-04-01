function Get-OMDBMovieData {
    param (
        [Parameter(Mandatory=$true)]
        [System.Object]
        $MovieObject,
        [Parameter(Mandatory=$true)]
        [System.Object]
        $OMDBAPIKey
    )

    <#
        If Year is found, hoping the dates and title string line up.
    #>
    if ( $MovieObject.Year )
    {
        $APIResponse = Invoke-APISearch -OMDBAPIKey $OMDBAPIKey -QueryObject $MovieObject
        try
        {
            $local:Response = Find-MovieInResultSet -ResultSet $APIResponse -MatchAgainst $MovieObject
        }
        Catch
        {
            $local:Response = [PSCustomObject]@{
                Response = "False"
            }
        }
    }

    <#
        If no year, let's take our chances finding a title that lines up
    #>
    if ( $local:Response.Response -eq "False" -or $null -eq $local:Response)
    {
        $APIResponse = Invoke-APISearch -OMDBAPIKey $OMDBAPIKey -QueryObject $MovieObject -Type t
        try
        {
            $local:Response = Find-MovieInResultSet -ResultSet $APIResponse -MatchAgainst $MovieObject
        }
        Catch
        {
            $local:Response = [PSCustomObject]@{
                Response = "False"
            }
        }
    }

    <#
        Still nothing so let's find another way to do this.  Maybe this is a series?
    #>
    if ( $local:Response.Response -eq "False" -or $null -eq $local:Response)
    {
        if ($MovieObject.Title -match "\d")
        {
            $MovieTitleTokens = $MovieObject.Title.Split($Matches.Values)
            $MovieObject.Title = "$($MovieTitleTokens.Item(0).Trim())"
            $MovieObject | Add-Member -MemberType NoteProperty -Name Series -Value $Matches.Values
            $APIResponse = Invoke-APISearch -OMDBAPIKey $OMDBAPIKey -QueryObject $MovieObject
        }

        try
        {
            $local:Response = Find-MovieInResultSet -ResultSet $APIResponse -MatchAgainst $MovieObject
        }
        Catch
        {
            $local:Response = [PSCustomObject]@{
                Response = "False"
            }
        }
    }

    if ($local:Response.Response -eq "False")
    {
        if ($MovieObject.Year)
        {
            $MovieTitleTokens = $MovieObject.Title.Split(" ")
            While ($MovieTitleTokens)
            {
                $first, $MovieTitleTokens = $MovieTitleTokens
                $local:QueryTitle += " $first"
                $local:QueryObject = [PSCustomObject]@{
                    Title = $local:QueryTitle.Trim()
                }
                $APIResponse = Invoke-APISearch -OMDBAPIKey $OMDBAPIKey -QueryObject $local:QueryObject
                try
                {
                    $local:Response = Find-MovieInResultSet -ResultSet $APIResponse -MatchAgainst $MovieObject
                    if ($local:Response.Response -eq "True" -and $MovieObject.Year -eq $local:Response.Year ) {break}
                }
                Catch
                {
                    $local:Response = [PSCustomObject]@{
                        Response = "False"
                    }
                }
            }
        }
    }
    $local:Response
}