# Install

The DGX OS `.iso` includes several bundled packages. And it has been observed that installing hardware related packages from the official Ubuntu repositories instead of the ones bundled with the image can compromise the stability of the live environment. In many cases, this results in crashes that require starting the entire setup process from scratch.

To prevent this, begin by pinning the kernel and installing all required packages directly from the USB media. Avoid running full system upgrades.

```bash
sudo apt-mark hold linux-image-generic linux-headers-generic
sudo apt install doca-repo dgx-repo cuda-compute-repo
sudo apt update

sudo apt install nvidia-driver-570-open nvidia-utils-570 nvidia-fabricmanager-570 nvidia-persistenced nvidia-system-mlnx-drivers
```

Once the essential packages are installed, you can safely enable the official Ubuntu repositories corresponding to the base system version. For DGX OS 7, that version is Ubuntu Server 24.04 (noble):

```bash
echo "Types: deb
URIs: http://archive.ubuntu.com/ubuntu
Suites: noble noble-updates noble-backports
Components: main universe restricted multiverse

Types: deb
URIs: http://security.ubuntu.com/ubuntu
Suites: noble-security
Components: main universe restricted multiverse" | sudo tee /etc/apt/sources.list.d/ubuntu.sources
sudo apt update
```

## GPUs

Start the necessary NVIDIA services to initialize GPU persistence and fabric management:

```
sudo systemctl start nvidia-persistenced
sudo systemctl start nvidia-fabricmanager
```

## CUDA

The most reliable way to install CUDA is by specifying the desired version of the `cuda-toolkit` package. Note that this package does not automatically update your `PATH`, so you’ll need to adjust it manually:

```bash
nvidia-smi
sudo apt install cuda-toolkit=12.8.1-1
PATH=/usr/local/cuda/bin:$PATH nvcc --version
```

## Mellanox

To initialize Mellanox drivers and check InfiniBand connectivity, use the following commands.

```bash
sudo /etc/init.d/openibd restart
ibstatus
/etc/init.d/openibd status
```