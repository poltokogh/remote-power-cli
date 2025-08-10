# Variabel
$clusterName = "DC IDN-PALMERAH"
$vmNamePattern = "latihan*"

# Ambil objek cluster
#$cluster = Get-Cluster -Name $clusterName

# Ambil semua VM di cluster yang cocok dengan pola nama
$vms = Get-VM -Location $cluster | Where-Object { $_.Name -like $vmNamePattern }

if ($vms.Count -eq 0) {
    Write-Host "Tidak ada VM yang cocok dengan pola '$vmNamePattern' di cluster $clusterName" -ForegroundColor Yellow
    exit
}

# Hapus VM beserta file disknya (Delete from disk)
foreach ($vm in $vms) {
    Write-Host "Menghapus VM: $($vm.Name) dari disk..." -ForegroundColor Red
    Remove-VM -VM $vm -DeletePermanently -Confirm:$false
}

Write-Host "Proses penghapusan selesai." -ForegroundColor Green
