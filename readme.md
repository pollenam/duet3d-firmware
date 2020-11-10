## Hardaware installation

- Follow [duet's guide](https://duet3d.dozuki.com/Wiki/Getting_Started_With_Duet_3)
- Install [firmwares releases of your choice](https://github.com/Duet3D/RepRapFirmware/releases/tag/3.1.1)
- Copy duet web control to SD card /www folder
- ! keep names, or it won't work


## Uploading fw

### Good old way

The part with the PI is working for any linux computer. [link](https://duet3d.dozuki.com/Wiki/Getting_Started_With_Duet_3).

### From the web interface



## Install & Compile sources

- Clone this repo
- git submodule init
- git submodule update
- Follow [official build instructions](https://github.com/Duet3D/RepRapFirmware/blob/dev/BuildInstructions.md). You can skip the step where you have to clone all repositories.
- git checkout 3.1.0 or stable version when possible/
- We are building for Duet 6HC, which have an Atmel ATSAME70 proc. One should use SEMAE70 build configuration. Dev branch is working. Since we will use CAN network, it seems we need to use RTOS when possible. Meaning the correct compilation configuration is SAME70_RTOS

## Fw Configuration

- [use this tool](https://configtool.reprapfirmware.org/)