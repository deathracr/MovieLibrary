$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

. .\settings.ps1

Describe "Get-Deliminator" {
    $deliminator = Get-Deliminator -folder_name $Global:FolderNames.Item(0)
    It "Of the string $($Global:FolderNames.item(0)) it retrieves the deliminator: - " {
        $deliminator | Should Be "-"
    }
}
