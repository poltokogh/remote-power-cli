# Konfigurasi jaringan
$vmPrefix = "MAIL-SERVER-01-PESERTA-"
$ipBase = "172.23.8."
$startIP = 131
$endIP = 142
$gateway = "172.23.0.1"
$dns1 = "8.8.8.8"
$dns2 = "8.8.4.4"
$netmask = "20"
$interface = "ens33"
$guestUser = "ubuntu"
$guestPass = "ubuntu"

for ($i = 1; $i -le ($endIP - $startIP + 1); $i++) {
    $vmName = "${vmPrefix}${i}"
    $newIP = "${ipBase}$($startIP + $i - 1)"
    Write-Host "🔧 Setting static IP ${newIP} untuk VM ${vmName}" -ForegroundColor Cyan

    $script = @"
echo '${guestPass}' | sudo -S bash -c 'cat <<EOF > /etc/netplan/50-cloud-init.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    ${interface}:
      addresses:
        - ${newIP}/${netmask}
      gateway4: ${gateway}
      nameservers:
        addresses:
          - ${dns1}
          - ${dns2}
EOF
chmod 600 /etc/netplan/50-cloud-init.yaml
netplan apply'
"@

    Invoke-VMScript -VM $vmName -ScriptText $script -GuestUser $guestUser -GuestPassword $guestPass -ScriptType Bash | Select-Object -ExpandProperty ScriptOutput
}
