# Installation of Arch Linux

Installing Arch Linux using the live system booted from an installation medium. More information are provided in the official [Installation guide](https://wiki.archlinux.org/title/installation_guide).

## Prerequisites

Change font size if needed with

```bash
setfont ter-132n
```

Check connection with `ping` and use `iwctl` when not already connected to the internet.

```
root@archiso ~ # iwctl

# for example
device list
station wlan0 get-networks
station wlan0 connect <Network Name>
exit
```

Update packages and [Arch Linux](https://archlinux.org/) PGP keyring with

```bash
pacman -Sy
pacman -Sy archlinux-keyring
```

## Partitioning disc

Use `lsblk` to list all drives and their partitions. Use `lsblk -f` to also show UUID's if needded.

```
root@archiso ~ # lsblk
NAME MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0    7:0  0 788.9M  1 loop /run/archiso/bootmnt
sr0     11:0  1   1.1G  0 rom  /run/archiso/airootfs
vda    254:0  0    20G  0 disk

root@archiso ~ # cfdisk /dev/vda
```

Use `cfdisk` to partition drives. Partition for `/boot` must be of type *EFI System* and partition for `/` must be of type *Linux filesystem*. A boot partition with about 800MB is sufficient.

Format the drives according to their purpose:

```bash
mkfs.fat -F32 /dev/vda1  # boot partition
mkfs.ext4 /dev/vda2
```

After partitioning, mount drives with:

```bash 
mount /dev/vda2 /mnt
mkdir /mnt/boot
mount /dev/vda1 /mnt/boot
```

The result should look as follows:

```
root@archiso ~ # lsblk
NAME MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0    7:0  0 788.9M  1 loop /run/archiso/bootmnt
sr0     11:0  1   1.1G  0 rom  /run/archiso/airootfs
vda    254:0  0    20G  0 disk
|-vda1 254:1  0   753M  0 part /mnt/boot
|-vda2 254:2  0  19.3G  0 part /mnt
```

## Pacstrap Arch/Filesystem

Install kernel and other stuff:

```bash
pacstrap -i /mnt base base-devel linux linux-headers linux-firmware vim git sudo networkmanager
```

Now generate `fstab` for current partition configuration:

```bash
genfstab -U /mnt >> /mnt/etc/fstab

# check if needed
cat /mnt/etc/fstab
```

## Chroot into Arch

Create `root password` and `user` with privilegdes.

```bash
passwd  # for root pw

useradd -m -g users -G wheel,storage,power,video,audio -s /bin/bash toni
passwd toni
```

Uncomment `%wheel ALL=(ALL:ALL) ALL` group with

```bash
export EDITOR=vim; visudo

# check if needed
su - toni
```

Set timezone and locale.

```bash
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc

sed -i 's/#en_US.UTF-8/en_US.UTF-8/g' /etc/locale.gen  # or use vim
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
```

Set hostname and hosts.

```bash
echo "Z790E" > /etc/hostname
echo "
127.0.0.1 localhost
::1 localhost
127.0.0.1 Z790E.localadmin Z790E" >> /etc/hosts
```

> [!TIP] Corresponding script
> `bash <(curl -Ls https://raw.githubusercontent.com/tonigineer/.dotfiles/main/scripts/arch_init.sh)`

## Install Grub

Install packages and grub:

```bash
pacman -S grub efibootmgr dosfstools mtools os-prober

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg 
```

> [!TIP] Corresponding script
> `bash <(curl -Ls https://raw.githubusercontent.com/tonigineer/.dotfiles/main/scripts/arch_grub.sh)`


## Finalize

Enabel services:

```bash
systemctl enable NetworkManager
# bluetooth if already install 
```

Exit with `exit`, umount all drives with `umount -lR /mnt` and `reboot`.




<!-- Here are the steps I took to install [Arch Linux](https://archlinux.org/). -->

<!-- 1. Change keyboard layout

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
``` -->