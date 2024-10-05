#!/bin/bash

# Generate a self-signed SSL certificate for noVNC
if [ ! -f /home/ubuntu/novnc.pem ]; then
    openssl req -new -x509 -days 365 -nodes -out /home/ubuntu/novnc.pem -keyout /home/ubuntu/novnc.pem -subj "/CN=localhost"
    chown ubuntu:ubuntu /home/ubuntu/novnc.pem
fi

# Set VNC password
echo "ubuntu" | vncpasswd -f > /home/ubuntu/.vnc/passwd
chmod 600 /home/ubuntu/.vnc/passwd
chown -R ubuntu:ubuntu /home/ubuntu/.vnc

# Start the VNC server
sudo -u ubuntu vncserver :1 -geometry 1280x800 -depth 24 -dpi 96

# Keep the script running
tail -f /dev/null
