Install-Module -Name VMware.PowerCLI -AllowClobber
Import-Module VMware.PowerCLI.VIMAutomation.Core
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -confirm:$false

$server = "172.23.0.20"
Connect-VIServer -Server $server
