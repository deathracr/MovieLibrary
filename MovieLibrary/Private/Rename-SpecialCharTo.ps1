<#
 .Synopsis

 .Description

 .Parameter TargetString

 .Parameter Set

 .Parameter Custom

 .Parameter NewCharacter

 .Example

#>
Function Rename-SpecialCharTo
{
    param
    (
        [Parameter(Mandatory=$true)]
        [string]
        $TargetString,
        [Parameter(Mandatory=$true)]
        [ValidateSet(“FileSystem”, ”URL”, "Custom")]
        [string]
        $Set,
        [string[]]
        $Custom,
        [string]
        $NewCharacter
    )

# Unwanted characters (includes spaces and '-') converted to a regex:
    Process {
        switch ($Set)
        {
            "FileSystem" { $SpecChars = '/', '\',':','*','?', '"', '<', '>', '|' }
            "URL" { <# $SpecChars = '/', '\',':','*','?', '"', '<', '>', '|' #> }
            "Custom" { $SpecChars = $Custom }
        }

        $remspecchars = [string]::join('|',($SpecChars | ForEach-Object {[regex]::escape($_)}))

        # Remove unwanted characters

        $TargetString -replace $remspecchars, $NewCharacter

    }
}