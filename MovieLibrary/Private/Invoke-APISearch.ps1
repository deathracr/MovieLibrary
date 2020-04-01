
function Invoke-APISearch {
    param (
        # Parameter help description
        [string]
        $OMDBAPIKey,
        # Parameter help description
        [PSObject]
        $QueryObject,
        # Parameter help description
        [ValidateSet("t", "s")]
        [string]
        $Type
    )
    switch ($local:Type)
    {
        t {
            if  ($local:QueryObject.Year)
            {
                $query = "http://www.omdbapi.com/?apikey=$OMDBAPIKey&$Type=$([System.Web.HttpUtility]::UrlEncode($QueryObject.Title))&y=$($QueryObject.year)"
            }
            else
            {
                $query = "http://www.omdbapi.com/?apikey=$OMDBAPIKey&$Type=$([System.Web.HttpUtility]::UrlEncode($QueryObject.Title))"
            }
        }
        default {
            if  ($local:QueryObject.Year)
            {
                $query = "http://www.omdbapi.com/?apikey=$OMDBAPIKey&s=$([System.Web.HttpUtility]::UrlEncode($QueryObject.Title))&y=$($QueryObject.year)"
            }
            else
            {
                $query = "http://www.omdbapi.com/?apikey=$OMDBAPIKey&s=$([System.Web.HttpUtility]::UrlEncode($QueryObject.Title))"
            }
        }
    }
    Invoke-RestMethod -Uri $query
}