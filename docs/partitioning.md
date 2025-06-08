# Overview of Partitions for LUKS Drive Encryption

> [!IMPORTANT]
> It is recommend to use the GPT Partition table for creating the following partitions.

| Name   | File System | Size             | Mount       | Flags    | Encrypted?   |
| ------ | ----------- | ---------------- | ----------- | -------- | :----------: |
| `EFI`  |    fat32    | 1024MB           | `/boot/efi` |  `boot`  |      ❌      |
| `swap` |  linuxswap  | *see hint*[^1]   |     none    |  `swap`  |      ✅      |
|  `os`  |    btrfs    | remaining space  |     `/`     |   `/`    |      ✅      |

## Recommended size for the swap partition
![Screenshot of a table showing the recommended size of the swap partition.](/.github/assets/swap-partition-size.png)

[^1]: https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/managing_storage_devices/getting-started-with-swap_managing-storage-devices