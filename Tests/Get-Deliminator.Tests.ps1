$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
$here = "$( (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests', '')MovieLibrary\Public"
if ( -not ((Test-Path -Path "$here\$sut") -eq $true) )
{
    $here = "$((Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests', '')MovieLibrary\Private"
}
. "$here\$sut"

. "$(Split-Path -Parent $MyInvocation.MyCommand.Path)\settings.ps1"

Describe "Get-Deliminator" {
    $deliminator = Get-Deliminator -folder_name $Global:FolderNames.Item(0)
    It "Of the string $($Global:FolderNames.item(0)) it retrieves the deliminator: - " {
        $deliminator | Should Be "-"
    }
}