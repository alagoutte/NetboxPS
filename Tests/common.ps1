#
# Copyright 2021, Alexis La Goutte <alexis dot lagoutte at gmail dot com>
#
# SPDX-License-Identifier: Apache-2.0
#
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingConvertToSecureStringWithPlainText", "")]
Param()
. ../credential.ps1

$script:pester_site1 = "pester_site1"

$Credential = New-Object System.Management.Automation.PSCredential("username", (ConvertTo-SecureString $token -AsPlainText -Force))
$script:invokeParams = @{
    hostname             = $hostname;
    Credential           = $Credential;
    SkipCertificateCheck = $true;
}

#TODO: Add check if no ipaddress/token info...