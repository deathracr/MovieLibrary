$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

. .\settings.ps1
Describe "Get-NewFolderName" {
    It "Creates string from Movie object" {
        $Movie = [PSCustomObject]@{
            Title = "O Brother, Where Art Thou"
            Year = "2000"
        }
        Get-NewFolderName -Movie $Movie | Should Be "O Brother, Where Art Thou (2000)"
    }
}
