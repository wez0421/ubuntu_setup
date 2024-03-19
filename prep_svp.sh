#!/bin/bash

sudo apt-get update
sudo apt-get install g++
sudo apt-get update -y
sudo apt-get install -y intel-opencl-icd #intel driver
sudo apt-get install mediainfo -y
sudo apt-get install libqt5concurrent5 libqt5svg5 libqt5qml5 -y
sudo add-apt-repository ppa:rvm/smplayer
sudo apt-get update
sudo apt-get install smplayer smplayer-themes smplayer-skins -y
sudo apt-get install g++ make autoconf automake libtool pkg-config mediainfo nasm git ffmpeg -y
# Update package lists
sudo apt update
sudo apt-get install libqt5concurrent5 libqt5svg5 libqt5qml5 -y
# common build tools
sudo apt-get install g++ make autoconf automake libtool pkg-config nasm git -y

# zimg library
git clone --branch release-3.0.5 https://github.com/sekrit-twc/zimg.git
cd zimg   
./autogen.sh
./configure
make -j4
sudo make install

cd ..

# Cython for Python3. !!! Vapoursynth requires Cython >= 0.28 !!!
sudo apt-get install cython3 -y
# OR
pip3 install Cython -y
#setup cython
sudo apt install python3-pip -y
pip3 install cython
sudo echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
echo $PATH
# build Vapoursynth
git clone --branch R59 https://github.com/vapoursynth/vapoursynth.git
cd vapoursynth
./autogen.sh
./configure
make -j4
sudo make install
cd ..

sudo ldconfig

# make Python find the Vapoursynth module
# replace "python3.10" with the actual version you have
sudo ln -s /usr/local/lib/python3.10/site-packages/vapoursynth.so /usr/lib/python3.10/lib-dynload/vapoursynth.so

# ensure everything is fine so far - run vspipe
vspipe
sudo apt-get install libssl-dev libfribidi-dev libharfbuzz-dev libluajit-5.1-dev libx264-dev xorg-dev libxpresent-dev libegl1-mesa-dev libfreetype-dev libfontconfig-dev libffmpeg-nvenc-dev libva-dev libdrm-dev libplacebo-dev -y
sudo apt-get install libasound2-dev libpulse-dev -y
sudo apt-get install python-is-python3 -y
pip install meson
pip install ninja
#root pip install meson 
original_user=$(whoami)
sudo -s <<EOF
pip install meson
pip install ninja
EOF
echo "Resuming back to Original User: $original_user"
git clone https://github.com/mpv-player/mpv-build.git
cd mpv-build
./use-ffmpeg-release
./update
echo --enable-libx264 >> ffmpeg_options
echo --enable-vaapi >> ffmpeg_options
echo -Dvapoursynth=enabled >> mpv_options
echo -Dlibmpv=true >> mpv_options
#echo --enable-nvdec >> ffmpeg_options
./rebuild -j4
