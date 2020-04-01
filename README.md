## About

Author: Byron Guptill [[byron.guptill.ca](https://byron.guptill.ca)]


# MovieLibrary



## Overview

This repository hosts the ```MovieLibrary``` module. The module allows you manipulate one or more directory names of which each represents a movie. 
This repository also  includes associated tests and build tasks for day to day operations and deployment of the script.

## Usage

A ```psake``` script has been created to manage the various operations related to testing and deployment of ```MovieLibrary```

### Build Operations


* Test the script via Pester and Script Analyzer  
```powershell
.\build.ps1
```
    
* Test the script with Pester only  
```powershell
.\build.ps1 -Task Test
```
    
* Test the script with Script Analyzer only  
```powershell
.\build.ps1 -Task Analyze
```
    
* Deploy the script via PSDeploy  
```powershell
.\build.ps1 -Task Deploy
```