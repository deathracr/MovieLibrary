$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

. .\settings.ps1

Describe "ConvertTo-MovieObject" {
    It $Global:FolderNames.item(0) {
        $folder_name = $Global:FolderNames.item(0)
        $Response = ConvertTo-MovieObject -Directory $folder_name -Deliminator (Get-Deliminator $folder_name)
        Compare-Object -ReferenceObject $Global:MovieObjects.item(0).PSObject.Properties  `
                        -DifferenceObject $Response.PSObject.Properties `
                        -OutVariable Test | Should Be $null
    }


    It $Global:FolderNames.item(1) {
        $folder_name = $Global:FolderNames.item(1)
        $Response = ConvertTo-MovieObject -Directory $folder_name -Deliminator (Get-Deliminator $folder_name)
        Compare-Object -ReferenceObject $Global:MovieObjects.item(1).PSObject.Properties  `
                        -DifferenceObject $Response.PSObject.Properties `
                        -OutVariable Test | Should Be $null
    }

    It $Global:FolderNames.item(2) {
        $folder_name = $Global:FolderNames.item(2)
        $Response = ConvertTo-MovieObject -Directory $folder_name -Deliminator (Get-Deliminator $folder_name)
        Compare-Object -ReferenceObject $Global:MovieObjects.item(2).PSObject.Properties  `
                        -DifferenceObject $Response.PSObject.Properties `
                        -OutVariable Test | Should Be $null
    }

    It $Global:FolderNames.item(3) {
        $folder_name = $Global:FolderNames.item(3)
        $Response = ConvertTo-MovieObject -Directory $folder_name -Deliminator (Get-Deliminator $folder_name)
        Compare-Object -ReferenceObject $Global:MovieObjects.item(3).PSObject.Properties  `
                        -DifferenceObject $Response.PSObject.Properties `
                        -OutVariable Test | Should Be $null
    }

    It "Postive $($Global:FolderNames.item(4))" {
        $folder_name = $Global:FolderNames.item(4)
        $Response = ConvertTo-MovieObject -Directory $folder_name -Deliminator (Get-Deliminator $folder_name)
        Compare-Object -ReferenceObject $Global:MovieObjects.item(4).PSObject.Properties  `
                        -DifferenceObject $Response.PSObject.Properties `
                        -OutVariable Test | Should Be $null
    }

    It "Negative $($Global:FolderNames.item(4))" {
        $folder_name = $Global:FolderNames.item(4)
        $Response = ConvertTo-MovieObject -Directory $folder_name -Deliminator (Get-Deliminator $folder_name)
        Compare-Object -ReferenceObject $Global:MovieObjects.item(4).PSObject.Properties  `
                        -DifferenceObject $Response.PSObject.Properties `
                        -OutVariable Test | Should Be $null
    }

    It $Global:FolderNames.item(5) {
        $folder_name = $Global:FolderNames.item(5)
        $Response = ConvertTo-MovieObject -Directory $folder_name -Deliminator (Get-Deliminator $folder_name)
        Compare-Object -ReferenceObject $Global:MovieObjects.item(5).PSObject.Properties  `
                        -DifferenceObject $Response.PSObject.Properties `
                        -OutVariable Test | Should Be $null
    }
    It $Global:FolderNames.item(6) {
        $folder_name = $Global:FolderNames.item(6)
        $Response = ConvertTo-MovieObject -Directory $folder_name -Deliminator (Get-Deliminator $folder_name)
        Compare-Object -ReferenceObject $Global:MovieObjects.item(6).PSObject.Properties  `
                        -DifferenceObject $Response.PSObject.Properties `
                        -OutVariable Test | Should Be $null
    }
    It $Global:FolderNames.item(8) {
        $folder_name = $Global:FolderNames.item(8)
        $Response = ConvertTo-MovieObject -Directory $folder_name -Deliminator (Get-Deliminator $folder_name)
        Compare-Object -ReferenceObject $Global:MovieObjects.item(8).PSObject.Properties  `
                        -DifferenceObject $Response.PSObject.Properties `
                        -OutVariable Test | Should Be $null
    }
}
