A suite of utilities to build a debian root filesystem and bootable image for the Raspberry Pi 2, model B.

## Utilities

- `mkrootfs` Build a debian root filesystem in the given directory
- `mkrootimg` Bundle a root filesystem into a bootable, binary image that can be flashed to an sd card.

Run any of the above utilities without arguments for additional information.

## Usage Example
The typical use-case, creating a bootable image involves the following steps:

1. Create a root filesystem in a temporary directory "tmprootfs".

		mkrootfs --hostname=pi --release=stretch --ssh-key=/home/user/.ssh/id_rsa.pub tmprootfs

2. Pack the root filesystem into a binary image

		mkrootimg tmprootfs pi2-stretch.img

3. Copy the image to an sd card.

		dd if=pi2-stretch.img of=/dev/mmc0

4. Boot a Raspberry Pi from the card.

   Note that several initialization tasks are performed during the first boot:

   - the root filesystem is expanded to fill the whole sd card
   - ssh keys and machine ids are regenerated

   Progress will be signaled through the ACT and PWR LEDs:
   
   - both leds will flash rapidly for a couple of seconds, indicating
     that first-boot tasks are about to start
   - PWR will blink in a "heartbeat" pattern and ACT will indicate sd card activity
   - first-boot tasks are run
   - after completion, the ACT led will blink in a heartbeat pattern an PWR will be turned off

## Requirements

- qemu-user-static
- qemu-debootstrap

## Copying
This program is free software, released under the GNU General Public License version 2.

Copyright (C) 2016 Jakob Odersky <jakob@odersky.com>

Copyright (C) 2015 Jan Wagner <mail@jwagner.eu>

The structure of the scripts was mostly copied from the [rpi2-gen-image](https://github.com/drtyhlpr/rpi23-gen-image) utility, by Jan Wagner.
