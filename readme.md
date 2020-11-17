## Hardaware installation

- Follow [duet's guide](https://duet3d.dozuki.com/Wiki/Getting_Started_With_Duet_3)
- Install [firmwares releases of your choice](https://github.com/Duet3D/RepRapFirmware/releases/tag/3.1.1)
- Copy duet web control to SD card /www folder
- ! keep names, or it won't work

## Uploading fw

### Good old way

The part with the PI is working for any linux computer. [link](https://duet3d.dozuki.com/Wiki/Getting_Started_With_Duet_3).

### From the web interface

Umpload file named correctly.

## Install & Compile sources

- Clone this repo
- git submodule init
- git submodule update
- Follow [official build instructions](https://github.com/Duet3D/RepRapFirmware/blob/dev/BuildInstructions.md). You can skip the step where you have to clone all repositories.
- git checkout 3.1.0 or stable version when possible/
- We are building for Duet 6HC, which have an Atmel ATSAME70 proc. One should use SEMAE70 build configuration. Dev branch is working. Since we will use CAN network, it seems we need to use RTOS when possible. Meaning the correct compilation configuration is SAME70_RTOS

## Fw Configuration

- [use this tool](https://configtool.reprapfirmware.org/)
- Or copy what you'll find in config/sys to your sd card

## TODO

- Mettre un oscillo sur les entrées SSR.

### Calibration

- Full procedure [here](https://duet3d.dozuki.com/Wiki/Calibrating_a_delta_printer).
- Test calibration sensor with (full description [here](https://duet3d.dozuki.com/Wiki/Test_and_calibrate_the_Z_probe))




### Test fans

- Sliders on web interface
- `M106 P<fan number> S<0.0->1.0>`


### Debug model

- Delta radius = 109 : 30cm au centre, 31.5 à Y=100
- Delta radius = 300 : 30cm au centre, 34 à Y=80

