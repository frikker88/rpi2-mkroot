# Configure fstab
cat > "$ROOTFS/etc/fstab" <<EOF
/dev/mmcblk0p1 /    ext4  relatime,errors=remount-ro 0 1
tmpfs          /tmp tmpfs defaults                   0 0
EOF
