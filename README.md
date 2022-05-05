# x11vnc

Script to install and setup x11vnc as a system unit.

## Overview

- This script installs x11vnc and its dependencies, it assumes the package is available in your repositories (Tested with Fedora 34 and 35). Then, a password must be specified and stored under the default location (~/.vnc/passwd)

- The service unit is created within the user scope (stored under ~/.local/share/systemd/user)
- Finally, systemd daemon is reloaded and the service unit enabled.

## Installation instructions
1. - Download/clone this repository
2. - Grant execution permissions to the script: chmod +x X11VNC.sh
3. - Run the script: ./X11VNC.sh



## Notes

The script configures X11VNC to foward the phyisical screen #0, this is normally the case if the GDM isn't displayed (Automatic login), otherwise, the screen is normally #1, this can be checked locally in the machine by typing echo $DISPLAY.

