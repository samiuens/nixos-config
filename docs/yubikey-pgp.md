# Guide on using pgp keys in combination with a yubikey
In my configuration, I am using these pgp keys to encrypt my [sops-nix](https://github.com/Mic92/sops-nix) secrets.
These include confidential access data for all my machines & servers. 

In my case, I have two yubikeys both with access to my secrets, in case one breaks or gets lost.
By using this method, it is always possible to recover my secrets and change the keys for the secret file.

## Table of Contents
- [Prepare GnuPG](#prepare-gnupg)
  - [Set variables](#set-variables)
- [Key operations](#key-operations)
  - [Create Certify key](#create-certify-key)
  - [Create subkeys](#create-subkeys)
  - [Verify keys](#verify-keys)
  - [Backup keys](#backup-keys)
  - [Export public key](#export-public-key)
- [Configure yubikey](#configure-yubikey)
  - [Change PIN](#change-pin)
  - [Use variables](#use-variables)
  - [Transfer subkeys](#transfer-subkeys)
    - [Signature key](#signature-key)
    - [Encryption key](#encryption-key)
    - [Authentication key](#authentication-key)
  - [Verify transfer](#verify-transfer)
- [Interim check](#interim-check)
- [Loading keys on other systems](#loading-keys-on-other-systems)
- [Sources](#sources)

# Prepare GnuPG
## Set variables

Set a path, where to store all secret files for saving them later.
Make sure the folder exists in your local filesystem.
```console
export SECRET_PATH="~/secrets"
```

Set description for future key identification.
```console
export IDENTITY="Surname, Forname <email@domain.com> ($keylabel)"
```

Set the key type to `RSA 4096`.
```console
export KEY_TYPE=rsa4096
```

Generate a passphrase for the Certify key. 
This credential will be used to manage identity subkeys.
```console
export CERTIFY_PASS=$(LC_ALL=C tr -dc "A-Z2-9" < /dev/urandom | \
    tr -d "IOUS5" | \
    fold  -w  ${PASS_GROUPSIZE:-4} | \
    paste -sd ${PASS_DELIMITER:--} - | \
    head  -c  ${PASS_LENGTH:-29})
printf "\n$CERTIFY_PASS\n\n"
```
Save the passphrase at a safe location.

# Key operations
## Create Certify key
The primary key to generate is the Certify key, which is responsible for issuing subkeys for encryption, signature and authentication operations.
The Certify key should be kept safely at all times and only accessed from a dedicated and secure environment to issue or revoke subkeys.

Generate the certify key.
```console
echo "$CERTIFY_PASS" | \
    gpg --batch --passphrase-fd 0 \
        --quick-generate-key "$IDENTITY" "$KEY_TYPE" cert never
```

Set and view the Certify key identifier and fingerprint for referencing later.
```console
export KEYID=$(gpg -k --with-colons "$IDENTITY" | \
    awk -F: '/^pub:/ { print $5; exit }')

export KEYFP=$(gpg -k --with-colons "$IDENTITY" | \
    awk -F: '/^fpr:/ { print $10; exit }')

printf "\nKey ID: %40s\nKey FP: %40s\n\n" "$KEYID" "$KEYFP"
```

## Create subkeys
Generate Signature, Encryption and Authentication subkeys using the previously configured variables.
```console
for SUBKEY in sign encrypt auth ; do \
    echo "$CERTIFY_PASS" | \
    gpg --batch --pinentry-mode=loopback --passphrase-fd 0 \
        --quick-add-key "$KEYFP" "$KEY_TYPE" "$SUBKEY" "$EXPIRATION"
done
```

## Verify keys

List available secret keys, which are known to gpg.
```console
gpg -K
```

The output will display [C]ertify, [S]ignature, [E]ncryption and [A]uthentication keys, to check the status of these keys.
```console
sec   rsa4096/0xF0F2CFEB04341FB5 2025-01-01 [C]
      Key fingerprint = 4E2C 1FA3 372C BA96 A06A  C34A F0F2 CFEB 0434 1FB5
uid                   [ultimate] Surname, Forname <email@domain.com>
ssb   rsa4096/0xB3CD10E502E19637 2025-01-01 [S] [expires: 2027-05-01]
ssb   rsa4096/0x30CBE8C4B085B9F7 2025-01-01 [E] [expires: 2027-05-01]
ssb   rsa4096/0xAD9E24E1B8CB9600 2025-01-01 [A] [expires: 2027-05-01]
```

## Backup keys

Save a copy of the Certify key, subkeys and public key.
```console
echo "$CERTIFY_PASS" | \
    gpg --output $SECRET_PATH/$KEYID-certify.key \
        --batch --pinentry-mode=loopback --passphrase-fd 0 \
        --armor --export-secret-keys $KEYID

echo "$CERTIFY_PASS" | \
    gpg --output $SECRET_PATH/$KEYID-subkeys.key \
        --batch --pinentry-mode=loopback --passphrase-fd 0 \
        --armor --export-secret-subkeys $KEYID

gpg --output $SECRET_PATH/$KEYID-public.asc \
    --armor --export $KEYID
```

## Export public key

> [!IMPORTANT]
> Without the public key, it will not be possible to use GnuPG for decrypting or signing operations!

Export the public key. This key is safe to share, everywhere.
This step is only needed, if you want the public key file at an other place.
It is automatically backed up, due to the previous step.
```console
gpg --armor --export $KEYID | sudo tee $SECRET_PATH/$KEYID-$(date +%F)-public.asc
```

# Configure yubikey

Connect the yubikey and confirm its status.
```console
gpg --card-status
```

<details>

<summary>In case the yubikey says, its locked:</summary>

**The following step with delete all pgp keys stored on the yubikey!**

Reset with yubikey with help of ykman as described below.
```console
ykman openpgp reset
```
</details>

## Change PIN
The yubikey pgp interface has its own PINs seperated from other modules such as [FIDO2](https://www.yubico.com/authentication-standards/fido2/) or [PIV](https://www.yubico.com/authentication-standards/smart-card/):

Name | Default | Capability
:---: | :---: | ---
User PIN | `123456` | Cryptographic operations (decrypt, sign, authenticate)
Admin PIN | `12345678` | Reset PIN, Change reset code, add keys and owner information
Reset Code | None | Reset PIN ([more information](https://forum.yubico.com/viewtopicd01c.html?p=9055#p9055))

Determine the desired PIN values. They can be shorter than the Certify key passphrase due to limited brute-forcing opportunities; the User PIN should be convenient enough to remember for every-day use.
The User PIN must be at least 6 characters and the Admin PIN must be at least 8 characters.

Prepare PIN values for `ADMIN` and `USER`
```console
export ADMIN_PIN=12345678
export USER_PIN=123456
printf "\nAdmin PIN: %12s\nUser PIN: %13s\n\n" \
    "$ADMIN_PIN" "$USER_PIN"
```

Change the `USER` pin by running the following
```console
gpg --command-fd=0 --pinentry-mode=loopback --change-pin <<EOF
3
12345678
$ADMIN_PIN
$ADMIN_PIN
q
EOF
```
and the `ADMIN` pin
```console
gpg --command-fd=0 --pinentry-mode=loopback --change-pin <<EOF
1
123456
$USER_PIN
$USER_PIN
q
EOF
```

Remove and re-insert the yubikey from the usb port its plugged into.

> [!WARNING]
> Three incorrect User PIN entries will cause it to become blocked and must be unblocked with either the Admin PIN or Reset Code. This will destroy any pgp data on the yubikey.

## Use variables
Use the previously set values in the gpg key creation process.
```console
gpg --command-fd=0 --pinentry-mode=loopback --edit-card <<EOF
admin
login
$IDENTITY
$ADMIN_PIN
quit
EOF
```

## Transfer subkeys
> [!CAUTION]
> Transferring keys to yubikey converts the on-disk key into a "stub" - making it no longer usable to transfer to other yubikeys. Ensure keys were backed up before proceeding.

**Required:** Certify key passphrase and Admin PIN.

In this step the following keys will be transfered to the yubikey.
### Signature key
```console
gpg --command-fd=0 --pinentry-mode=loopback --edit-key $KEYID <<EOF
key 1
keytocard
1
$CERTIFY_PASS
$ADMIN_PIN
save
EOF
```
### Encryption key
```console
gpg --command-fd=0 --pinentry-mode=loopback --edit-key $KEYID <<EOF
key 2
keytocard
2
$CERTIFY_PASS
$ADMIN_PIN
save
EOF
```
### Authentication key
```console
gpg --command-fd=0 --pinentry-mode=loopback --edit-key $KEYID <<EOF
key 3
keytocard
3
$CERTIFY_PASS
$ADMIN_PIN
save
EOF
```

## Verify transfer
Verify that the subkeys have been successfully transfered to the yubikey.
Run `gpg -K` – indicated by `ssb>` The `>` after a tag indicates the key is stored on a smart card.

```console
sec   rsa4096/0xF0F2CFEB04341FB5 2025-01-01 [C]
      Key fingerprint = 4E2C 1FA3 372C BA96 A06A  C34A F0F2 CFEB 0434 1FB5
uid                   [ultimate] Surname, Forname <email@domain.com>
ssb>  rsa4096/0xB3CD10E502E19637 2025-01-01 [S] [expires: 2027-05-01]
ssb>  rsa4096/0x30CBE8C4B085B9F7 2025-01-01 [E] [expires: 2027-05-01]
ssb>  rsa4096/0xAD9E24E1B8CB9600 2025-01-01 [A] [expires: 2027-05-01]
```

# Interim check
Verify the following steps were performed correctly:
- [ ] Memorized or wrote down the Certify key passphrase to a secure and durable location
  - `echo $CERTIFY_PASS` to see it again;
- [ ] Saved the Certify key and Subkeys to encrypted portable storage, to be kept offline
  - At least two backups are commended, stored at seperate locations and different types of media
- [ ] Exported a copy of the public key, where it is easily accessible
  - Seperate devices, non-encrypted storage or even github
- [ ] Memorized or wrote down the `USER` and `ADMIN` PINS, which are unique and got changed from default values
  - `echo $USER_PIN $ADMIN_PIN` to see them again;
- [ ] Moved Encryption, Signature and Authentication subkeys to yubikey
  - `gpg -K` followed by `ssb>` shows for each of the three subkeys;

Restart the shell for a clean environment, to complete the setup.

# Loading keys on other systems
Here are steps provided, for importing the keys from the yubikeys, on other systems or after resetting the system/gpg.

Import the public key with the desired method.
```console
gpg --recv $KEYID # Import from public key server
gpg --import ~/secrets/public.asc
```

Fetch the keys to GnuPG using `gpg-card`.
```console
gpg/card> fetch
gpg/card> quit
```

Get the key ID and exporting it by running the following command.
```console
gpg -k # Copy the key ID and export it, as described below.
export KEYID=0xF0F2CFEB04341FB5
```

Assign ultimate trust to the imported key.
```console
gpg --command-fd=0 --pinentry-mode=loopback --edit-key $KEYID <<EOF
trust
5
y
save
EOF
```

Remove and re-insert the yubikey.
Verify the status with `gpg --card-status` which will list the available subkeys.
```console
Reader ...........: Yubico YubiKey OTP FIDO CCID 00 00
Application ID ...: D2760001240102010006055532110000
Application type .: OpenPGP
Version ..........: 3.4
Manufacturer .....: Yubico
Serial number ....: 05553211
Name of cardholder: YubiKey User
Language prefs ...: en
Salutation .......:
URL of public key : [not set]
Login data .......: yubikey@example
Signature PIN ....: not forced
Key attributes ...: rsa4096 rsa4096 rsa4096
Max. PIN lengths .: 127 127 127
PIN retry counter : 3 3 3
Signature counter : 0
KDF setting ......: on
Signature key ....: CF5A 305B 808B 7A0F 230D  A064 B3CD 10E5 02E1 9637
      created ....: 2025-01-01 12:00:00
Encryption key....: A5FA A005 5BED 4DC9 889D  38BC 30CB E8C4 B085 B9F7
      created ....: 2025-01-01 12:00:00
Authentication key: 570E 1355 6D01 4C04 8B6D  E2A3 AD9E 24E1 B8CB 9600
      created ....: 2025-01-01 12:00:00
General key info..: sub  rsa4096/0xB3CD10E502E19637 2025-01-01 YubiKey User <yubikey@example>
sec#  rsa4096/0xF0F2CFEB04341FB5  created: 2025-01-01  expires: never
ssb>  rsa4096/0xB3CD10E502E19637  created: 2025-01-01  expires: 2027-05-01
                                  card-no: 0006 05553211
ssb>  rsa4096/0x30CBE8C4B085B9F7  created: 2025-01-01  expires: 2027-05-01
                                  card-no: 0006 05553211
ssb>  rsa4096/0xAD9E24E1B8CB9600  created: 2025-01-01  expires: 2027-05-01
                                  card-no: 0006 05553211
```
The `sec#` attribute, indicates that the corresponding key is not available (Certify key is offline).
The yubikey is now ready for use!

# Sources
- https://github.com/drduh/YubiKey-Guide/tree/master
  - This guide is heavily inspired by @drduh. Big thanks for his extensive guide.