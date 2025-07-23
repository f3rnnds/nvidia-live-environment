# Nvidia Live Environment

This repository outlines how to run a live environment on a system equipped with NVIDIA GPUs, with all required drivers in a functional state. This setup is particularly useful for critical diagnostics or testing scenarios where modifying the original operating system is not an option.

While originally developed for an NVIDIA DGX A100, the steps should be adaptable to any system with NVIDIA GPUs.

## Instructions

The process is divided into two main stages:

* **Setup**: Create bootable media and configure the system for remote access with minimal setup.

* **Install**: Perform a minimal installation of the NVIDIA software stack to enable GPU usage.

Each stage is documented in a dedicated Markdown file in this repository.

## References

* https://docs.nvidia.com/dgx/dgx-os-7-user-guide/index.html

* https://docs.nvidia.com/dgx/dgxa100-user-guide/index.html