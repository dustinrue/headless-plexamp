#!/bin/bash -e

cd /home/pi
wget --no-verbose https://plexamp.plex.tv/headless/Plexamp-Linux-arm64-v4.2.2-beta.1c.tar.bz2 -O - | bunzip2 | tar xvf -
chown pi:pi -R plexamp
curl -fsSL https://deb.nodesource.com/setup_12.x | bash -
apt-get install -y nodejs
