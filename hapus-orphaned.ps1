# Nama host target
$targetHostName = "192.168.20.103"

# Ambil objek host
$targetHostObj = Get-VMHost -Name $targetHostName

# Ambil semua VM orphaned dari host tersebut
$orphanedVMs = Get-VM -Location $targetHostObj | Where-Object {
    $_.ExtensionData.Runtime.ConnectionState -eq "orphaned"
}

foreach ($vm in $orphanedVMs) {
    Write-Host "`n>> Menghapus VM orphaned: $($vm.Name)" -ForegroundColor Cyan
    try {
        Remove-VM -VM $vm -DeletePermanently -Confirm:$false
        Write-Host " ✅ VM $($vm.Name) berhasil dihapus." -ForegroundColor Green
    } catch {
        Write-Host " ❌ Gagal menghapus VM $($vm.Name): $_" -ForegroundColor Red
    }
}
