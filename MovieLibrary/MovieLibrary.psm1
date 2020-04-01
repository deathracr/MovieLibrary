#Requires -Version 5.1

Add-Type -AssemblyName System.Web

$Global:DisAllowedChars = "(",")","[","]","-","#"
$Global:Delimiters      = "\.","-","_"," "

Get-ChildItem -Path $PSScriptRoot  -Filter *-*.ps1 | Where-Object { $_.Name -notmatch "Tests"} | ForEach-Object {. $_.FullName }
