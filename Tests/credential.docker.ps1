#
# Copyright 2021, Alexis La Goutte <alexis dot lagoutte at gmail dot com>
#
# SPDX-License-Identifier: Apache-2.0
#

# Copy this file to credential.ps1 (on Tests folder) and change connection settings..

$script:hostname = "127.0.0.1"
$script:token = "0123456789abcdef0123456789abcdef01234567"

#Uncomment if you want to use another port to access to ClearPass
#script:pester_site1 = "pester_site1"

#Uncomment if you want to enable add and Remove Application License (recommended to use Onboard license for test...)
#$script:pester_license_type = "Onboard"
#$script:pester_license = "
#-----BEGIN CLEARPASS ONBOARD LICENSE KEY-----
#.....
#-----END CLEARPASS ONBOARD LICENSE KEY-----"