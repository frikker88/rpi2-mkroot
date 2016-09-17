# Enable serial console login
echo "T0:23:respawn:/sbin/getty -L ttyS0 115200 vt100" >> "$ROOTFS/etc/inittab"

if [ -e "$SSH_KEY" ]; then
    chroot_exec apt-get -y install openssh-server
    mkdir -p "$ROOTFS/root/.ssh"
    chmod 600 "$ROOTFS/root/.ssh"
    cat "$SSH_KEY" > "$ROOTFS/root/.ssh/authorized_keys"
    chmod 600 "$ROOTFS/root/.ssh/authorized_keys"
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' "$ROOTFS/etc/ssh/sshd_config"
    # Lock root account password
    chroot_exec passwd -l root
    echo "Success: root's account was locked and SSH password login disabled. Use the key in $SSH_KEY to login." 1>&2
else
    sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/g' "$ROOTFS"/etc/ssh/sshd_config
    chroot_exec echo "root:guest" | chpasswd
    echo "Warning: no SSH key found, root's password has been set to 'guest' and SSH password login has been enabled! This can be a security risk if the device is exposed to a public network." 1>&2
fi
