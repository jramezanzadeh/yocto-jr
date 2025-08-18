# yocto-jr
 **A Yocto Project helper**

Using **kas**, this repository provides configuration metadata to aid building yocto images for different boards.

It uses the distro, images and machines defined in **[meta-jr](https://github.com/jramezanzadeh/meta-jr)** and **[meta-bsp-jr](https://github.com/jramezanzadeh/meta-bsp-jr)** layers.


**Getting Started**
---
* Install required packages (needs to be done once)

``` bash
poetry install
```
* Build the image

``` bash
poetry run kas shell kas/your_machine_configuration.yaml
bitbake jr-image-graphic
```

* Flash the built image into sd card
``` bash
#first determine the device file of your sd card
ls /dev/sd*
#change sdx to the dev file of your sd card
./flash-sd.sh sdx jr-image-graphic
```
