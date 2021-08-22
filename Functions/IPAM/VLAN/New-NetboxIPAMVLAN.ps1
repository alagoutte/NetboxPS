<#
    .NOTES
    ===========================================================================
     Created with:  SAPIEN Technologies, Inc., PowerShell Studio 2020 v5.7.172
     Created on:    3/16/2020 16:34
     Created by:    Claussen
     Organization:  NEOnet
     Filename:      Get-NetboxIPAMVLAN.ps1
    ===========================================================================
    .DESCRIPTION
        A description of the file.
#>

function New-NetboxIPAMVLAN {
    <#
    .SYNOPSIS
        Create a new VLAN

    .DESCRIPTION
        Create a new VLAN in Netbox with a status of Active by default.

    .PARAMETER VID
        The VLAN ID.

    .PARAMETER Name
        The name of the VLAN.

    .PARAMETER Status
        Status of the VLAN. Defaults to Active

    .PARAMETER Tenant
        Tenant ID

    .PARAMETER Role
        A role indicates the function of a prefix or VLAN. For example, you might define Data, Voice, and Security roles

    .PARAMETER Description
        Description of Vlan

    .PARAMETER Custom_Fields
        Custom field hash table. Will be validated by the API service

    .PARAMETER Raw
        Return raw results from API service

    .EXAMPLE
        PS C:\> Create-NetboxIPAMAddress

    .NOTES
        Additional information about the function.
#>

    [CmdletBinding(ConfirmImpact = 'low',
        SupportsShouldProcess = $true)]
    [OutputType([pscustomobject])]
    param
    (
        [Parameter(Mandatory = $true)]
        [uint16]$VID,

        [Parameter(Mandatory = $true)]
        [string]$Name,

        [object]$Status = 'Active',

        [uint16]$Tenant,

        [object]$Role,

        [string]$Description,

        [hashtable]$Custom_Fields,

        [switch]$Raw
    )

    #    $PSBoundParameters.Status = ValidateIPAMChoice -ProvidedValue $Status -VLANStatus

    #    if ($null -ne $Role) {
    #        $PSBoundParameters.Role = ValidateIPAMChoice -ProvidedValue $Role -IPAddressRole
    #    }

    $segments = [System.Collections.ArrayList]::new(@('ipam', 'vlans'))

    $URIComponents = BuildURIComponents -URISegments $segments -ParametersDictionary $PSBoundParameters

    $URI = BuildNewURI -Segments $URIComponents.Segments

    if ($PSCmdlet.ShouldProcess($name, 'Create new Vlan $($vid)')) {
        InvokeNetboxRequest -URI $URI -Method POST -Body $URIComponents.Parameters -Raw:$Raw
    }
}