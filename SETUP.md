# Setup

To accelerate the install process, especially when working with packages bundled in the DGX OS `.iso`, a physical USB installation media is preferred over a virtual media. This significantly reduces installation time and improves reliability.

## Bootable Media

You can create a bootable USB drive using [Ventoy](https://github.com/ventoy/Ventoy) (version 1.1.01 or newer). Download the latest `.tar.gz` package and use the included script to prepare the USB device. Replace `/dev/sdX` with the correct device path (check with `lsblk`):

```bash
wget https://github.com/ventoy/Ventoy/releases/download/v1.1.05/ventoy-1.1.05-linux.tar.gz
tar -xzf ventoy-1.1.05-linux.tar.gz
cd ventoy-1.1.05
sudo ./Ventoy2Disk.sh -i /dev/sdX
```

To automate the setup configuration, you can embed scripts into the USB media. Ventoy allows remounting the ISO partition during live boot by adding a `ventoy/ventoy.json` config file in the root directory of the USB:

```json
{
    "control":[
        { "VTOY_LINUX_REMOUNT": "1" }
    ]
}
```

Copy the `setup.sh` script from this repository to the root of the USB too. Its function is explained in the following section.

## Live Environment and Remote Access

Using the system's management controller or connecting physically to the target machine. Boot from the USB drive and select `Boot Into Rescue Shell` from the DGX OS menu.

Once inside the shell, trigger device events and list device-mapper entries. You should see a bootloader (`ventoy`) and a data partition (`sda1`). Mount the data partition to access the setup scripts:

```bash
udevadm trigger
dmsetup ls
# Example output:
# sda1    (252:1)
# ventoy  (252:0)
mount /dev/mapper/sda1 /mnt
```

The script `setup.sh` in this repository:

* Creates a bonded network interface using static IP settings (customize as needed).

* Regenerates SSH host keys, starts the SSH service, and enables login.

* Sets a temporary password for the `ubuntu-server` user (remember to change it).

To execute the script:

```bash
cd /mnt
./setup.sh
```

You can verify connectivity using `ip a` and `ping`. Once the system is reachable, disconnect from the console and SSH into the live environment:

```bash
ssh ubuntu-server@192.168.1.100
```