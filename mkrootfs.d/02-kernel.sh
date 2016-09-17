# Set up automatic kernel installation an upgrades
echo "Cubietech Cubietruck Plus" > "$ROOTFS/etc/flash-kernel/machine"
echo 'LINUX_KERNEL_CMDLINE="console=ttyS0,115200 hdmi.audio=EDID:0 disp.screen0_output_mode=EDID:1280x1024p60 rootfstype=ext4 root=/dev/mmcblk0p1 rootwait panic=10 ${extra}"' >> "$ROOTFS/etc/default/flash-kernel"

# Enable specific modules at startup
echo "rtc_sunxi" >> "$ROOTFS/etc/initramfs-tools/modules"
echo "mmc_core" >> "$ROOTFS/etc/initramfs-tools/modules"
echo "mmc_block" >> "$ROOTFS/etc/initramfs-tools/modules"
echo "sdhci" >> "$ROOTFS/etc/initramfs-tools/modules"
echo "sdhci-pci" >> "$ROOTFS/etc/initramfs-tools/modules"

chroot_exec flash-kernel
