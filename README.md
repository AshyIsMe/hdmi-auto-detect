# hdmi auto detect udev rules and scripts

i3wm doesn't do this automatically.

## Install

    $ sudo install.sh

This will do the following:

1. Copy 90-hdmi.rules to /etc/udev/rules.d/
1. Copy hdmi-switch.sh to /etc/acpi/
1. udevadm control --reload-rules
