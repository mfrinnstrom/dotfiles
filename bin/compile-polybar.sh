#!/bin/bash
echo "Installing build dependencies..."
sudo apt install cmake cmake-data pkg-config libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev python-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev

echo "Installing optional build dependencies..."
sudo apt install libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libnl-3-dev libxcb-composite0-dev

echo "Cloning and building polybar..."
git clone --recursive https://github.com/jaagr/polybar
mkdir polybar/build
cd polybar/build
cmake ..
sudo make install

echo "Removing polybar folder..."
cd ../..
rm -rf polybar

echo "Done"

