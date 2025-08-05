# Konfigurasi VM
$template = "ubuntu22-mail-server"      # Nama template yang ingin dikloning
$datastore = "HDD-DATASTORE"       # Nama datastore tempat menyimpan VM
$cluster = "DC IDN-PALMERAH" # Nama cluster tempat VM ditempatkan
$vmPrefix = "MAIL-SERVER-01-PESERTA"      # Prefix nama VM yang akan dikloning
$startIndex = 1             # Nomor awal VM
$numVMs = 12                 # Jumlah VM yang ingin dibuat
$vmHost = "192.168.20.103"  # Nama host ESXi tujuan

# Loop untuk membuat VM
for ($i = $startIndex; $i -lt ($startIndex + $numVMs); $i++) {
    $vmName = "$vmPrefix-$i"

    # Clone VM dari template
    New-VM -Name $vmName `
           -Template $template `
           -Datastore $datastore `
           -VMHost $vmHost `
           -Verbose

    Write-Host "VM $vmName telah dibuat."
}