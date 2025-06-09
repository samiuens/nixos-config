# Guide to Setup 'Full Disk Encryption' (with LUKS)

## Table of Contents
- [Partitioning](#partitioning)
  - [Passphrase](#passphrase)
- [Secure Boot](#secure-boot)
  - [Preparing your system](#preparing-your-system)
    - [Create Secure Keys](#create-secure-keys)
    - [Check the machine](#check-the-machine)
  - [Enabling Secure Boot](#enabling-secure-boot)
    - [Enrolling Keys](#enrolling-keys)
    - [Check Status of Secure Boot](#check-status-of-secure-boot)
- [Disk Encryption](#disk-encryption)
  - [Save Passphrase into TPM Storage](#save-passphrase-into-tpm-storage)
  - [Edit Hardware Configuration](#edit-hardware-configuration)
    - [Add args to your luks volume](#add-args-to-your-luks-volume)
    - [Add swapfile (optional)](#add-swapfile-optional)

# Partitioning
> [!IMPORTANT]
> It is recommend to use the GPT Partition table for creating the following partitions.

| Name   | File System | Size             | Mount       | Flags    | Encrypted?   |
| ------ | ----------- | ---------------- | -------- | ----------- | :----------: |
| `EFI`  |    fat32    | 1024MB           | `/boot/` |   `boot`    |      ❌      |
| `os`   |    ext4     | remaining space  |   `/`    |   `none`    |      ✅      |

We will add a swapfile later, so we will skip the swap partition for now!

## Passphrase

> [!IMPORTANT]
> Choose a secure passphrase, enter it and save it at a secure place, you will need it later!
> Also in cases of recovering your data.

Let the installation progress finish and reboot into the new system.
You'll have to enter your passphrase on every boot now, until we save the [passphrase in the tpm storage](#save-passphrase-into-tpm-storage).

# Secure Boot

## Preparing your system
### Create Secure Keys
The installation script automatically creates secure keys, so you can skip this setup.

### Check the machine
After rebuilding the system with the flake configuration, check `sbctl verify` output:

```console
$ sudo sbctl verify
Verifying file database and EFI images in /boot...
✓ /boot/EFI/BOOT/BOOTX64.EFI is signed
✓ /boot/EFI/Linux/nixos-generation-355.efi is signed
✓ /boot/EFI/Linux/nixos-generation-356.efi is signed
✗ /boot/EFI/nixos/0n01vj3mq06pc31i2yhxndvhv4kwl2vp-linux-6.1.3-bzImage.efi is not signed
✓ /boot/EFI/systemd/systemd-bootx64.efi is signed
```
It is expected that the files ending with `bzImage.efi` are not signed.

## Enabling Secure Boot

> [!CAUTION]
> It is recommended to disable bitlocker on any other windows partitions.
> Otherwise you'll have to recover the windows partition with your recovery key.
> After the setup, you can re-enable bitlocker on the windows partition.

The UEFI firmware allows enrolling Secure Boot keys when it is *Setup Mode*.

Find the option in your bios to reset the default secure keys, to enter the setup mode.

At least on some ASUS boards and others, you may also need to set the `OS Type` to "Windows UEFI Mode" in the Secure Boot settings, so that Secure Boot does get enabled.

### Enrolling Keys
Once you've booted your system into NixOS again, you have to enroll your keys to activate Secure Boot.

```console
$ sudo sbctl enroll-keys --microsoft
Enrolling keys to EFI variables...
With vendor keys from microsoft...✓
Enrolled keys to the EFI variables!
```

### Check Status of Secure Boot
You can now reboot your system. After you've booted, Secure Boot is activated and in user mode:

```console
$ bootctl status
System:
      Firmware: UEFI 2.70 (Lenovo 0.4720)
 Firmware Arch: x64
   Secure Boot: enabled (user)
  TPM2 Support: yes
  Boot into FW: supported
```
# Disk Encryption
At this point your disk is fully encrypted.

## Save Passphrase into TPM Storage
This step is **optional, but recommended**. Otherwise you have to enter the passphrase on every boot.

Run the following command, change your partition if needed (look via `lsblk`):
```console
sudo systemd-cryptenroll --wipe-slot=tpm2 --tpm2-device=auto --tpm2-pcrs=0+7 /dev/nvme0n1p2
```
Enter your passphrase and it will be saved into your tpm storage.

## Edit Hardware Configuration
Lastly, we need to modify the nixos hardware configuration in order to detect the passphrase in the tpm storage and setup an encrypted swapfile on your system.

### Add args to your luks volume
Find the following line in your hardware configuration: `boot.initrd.luks.devices."luks-..." = ...`

Change into the following schema, but keep the uuids of your volumes:
```
boot.initrd.luks.devices."luks-..." = {
  device = "/dev/disk/by-uuid/...";
  crypttabExtraOpts = [ "tpm2-device=auto" "tpm2-measure-pcr=yes" ]; # Looking in tpm storage for passphrase
};
```

### Add swapfile (optional)
It is recommended to have swap on linux, so we have to configure a swapfile in our hardware configuration.
The swapfile is a better option in my option, so we don't have to worry about unlocking another encrypted partition.

Add a swapfile to your hardware configuration, using the following lines:
Choose the size based on the table below or your preferences.
```
swapDevices = 
  [
    {
      device = "/swapfile";
      size = 8 * 1024; # 8GB
    }
  ];
```

## Recommended size for the swap file
![Screenshot of a table showing the recommended size of the swap partition/file.](/.github/assets/swap-size.png)

### Sources

[^1]: https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
[^2]: https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/managing_storage_devices/getting-started-with-swap_managing-storage-devices