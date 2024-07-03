# VICE Docker

The repository contains Dockerfile for building and running VICE ([Versatile Commodore Emulator](https://vice-emu.sourceforge.io/)).

The Docker image is based on:

- Ubuntu 20.04LTS
- VICE 3.8

For any changes to the Dockerfile refer to the VICE [Linux build instructions](https://sourceforge.net/p/vice-emu/code/HEAD/tree/tags/v3.8/vice/doc/building/Linux-GTK3-Howto.txt).

## Getting started

Build the image

```shell
docker build -t vice:3.8 .
```

Run the emulator(s) with wrapper scripts

```shell
# the SID player
bin/vsid <options...>
# the accurate C64 emulator
bin/x64sc <options...>
# the C64DTV emulator
bin/x64dtv <options...>
# the C128 emulator
bin/x128 <options...>
# the VIC20 emulator
bin/xvic
# the PET emulator
bin/xpet
# the PLUS4 emulator
bin/xplus4
# the CBM-II emulator (CRTC models)
bin/xcbm2
# the CBM-II emulator (VIC-II models)
bin/xcbm5x0
# the SCPU64 emulator
bin/xscpu64
```

The wrapper scripts support the following environment variables

| Environment | Description                                                                |
| :---------- | :------------------------------------------------------------------------- |
| `VICE_CWD`  | mount the local directory and set VICE working directory option (`-chdir`) |
| `VICE_CFG`  | mount the config file in users home directory `/root/.vicerc`              |

For available command line options and other documentation please refer to VICE [manual](https://vice-emu.sourceforge.io/vice_toc.html).

### Example: Autostart a program from local filesystem with custom configuration

Create a VICE configuration file `.vicerc`. For more information see VICE [manual](https://vice-emu.sourceforge.io/vice_5.html).

The following file will run VICE at 200% CPU clock speed and set the autostart mode for `prg` files as inject to RAM.

```ini
[Version]
ConfigVersion=3.8

[C64SC]
Speed=200
AutostartPrgMode=1
```

Run the C64 emulator and autostart a prg program.

```shell
VICE_CFG=<path_to_vicerv> VICE_CWD=<dir_containing_prg> bin/x64sc -autostart <prg_filename>
```
