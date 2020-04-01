Deploy 'Deploy ServerInfo script' {
    By Filesystem {
        FromSource '.\MovieLibrary\'
        To 'C:\data\MovieLibrary\'
        Tagged Prod
    }
}