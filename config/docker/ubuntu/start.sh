#!/bin/bash
source ~/.bashrc

# Configura o layout de teclado brasileiro ABNT2
setxkbmap -model abnt2 -layout br

# Inicia o servidor VNC
touch ~/.Xauthority

# Start the VNC server
Xvfb $DISPLAY -screen 0 1920x1080x24 +extension GLX +render -noreset &
x11vnc -display "$DISPLAY" -bg -xkb -capslock -shared -forever -noxdamage
startxfce4 &
#tightvncserver $DISPLAY -geometry 1920x1080 -depth 24

# Inicia o noVNC
$SEER_DIR/Downloads/noVNC/utils/novnc_proxy --vnc localhost:5900 --listen 6080

# Keep the script running
tail -f /dev/null