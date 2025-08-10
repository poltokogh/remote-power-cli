# Variabel
$cluster = "DC IDN-PALMERAH"
$vmHost = "192.168.20.103"
$vmNamePattern = "WEB-0*"

# Ambil VM yang sesuai wildcard
$vms = Get-VM -Location $hostObj | Where-Object { $_.Name -like $vmNamePattern }

if ($vms.Count -eq 0) {
    Write-Host "Tidak ada VM yang cocok dengan pola '$vmNamePattern' di host $vmHost" -ForegroundColor Yellow
    exit
}

# Matikan VM
foreach ($vm in $vms) {
    Write-Host "Mematikan VM: $($vm.Name) ..." -ForegroundColor Cyan
    Stop-VM -VM $vm -Confirm:$false
}

Write-Host "Proses selesai." -ForegroundColor Green
