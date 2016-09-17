# Set host configuration
echo "$HOSTNAME" > "$ROOTFS/etc/hostname"
sed -i "/^127.0.0.1/ s/\$/ $HOSTNAME/" "$ROOTFS/etc/hosts"
sed -i "/^::1/ s/\$/ $HOSTNAME/" "$ROOTFS/etc/hosts"

# Set up networking
cat > "$ROOTFS/etc/network/interfaces.d/lo" <<EOF
auto lo
iface lo inet loopback
EOF
cat > "$ROOTFS/etc/network/interfaces.d/eth0" <<EOF
allow-hotplug eth0
iface eth0 inet dhcp
EOF
