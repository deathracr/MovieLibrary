$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
$here = "$( (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests', '')MovieLibrary\Public"
if ( -not ((Test-Path -Path "$here\$sut") -eq $true) )
{
    $here = "$((Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests', '')MovieLibrary\Private"
}
. "$here\$sut"

. "$(Split-Path -Parent $MyInvocation.MyCommand.Path)\settings.ps1"

Describe "Invoke-APISearch" {
    It "Test S option with year" {
        $local:Response = Invoke-APISearch -OMDBAPIKey $OMDBAPIKey -QueryObject $Global:MovieObjects.Item(4)
        $local:Response.Response | Should Be "False"
    }
    It "Test S option with no year" {
        $local:Response = Invoke-APISearch -OMDBAPIKey $OMDBAPIKey -QueryObject $Global:MovieObjects.Item(3)
        $local:Response.Response | Should Be "False"
    }
    It "Test T option with year" {
        $local:Response = Invoke-APISearch -OMDBAPIKey $OMDBAPIKey -QueryObject $Global:MovieObjects.Item(4) -Type t
        $local:Response.Response | Should Be "False"
    }
    It "Test T option with no year" {
        $local:Response = Invoke-APISearch -OMDBAPIKey $OMDBAPIKey -QueryObject $Global:MovieObjects.Item(3) -Type t
        $local:Response.Response | Should Be "False"
    }
    It "Test S option with year" {
        $local:Response = Invoke-APISearch -OMDBAPIKey $OMDBAPIKey -QueryObject $Global:MovieObjects.Item(5)
        $local:Response.Response | Should Be "True"
    }
    It "Test T option with year" {
        $local:Response = Invoke-APISearch -OMDBAPIKey $OMDBAPIKey -QueryObject $Global:MovieObjects.Item(5) -Type t
        $local:Response.Response | Should Be "True"
    }
    It "Test S option with year" {
        $local:Response = Invoke-APISearch -OMDBAPIKey $OMDBAPIKey -QueryObject $Global:MovieObjects.Item(8)
        $local:Response.Response | Should Be "False"
    }
    It "Test T option with year" {
        $local:Response = Invoke-APISearch -OMDBAPIKey $OMDBAPIKey -QueryObject $Global:MovieObjects.Item(8) -Type t
        $local:Response.Response | Should Be "False"
    }
}