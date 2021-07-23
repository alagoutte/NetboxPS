﻿<#
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2020 v5.7.172
	 Created on:   	3/26/2020 14:22
	 Created by:   	Claussen
	 Organization: 	NEOnet
	 Filename:     	BuildNewURI.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>


function BuildNewURI {
<#
    .SYNOPSIS
        Create a new URI for Netbox

    .DESCRIPTION
        Internal function used to build a URIBuilder object.

    .PARAMETER Hostname
        Hostname of the Netbox API

    .PARAMETER Segments
        Array of strings for each segment in the URL path

    .PARAMETER Parameters
        Hashtable of query parameters to include

    .PARAMETER HTTPS
        Whether to use HTTPS or HTTP

    .PARAMETER Port
        A description of the Port parameter.

    .PARAMETER APIInfo
        A description of the APIInfo parameter.

    .EXAMPLE
        PS C:\> BuildNewURI

    .NOTES
        Additional information about the function.
#>

    [CmdletBinding()]
    [OutputType([System.UriBuilder])]
    param
    (
        [Parameter(Mandatory = $false)]
        [string[]]$Segments,

        [Parameter(Mandatory = $false)]
        [hashtable]$Parameters,

        [switch]$SkipConnectedCheck
    )

    Write-Verbose "Building URI"

    if (-not $SkipConnectedCheck) {
        # There is no point in continuing if we have not successfully connected to an API
        $null = CheckNetboxIsConnected
    }

    # Begin a URI builder with HTTP/HTTPS and the provided hostname
    $uriBuilder = [System.UriBuilder]::new($script:NetboxConfig.HostScheme, $script:NetboxConfig.Hostname, $script:NetboxConfig.HostPort)

    # Generate the path by trimming excess slashes and whitespace from the $segments[] and joining together
    $uriBuilder.Path = "api/{0}/" -f ($Segments.ForEach({
                $_.trim('/').trim()
            }) -join '/')

    Write-Verbose " URIPath: $($uriBuilder.Path)"

    if ($parameters) {
        # Loop through the parameters and use the HttpUtility to create a Query string
        [System.Collections.Specialized.NameValueCollection]$URIParams = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)

        foreach ($param in $Parameters.GetEnumerator()) {
            Write-Verbose " Adding URI parameter $($param.Key):$($param.Value)"
            $URIParams[$param.Key] = $param.Value
        }

        $uriBuilder.Query = $URIParams.ToString()
    }

    Write-Verbose " Completed building URIBuilder"
    # Return the entire UriBuilder object
    $uriBuilder
}