# Installation of Arch Linux

Installing Arch Linux using the live system booted from an installation medium. More information [here](https://wiki.archlinux.org/title/installation_guide)

## Table of Contents

- [Installation of Arch Linux](#installation-of-arch-linux)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)

## Installation

Here are the steps I took to install [Arch Linux](https://archlinux.org/).

1. Change keyboard layout

``` bash
loadkeys us
```

Permanently change layout later, see [here (last comment).](https://unix.stackexchange.com/questions/75519/how-to-set-default-console-keyboard-layout-in-arch-linux)

2. Verify boot mode

``` bash
ls /sys/firmware/efi/efivars  # If directory exists, EFI is supported.
```

<details><summary><b>Show partitioning example</b></summary>

- Check disks

```bash
fdisk -l
# /dev/sda/ mostly likely
```

- Create EFI partition

```bash
fdisk /dev/sda
# g (new partition table)
# n (new partition
# 1
# enter
# +300M
# t
# 1 (EFI)
# w
```

- Create root partition

```bash
fdisk /dev/sda
# n (new partition
# 2
# enter
# +500G
# w
```

- Create home partition

```bash
fdisk /dev/sda
# n (new partition
# 2
# enter
# enter (remaining space)
# w
```

- Creating file systems

```bash
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda3
```

- Mount home on root

```bash
mount /dev/sda2 /mnt
mkdir /mnt/home
mount /dev/sda3 /mnt/home
```
</details>

3. Install Arch-Linux and needed packages

```bash
pacman -Sy archlinux-keyring
pacstrap -i /mnt base linux-lts linux-lts-headers linux-firmware networkmanager sudo grub vim
```

4. Generate file system table

```bash
genfstab -U -p /mnt >> /mnt/etc/fstab
```

5. `chroot` into system

```bash
arch-chroot /mnt
```

6. Add user

```bash
useradd -m toni
usermod -aG wheel toni

passwd
passwd toni
```

7. Add user privileges

Uncomment `%wheel ALL=(ALL:ALL) NOPASSWD: ALL` group.

```bash
export EDITOR=vim; visudo
```

8. Set timezone

```bash
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc
```

> Using DualBoot with Windows? Set `timedatectl set-local-rtc 1`. Explanation can be found [here](https://itsfoss.com/wrong-time-dual-boot/).

9. Set locale

```bash
sed -i 's/#en_US.UTF-8/en_US.UTF-8/g' /etc/locale.gen
locale-gen
```

10. Create EFI boot directory

```bash
mkdir /boot/EFI
mount /dev/sda1 /boot/EFI
```

11. Install grub

```bash
grub-install /dev/sda --force  # ignore errors
grub-mkconfig -o /boot/grub/grub.cfg
```

12. Finish install

Enable `NetworkManager` and reboot.

```bash
systemctl enable NetworkManager

exit
umount -a
reboot
```