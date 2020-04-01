properties {
    $scripts = New-Object -TypeName System.Collections.ArrayList
    Get-ChildItem -Path $PSScriptRoot\MovieLibrary\Public  -Filter *-*.ps1  | ForEach-Object {[void]$scripts.Add($_.FullName) }
    Get-ChildItem -Path $PSScriptRoot\MovieLibrary\Private  -Filter *-*.ps1  | ForEach-Object {[void]$scripts.Add($_.FullName) }
}

task default -depends Analyze, Test

task Analyze {
    $saResults = New-Object -TypeName System.Collections.ArrayList
    foreach ($script in $scripts)
    {
        $saResults = Invoke-ScriptAnalyzer -Path $script -Severity @('Error','Warning') -Recurse -Verbose:$false
        if ($saResults) {
            $saResults | Format-Table
            Write-Error -Message 'One or more Script Analyzer errors/warnings where found. Build cannot continue!'
        }
    }
}

task Test {
    $testResults = Invoke-Pester -Path $PSScriptRoot -PassThru
    if ($testResults.FailedCount -gt 0) {
        $testResults | Format-List
        Write-Error -Message 'One or more Pester tests failed. Build cannot continue!'
    }
}

task Deploy -depends Analyze, Test {
    Invoke-PSDeploy -Path '.\MovieLibrary.psdeploy.ps1' -Force -Verbose:$VerbosePreference
}