#!/bin/bash
set -e

wget https://app.warp.dev/download?package=deb -O warp.deb
sudo apt install -y ./warp.deb
rm warp.deb
