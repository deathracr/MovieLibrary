$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
$here = "$( (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests', '')MovieLibrary\Public"
if ( -not ((Test-Path -Path "$here\$sut") -eq $true) )
{
    $here = "$((Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests', '')MovieLibrary\Private"
}
. "$here\$sut"

. "$(Split-Path -Parent $MyInvocation.MyCommand.Path)\settings.ps1"

Describe "Get-OMDBMovieData" {
    Context -Name $Global:MovieObjects.Item(0) {
        It "Tests"  {
            $Response = Get-OMDBMovieData -MovieObject $Global:MovieObjects.Item(0) -OMDBAPIKey $OMDBAPIKey
            $TestResult = "False"
            if ($Global:GoodMatch.Item(0).Title -eq $Response.Title -and $Global:GoodMatch.item(0).Year -eq $Response.Year)
            {
                $TestResult = "True"
            }
            $TestResult | Should Be "True"
        }
    }

    Context -Name $Global:MovieObjects.Item(1) {
        It "Tests"  {
            $Response = Get-OMDBMovieData -MovieObject $Global:MovieObjects.Item(1) -OMDBAPIKey $OMDBAPIKey
            $TestResult = $false
            if ($Global:GoodMatch.Item(1).Title -eq $Response.Title -and $Global:GoodMatch.Item(1).Year -eq $Response.Year)
            {
                $TestResult = $true
            }
            $TestResult | Should Be $true
        }
    }

    Context -Name $Global:MovieObjects.Item(3) {
        It "Tests"  {
            $Response = Get-OMDBMovieData -MovieObject $Global:MovieObjects.Item(3) -OMDBAPIKey $OMDBAPIKey
            $TestResult = $false
            if ($Global:GoodMatch.Item(2).Title -eq $Response.Title -and $Global:GoodMatch.Item(2).Year -eq $Response.Year)
            {
                $TestResult = $true
            }
            $TestResult | Should Be $true
        }
    }

    Context -Name $Global:MovieObjects.Item(8) {
        It "Tests"  {
            $Response = Get-OMDBMovieData -MovieObject $Global:MovieObjects.Item(8) -OMDBAPIKey $OMDBAPIKey
            $TestResult = $false
            if ($Global:GoodMatch.Item(3).Title -eq $Response.Title -and $Global:GoodMatch.Item(3).Year -eq $Response.Year)
            {
                $TestResult = $true
            }
            $TestResult | Should Be $true
        }
    }
}
