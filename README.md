# Rust Aarhus Turtle Bot

This repo contains the basic setup for the Kobuki turtle bot. This demo needs a USB connection from your computer to the turtle bot. Currently, this has only been tested on Linux.
To give the turtle bot a known device file, you will need to add the following udev rule to your host system.

`/etc/udev/rules.d/60-kobuki.rules`:
```bash
# On precise, for some reason, USER and GROUP are getting ignored.
# So setting mode = 0666 for now.
SUBSYSTEM=="tty", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", ATTRS{serial}=="kobuki*", ATTR{device/latency_timer}="1", MODE:="0666", GROUP:="dialout", SYMLINK+="kobuki"
# Bluetooth module (currently not supported and may have problems)
# SUBSYSTEM=="tty", ATTRS{address}=="00:00:00:41:48:22", MODE:="0666", GROUP:="dialout", SYMLINK+="kobuki"
```

## Building the application

To build the demo application that allows you to control the bot, you need to run the build script, which after a while and lots of output simply should say "Success".

```bash
./build.sh
```

## Running the demo application

To run the demo application, you should power on the bot, and connect it to your computer via USB. When connected, check that you have the device file `/dev/kobuki`. If not, check if your udev rules are correct and matches your OS.

If everything looks correct, run the application:

```bash
run-kobuki-simple-keyop.sh
```

Now, you should hear the bot plays a few sounds, and you can use the arrow keys on your computer to control the bot. Notice that you can use `space` to stop the bot before it runs away from you.

## Links
 - [ROS Humble Hawksbill](https://docs.ros.org/en/humble/)
 - [Kobuki udev rules](https://raw.githubusercontent.com/kobuki-base/kobuki_ftdi/devel/60-kobuki.rules)