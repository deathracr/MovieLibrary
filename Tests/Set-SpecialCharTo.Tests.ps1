$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
$here = "$( (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests', '')MovieLibrary\Public"
if ( -not ((Test-Path -Path "$here\$sut") -eq $true) )
{
    $here = "$((Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests', '')MovieLibrary\Private"
}
. "$here\$sut"

. "$(Split-Path -Parent $MyInvocation.MyCommand.Path)\settings.ps1"

Describe "Set-SpecialCharTo" {
    Context "OMDB API Movie Names" {
        $TargetString = "Fur: An Imaginary Portrait of Diane Arbus"
        It "Cleans reserved filesystem chars from string." {
            Set-SpecialCharTo -TargetString $TargetString -Set FileSystem -NewCharacter " " | Should Be "Fur  An Imaginary Portrait of Diane Arbus"
        }
    }
    Context "Cleaning token to get 4 digit year value"{
        $TargetString = "#[()1978]-"
        $DisAllowedChars = "(",")","[","]","-","#"
        It "Removes unwanted character sets from string." {
            Set-SpecialCharTo -TargetString $TargetString -Set Custom -Custom $DisAllowedChars | Should Be "1978"
        }
    }
}
