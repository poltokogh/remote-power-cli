# Setup
Jalankan script dibawah untuk install dan setup module.

```
Install-Module -Name VMware.PowerCLI -AllowClobber
Import-Module VMware.PowerCLI.VIMAutomation.Core
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -confirm:$false
```

Connect remote
```
$server = "172.23.0.20"
Connect-VIServer -Server $server
```
