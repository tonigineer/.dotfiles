sudo pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat
sudo pacman -S libguestfs

sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

sudo usermod -a -G kvm,libvirt $(whoami)

sudo systemctl restart libvirtd.service

# https://computingforgeeks.com/install-kvm-qemu-virt-manager-arch-manjar/
