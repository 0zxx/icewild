#!/bin/sh

# Set the keyboard map
echo "US-US" | setup-keymap

# Set the hostname
echo "icw" > /etc/hostname

# Configure the network interface
cat <<EOF > /etc/network/interfaces
auto eth0
iface eth0 inet static
  address 10.0.2.15
  netmask 255.255.255.0
  gateway 10.0.2.2
  dns-nameservers 9.9.9.9
EOF

# Set the timezone
setup-timezone -z UTC

# Disable proxy settings
sed -i 's/^http_proxy=/#http_proxy=/g' /etc/apk/repositories
sed -i 's/^https_proxy=/#https_proxy=/g' /etc/apk/repositories

# Random repository settings
sed -i 's/^#http:\/\/dl-cdn.alpinelinux.org/https:\/\/dl-cdn.alpinelinux.org/g' /etc/apk/repositories

# Disable SSH server
rc-update del sshd

# Disk setup
setup-disk -m sys -s 0 /dev/sda

# Syslog setup
setup-sshd -c sda

# Reboot the system
reboot
