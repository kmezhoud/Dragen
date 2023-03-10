
# Extract files from `.run` installer

<!--

<a href="https://github.com/kmezhoud/Dragen/extract_installer/extract_installer.md" target = "_blank">
<img src="../doc/untar_Dragen.png" align="right" height="100" width="100" title="Parsing JSON nirvana Output">
</a>

&nbsp;

&nbsp;
-->

``` bash
wget https://webdata.illumina.com/downloads/software/dragen/dragen-4.0.3-8.el8.x86_64.run
# dragen-4.0.3-8.el8.x86_64.run
sh dragen-4.0.3-8.el8.x86_64.run –extract-only
```

```
Unrecognized flag : --extract-only
Makeself version 2.4.2
 1) Getting help or info about dragen-4.0.3-8.el8.x86_64.run :
  dragen-4.0.3-8.el8.x86_64.run --help   Print this message
  dragen-4.0.3-8.el8.x86_64.run --info   Print embedded info : title, default target directory, embedded script ...
  dragen-4.0.3-8.el8.x86_64.run --lsm    Print embedded lsm entry (or no LSM)
  dragen-4.0.3-8.el8.x86_64.run --list   Print the list of files in the archive
  dragen-4.0.3-8.el8.x86_64.run --check  Checks integrity of the archive

 2) Running dragen-4.0.3-8.el8.x86_64.run :
  dragen-4.0.3-8.el8.x86_64.run [options] [--] [additional arguments to embedded script]
  with following options (in that order)
  --confirm             Ask before running embedded script
  --quiet               Do not print anything except error messages
  --accept              Accept the license
  --noexec              Do not run embedded script (implies --noexec-cleanup)
  --noexec-cleanup      Do not run embedded cleanup script
  --keep                Do not erase target directory after running
                        the embedded script
  --noprogress          Do not show the progress during the decompression
  --nox11               Do not spawn an xterm
  --nochown             Do not give the target folder to the current user
  --chown               Give the target folder to the current user recursively
  --nodiskspace         Do not check for available disk space
  --target dir          Extract directly to a target directory (absolute or relative)
                        This directory may undergo recursive chown (see --nochown).
  --tar arg1 [arg2 ...] Access the contents of the archive through the tar command
  --ssl-pass-src src    Use the given src as the source of password to decrypt the data
                        using OpenSSL. See "PASS PHRASE ARGUMENTS" in man openssl.
                        Default is to prompt the user to enter decryption password
                        on the current terminal.
  --cleanup-args args   Arguments to the cleanup script. Wrap in quotes to provide
                        multiple arguments.
  --                    Following arguments will be passed to the embedded script
```

To extract the file we can:

``` bash
sh  dragen-4.0.3-8.el7.x86_64.run --noexec --target Dragen.run
# or
chmod +x dragen-4.0.3-8.el8.x86_64.run
./dragen-4.0.3-8.el8.x86_64.run --target dragen.run
```

    Creating directory dragen.run
    Verifying archive integrity...  100%   MD5 checksums are OK. All good.
    Uncompressing dragen self-extracting installer version 4.0.3  100%  
    Beginning installation of dragen-4.0.3-8.el8.x86_64.run
    No arguments were passed
    Starting preflight check.
    In pre_flight_check(), error:
    This program must be run as root.

``` bash
ls dragen.run
```

    edico-4.0.3-15.el8.x86_64.rpm  edico_driver-1.4.7-4.0.3.el8.x86_64.rpm  installer

``` bash
cat dragen.run/installer | grep ^MY_REQUIREMENTS
```

    MY_REQUIREMENTS="R bc bzip2-libs coreutils curl dkms findutils gawk gdb kernel-devel kernel-headers perl rsync sed smartmontools sos systemd-libs time yum-utils"
