# IP Host target
$targetHostIp = "192.168.20.103"

# Ambil semua host, lalu cari host dengan IP 192.168.20.103
$targetHost = Get-VMHost | Where-Object {
    $_.NetworkInfo.Ip -contains $targetHostIp
}

# Ambil semua VM di host target dengan pola DNS-06-PESERTA--<angka>
$vms = Get-VM -Location $targetHost | Where-Object {
    $_.Name -match "^DNS-06-PESERTA--\d+$"
}

# Jika tidak ada VM yang ditemukan
if ($vms.Count -eq 0) {
    Write-Host "⚠️ Tidak ada VM yang cocok dengan pola 'DNS-06-PESERTA--<angka>' di host $targetHostIp." -ForegroundColor Yellow
    return
}

# Proses penghapusan VM
foreach ($vm in $vms) {
    Write-Host "`n>> Menghapus VM: $($vm.Name)" -ForegroundColor Cyan

    if ($vm.PowerState -eq "PoweredOn") {
        Write-Host " - Mematikan VM..."
        Stop-VM -VM $vm -Confirm:$false

        while (($vm | Get-VM).PowerState -ne "PoweredOff") {
            Start-Sleep -Seconds 5
            Write-Host "   >> Menunggu VM mati..."
        }
    }

    Write-Host " - Menghapus VM..."
    Remove-VM -VM $vm -DeletePermanently -Confirm:$false
    Write-Host " ✅ VM $($vm.Name) berhasil dihapus." -ForegroundColor Green
}
