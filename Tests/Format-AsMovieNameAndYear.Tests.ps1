$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
$here = "$( (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests', '')MovieLibrary\Public"
if ( -not ((Test-Path -Path "$here\$sut") -eq $true) )
{
    $here = "$((Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests', '')MovieLibrary\Private"
}
. "$here\$sut"

. "$(Split-Path -Parent $MyInvocation.MyCommand.Path)\settings.ps1"

Describe "Format-AsMovieNameAndYear" {
    It "This is an integration test.  Verify output." {
        Format-AsMovieNameAndYear -Root "\\senorita\download\momentum\downloaded" -OMDBAPIKey 24dd0d05 -Test
        $true | Should Be $true
    }
}
