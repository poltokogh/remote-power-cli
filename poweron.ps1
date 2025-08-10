# Variabel
$cluster = "DC IDN-PALMERAH"
$vmHost = "192.168.20.103"
$vmNamePattern = "WEB-0*"

# Ambil objek host dulu
$hostObj = Get-VMHost -Name $vmHost

# Ambil VM yang sesuai wildcard
$vms = Get-VM -Location $hostObj | Where-Object { $_.Name -like $vmNamePattern }

if ($vms.Count -eq 0) {
    Write-Host "Tidak ada VM yang cocok dengan pola '$vmNamePattern' di host $vmHost" -ForegroundColor Yellow
    exit
}

# Nyalakan VM
foreach ($vm in $vms) {
    Write-Host "Menyalakan VM: $($vm.Name) ..." -ForegroundColor Cyan
    Start-VM -VM $vm -Confirm:$false
}

Write-Host "Proses selesai." -ForegroundColor Green
