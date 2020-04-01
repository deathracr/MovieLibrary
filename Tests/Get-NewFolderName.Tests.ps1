$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
$here = "$( (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests', '')MovieLibrary\Public"
if ( -not ((Test-Path -Path "$here\$sut") -eq $true) )
{
    $here = "$((Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests', '')MovieLibrary\Private"
}
. "$here\$sut"

. "$(Split-Path -Parent $MyInvocation.MyCommand.Path)\settings.ps1"

Describe "Get-NewFolderName" {
    It "Creates string from Movie object" {
        $Movie = [PSCustomObject]@{
            Title = "O Brother, Where Art Thou"
            Year = "2000"
        }
        Get-NewFolderName -Movie $Movie | Should Be "O Brother, Where Art Thou (2000)"
    }
}
