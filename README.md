# Headless Plexamp Image Builder

This repo contains routines to extend the base pi-gen system to build a custom Raspberry Pi OS image that contains [a headless Plexamp implementation](https://forums.plex.tv/t/future-of-plexamp-on-raspberry-pi/717577/161). Once configured you will be able to use a Pi as a Plexamp player that you can control remotely. This feature is similar to Spotify or Tidal Connect.

You can either build the image yourself or simply download a prebuilt image from the releases page.

## Requirements

As required by the Plexamp software, this is a 64bit image so you must be using a Pi 3 B+ or newer system. You will also need some kind of dac attached to the Pi. As mentioned in the announcement blog post, you can use this https://www.aliexpress.com/item/4001260534656.html or https://www.amazon.com/gp/product/B07VSFBT82/. The second link will require an adapter.

## Using

Simply download the latest image from the release page and copy it to an SD card in the usual way (detailed information is available at [https://www.raspberrypi.org/documentation/computers/getting-started.html#installing-the-operating-system](https://www.raspberrypi.org/documentation/computers/getting-started.html#installing-the-operating-system)). 

Once the image is copied to an SD card put it into your Raspberry Pi 3b+ or better and connect it to power and ethernet (WiFi works too if you pre-configured it using the headless configuration option). After some time the Pi will be online and ready to use. 

### SSH Access

Unlike a normal Raspberry Pi OS system, SSH is enabled by default. You can access the console of your Pi using an ssh client. Connect as `pi` to `plexamp.local` and login with `plexamp`. You can now manage your system just like you normally would. This currently the only method modifying the configuration of most services.

### Initial Configuration

There is some work you will need to perform manually to finish the setup. Once you have copied the image to an SD card insert it into the Pi and start it up. Allow the system some time to resize the file system. Once it is ready you can ssh into the Pi as mentioned above. Once in, run:

`node plexamp/js/index`

You will be prompted to follow a link and enter a claim code. Click or open the link in your browser, login into the site and get your claim code. Once you have it, paste it into the terminal and press enter. Wait for a bit to allow Plexamp to finish initializing. Once it appears finished go ahead and stop Plexamp by issuing `ctrl c`. It may take a couple of attempts to make it quit.

Next, issue `sudo systemctl enable plexamp` and finally `sudo reboot`. Once it has rebooted you can access its web interface for a final login into your Plex account. Visit https://plexamp.local:32500 to complete the setup.


## Building

To use this project you must first install pi-gen, available at [https://github.com/RPi-Distro/pi-gen](https://github.com/RPi-Distro/pi-gen). Start by setting up pi-gen as described and ensure you are able to successfully build the base image. Once complete, clone this repository into where you cloned the pi-gen repository as "stage-plexamp" (`git clone https://github.com/dustinrue/headless-plexamp.git stage-plexamp`). Then, create a config file with the following in it:

```
IMG_NAME=plexamp
DEPLOY_ZIP=0
TARGET_HOSTNAME=plexamp
KEYBOARD_KEYMAP=us
KEYBOARD_LAYOUT="English (US)"
FIRST_USER_PASS=plexamp
ENABLE_SSH=1
STAGE_LIST="stage0 stage1 stage2 stage-plexamp"
```

You can modify any option you want but you must include stage-plexamp as a step, probably the last one.

