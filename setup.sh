# network configuration
echo "network:
  version: 2
  renderer: networkd
  ethernets:
    enp225s0f0np0:
      dhcp4: no
      optional: true
    enp225s0f1np1:
      dhcp4: no
      optional: true
  bonds:
    bond0:
      interfaces: [enp225s0f0np0, enp225s0f1np1]
      addresses: [192.168.100.10/24]
      routes:
        - to: default
          via: 192.168.100.1
      mtu: 9000
      nameservers:
        addresses: [192.168.1.1, 192.168.1.2]" | sudo tee /etc/netplan/01-netcfg.yaml
# correct the permissions so the netplan does not complain
chmod 600 /etc/netplan/01-netcfg.yaml
netplan apply

# force to create the hostkeys
dpkg-reconfigure openssh-server
systemctl start ssh
# remove the nologin file to allow login
rm /run/nologin

# set local user password
printf "changeme\nchangeme" | passwd ubuntu-server