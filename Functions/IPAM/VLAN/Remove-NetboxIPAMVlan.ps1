<#
    .NOTES
    ===========================================================================
     Created with:  SAPIEN Technologies, Inc., PowerShell Studio 2020 v5.7.181
     Created on:    2020-10-02 15:52
     Created by:    Claussen
     Organization:  NEOnet
     Filename:      New-NetboxIPAMVlan.ps1
    ===========================================================================
    .DESCRIPTION
        A description of the file.
#>


function Remove-NetboxIPAMVlan {
    <#
        .SYNOPSIS
            Remove a Vlan

        .DESCRIPTION
            Remove a IPAM Vlan from Netbox

        .EXAMPLE
            Remove-NetboxIPAMVlan -Id 1

            Remove Vlan with id 1

        .EXAMPLE
            Get-NetboxIPAMVlan -name My Vlan | Remove-NetboxIPAMVlan -confirm:$false

            Remove Vlan with name My Vlan without confirmation

    #>

    [CmdletBinding(ConfirmImpact = 'High',
        SupportsShouldProcess = $true)]
    param
    (
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true)]
        [uint]$Id

    )

    begin {

    }

    process {
        $CurrentVlan = Get-NetboxIPAMVlan -Id $Id -ErrorAction Stop

        if ($pscmdlet.ShouldProcess("$($CurrentVlan.Name)/$($CurrentVlan.Id)", "Remove Van")) {
            $Segments = [System.Collections.ArrayList]::new(@('ipam', 'vlan', $CurrentVlan.Id))

            $URI = BuildNewURI -Segments $Segments

            InvokeNetboxRequest -URI $URI -Method DELETE
        }
    }

    end {

    }
}