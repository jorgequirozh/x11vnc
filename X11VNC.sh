#!/bin/bash
sudo yum install x11vnc -y
x11vnc -storepasswd
sudo firewall-cmd --permanent --add-port=5900/tcp
sudo firewall-cmd --reload
mkdir -p /home/$USER/.local/share/systemd/user
cd /home/$USER/.local/share/systemd/user
echo "Which display do you want to forward via VNC?"
echo "Current display: $DISPLAY (current display will not be shown if this is a remote session)"
echo "Use only numbers, or leave blank for default value: 0:"
read displayconfirmation
if [ -z "$displayconfirmation" ]; then
displayconfirmation="0"
fi
re='^[0-9]+$'
while ! [[ $displayconfirmation =~ $re ]] ; do
echo "Not a number!, try again or press enter to use the default value (0)"
read displayconfirmation
if [ -z "$displayconfirmation" ]; then
displayconfirmation="0"
fi
done
echo "Writing service unit file to /home/$USER/.local/share/systemd/user/x11vnc-custom.service"

echo -e "[Unit]\nDescription=X11VNC\n
[Service]\nRestart=on-failure\nExecStart=x11vnc -xkb -noxrecord -noxfixes -noxdamage -display :$displayconfirmation -auth guess -rfbauth /home/$USER/.vnc/passwd\nExecStop=pkill x11vnc\n\n[Install]\nWantedBy=default.target\n" > x11vnc-custom.service
sudo systemctl daemon-reload
systemctl --user enable x11vnc-custom.service
echo "Enabling system unit"
systemctl --user status x11vnc-custom.service
echo "Done!, restart the machine for the changes to take effect"
exit 0
