﻿<#
    .NOTES
    ===========================================================================
     Created with:  SAPIEN Technologies, Inc., PowerShell Studio 2020 v5.7.172
     Created on:    3/19/2020 11:51
     Created by:    Claussen
     Organization:  NEOnet
     Filename:      New-NetboxIPAMAddress.ps1
    ===========================================================================
    .DESCRIPTION
        A description of the file.
#>


function New-NetboxIPAMAddress {
    <#
    .SYNOPSIS
        Create a new IP address to Netbox

    .DESCRIPTION
        Create a new IP address to Netbox with a status of Active by default.

    .PARAMETER Address
        IP address in CIDR notation: 192.168.1.1/24

    .PARAMETER Status
        Status of the IP. Defaults to Active

    .PARAMETER Tenant
        Tenant ID

    .PARAMETER VRF
        VRF ID

    .PARAMETER Role
        Role such as anycast, loopback, etc... Defaults to nothing

    .PARAMETER NAT_Inside
        ID of IP for NAT

    .PARAMETER Custom_Fields
        Custom field hash table. Will be validated by the API service

    .PARAMETER Interface
        ID of interface to apply IP

    .PARAMETER Description
        Description of IP address

    .PARAMETER Dns_name
        DNS Name of IP address (example : netbox.example.com)

    .PARAMETER Assigned_Object_Type
        Assigned Object Type dcim.interface or virtualization.vminterface

    .PARAMETER Assigned_Object_Id
        Assigned Object ID

    .PARAMETER Raw
        Return raw results from API service

    .EXAMPLE
        New-NetboxIPAMAddress -Address 192.0.2.1/32

        Add new IP Address 192.0.2.1/32 with status active

    .NOTES
        Additional information about the function.
#>

    [CmdletBinding(ConfirmImpact = 'Low',
        SupportsShouldProcess = $true)]
    [OutputType([pscustomobject])]
    param
    (
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true)]
        [string]$Address,

        [object]$Status = 'Active',

        [int]$Tenant,

        [int]$VRF,

        [object]$Role,

        [int]$NAT_Inside,

        [hashtable]$Custom_Fields,

        [int]$Interface,

        [string]$Description,

        [string]$Dns_name,

        [ValidateSet('dcim.interface', 'virtualization.vminterface', IgnoreCase = $true)]
        [string]$Assigned_Object_Type,

        [int]$Assigned_Object_Id,

        [switch]$Raw
    )

    process {
        $Segments = [System.Collections.ArrayList]::new(@('ipam', 'ip-addresses'))
        $Method = 'POST'

        $URIComponents = BuildURIComponents -URISegments $Segments -ParametersDictionary $PSBoundParameters

        $URI = BuildNewURI -Segments $URIComponents.Segments

        if ($PSCmdlet.ShouldProcess($Address, 'Create new IP address')) {
            InvokeNetboxRequest -URI $URI -Method $Method -Body $URIComponents.Parameters -Raw:$Raw
        }
    }
}





