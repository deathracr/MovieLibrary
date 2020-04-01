$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
$here = "$( (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests', '')MovieLibrary\Public"
if ( -not ((Test-Path -Path "$here\$sut") -eq $true) )
{
    $here = "$((Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests', '')MovieLibrary\Private"
}
. "$here\$sut"

. "$(Split-Path -Parent $MyInvocation.MyCommand.Path)\settings.ps1"

Describe "Find-MovieInResultSet" {
    Context -Name "Once upon a time" {
        It "Returns a hash if there are $($Global:ResultSet1.totalResults) or more results" {
        $Response = Find-MovieInResultSet  -ResultSet $Global:ResultSet1 -MatchAgainst $Global:MovieObjects.Item(6)
        Compare-Object -ReferenceObject $Global:ResultSet1.Search.Item(0) `
                        -DifferenceObject $Response `
                        -OutVariable Test | Should Be $null
        Clear-Variable Response
        }
        It "Returns a custom object with Response set to True with 1 result" {
            Find-MovieInResultSet  -ResultSet $Global:ResultSet0 -MatchAgainst $Global:MovieObjects.Item(6) | Should Be $null
        }
        It "Returns a custom object with Response set to False with 0 results" {
            (Find-MovieInResultSet -ResultSet $Global:ResultSet -MatchAgainst $Global:MovieObjects.Item(6)).Response | Should Be "False"
        }
        It "Returns a custom object with Response set to False with 0 results" {
            (Find-MovieInResultSet -ResultSet $Global:ResultSet -MatchAgainst $Global:MovieObjects.Item(8)).Response | Should Be "False"
        }
    }
}