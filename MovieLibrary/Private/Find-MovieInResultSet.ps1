function Find-MovieInResultSet {
    [CmdletBinding()]
    param (
        [Parameter()]
        [PSObject]
        $ResultSet,
        [Parameter()]
        [PSObject]
        $MatchAgainst,
        [string[]]
        $DisAllowedChars = @("(",")","[","]","-","#")
    )
    $Response = $null
    if ($local:ResultSet.totalResults -gt 1 -and  [bool]($MatchAgainst.PSobject.Properties.name -match "Series") ) 
    {
        $SearchForMe = "$($local:MatchAgainst.Title) $($local:MatchAgainst.Series)"
        foreach ($Result in $local:ResultSet.Search)
        {
            if ($Result.Title -match [regex]::Escape($SearchForMe) )
            {
                return $Result
            }
        }
    }
    elseif ($local:ResultSet.Response -eq $true)
    {
        if ($local:ResultSet.Search) {$local:SearchObject = $local:ResultSet.Search }
        else {$local:SearchObject = $local:ResultSet}
        foreach ($local:Result in $local:SearchObject)
        {
            $local:Result.Title = Rename-SpecialCharTo -TargetString $local:Result.Title -Set Custom -Custom  $DisAllowedChars
            $local:Result.Title = $local:Result.Title -replace  '\s+', ' '
            $local:MATokens = $local:MatchAgainst.Title.Split(" ") | ForEach-Object {[regex]::Escape($_)}
            $local:RSTokens = $local:Result.Title.Split(" ")

            while ($local:MATokens)
            {
                $local:MAFirst, $local:MATokens = $local:MATokens
                $local:RSFirst, $local:RSTokens = $local:RSTokens
                if ( $local:RSFirst -match $local:MAFirst )
                {
                    $TokenMatches++
                }
                else
                {
                    #  -and ($local:Result.Year -eq $local:MatchAgainst.Year)
                    # Test-Path variable:RSTokens -and
                    if (($local:TokenMatches -eq $local:Result.Title.Split(" ").Count) )
                    {
                        $local:Result | Add-Member NoteProperty -Name Response -Value "True"
                        return $local:Result
                        break
                    }
                }
            }

            if ($TokenMatches -eq $local:MatchAgainst.Title.Split(" ").Count -eq $local:MatchAgainst.Title.Split(" ").Count )
            {
                $Response =  [PSCustomObject]@{
                    Title = $local:Result.Title
                    Year = $local:Result.Year
                    Response = "True"
                }
                break
            }
            if ($TokenMatches) {Clear-Variable TokenMatches}
        }
    }
    else
    {
        $Response = $local:ResultSet
    }
    $Response
}
