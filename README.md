A suite of utilities to build debian root filesystems and bootable images for the Cubieboard 5 (Cubietruck Plus).

## Utilities

- `mkrootfs <dir>` Build a debian root filesystem in the given directory
- `chrootfs <dir>` Start a shell in the given root filesystem.
- `mkrootimg <dir> <img>` Bundle a root filesystem into a binary image that can be flashed to an sd card (bootloader still needs to be flashed manually).

Run any of the above utilities with the `-h` or `--help` options for additional information.

## Usage Example
The typical use-case, creating a bootable image for the Cubieboard 5 involves the following steps:

1. Create a root filesystem in a temporary directory "tmprootfs".

		mkrootfs --hostname=cb5 --release=stretch --ssh-key=/home/user/.ssh/id_rsa.pub tmprootfs
			
2. (optional) Start a shell in the directory to install any additional packages.

		chrootfs tmprootfs
		
		root@inside_rootfs:~# apt install ... 
		root@inside_rootfs:~# ...
		root@inside_rootfs:~# exit
		
3. Pack the root filesystem into a binary image (note that the first 1MB of the image will be empty, reserved for a bootloader).

		mkrootimg tmprootfs cb5-stretch.img

4. Add bootloader to start of image (see http://linux-sunxi.org/Mainline_Debian_HowTo for instructions on how to build u-boot).
   
		dd if=<u-boot>/u-boot-sunxi-with-spl.bin of=cb5-stretch.img bs=1024 seek=8 conv=notrunc
		
5. Copy the image to an sd card.

		dd if=cb5-stretch.img of=/dev/mmc0

Note that you will need root privileges to run most of these commands.

## Copying
This program is free software, released under the GNU General Public License version 2.

Copyright (C) 2016 Jakob Odersky <jakob@odersky.com>

Copyright (C) 2015 Jan Wagner <mail@jwagner.eu>

The structure of the scripts was mostly copied from the [rpi2-gen-image](https://github.com/drtyhlpr/rpi23-gen-image) utility, by Jan Wagner.
