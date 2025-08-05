#!/bin/bash

# 🔧 Konfigurasi dasar
TEMPLATE_ID=9000
STORAGE=local-lvm
BRIDGE=vmbr0
PREFIX="MAIL-SERVER-01-PESERTA"
START=1
END=20
BASE_VMID=100    # VMID awal, misal VM pertama = 100, kedua = 101, dst

# Loop membuat VM
for ((i=START; i<=END; i++)); do
    # Format nomor peserta 2 digit (misalnya 01, 02, ..., 20)
    NUM=$(printf "%02d" "$i")
    VMNAME="${PREFIX}-${NUM}"
    VMID=$((BASE_VMID + i - 1))

    echo "🚀 Membuat VM ${VMNAME} dengan ID ${VMID}..."

    # Clone dari template
    qm clone $TEMPLATE_ID $VMID --name $VMNAME

    # Pindahkan disk ke storage
    qm move_disk $VMID scsi0 $STORAGE --delete

    # Set parameter dasar
    qm set $VMID \
        --memory 2048 \
        --cores 2 \
        --net0 virtio,bridge=$BRIDGE \
        --ipconfig0 ip=dhcp

    # Jalankan VM
    qm start $VMID
done

echo "✅ Selesai membuat VM dari ${START} sampai ${END}"
