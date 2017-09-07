#/bin/bash

# Install/Setup Dependencies for a 24/7 music live strem pi

# Taken from: https://www.reddit.com/r/raspberry_pi/comments/61ntji/247_youtube_music_live_stream_and_how_you_can/

# Update our package list
sudo apt-get update

# Install our packages
sudo apt-get install -y nano bzip2 mpg123 htop git \
gifsicle libid3-tools \
autoconf automake build-essential libass-dev \
libfreetype6-dev libtheora-dev libtool libvorbis-dev \
pkg-config texinfo zlib1g-dev libgnutls28-dev \
librtmp-dev libssl-dev libx264-dev libasound2-dev

# Install an audio decoder
wget http://ftp.us.debian.org/debian/pool/non-free/f/fdk-aac/libfdk-aac-dev_0.1.3+20140816-2_armhf.deb
wget http://ftp.us.debian.org/debian/pool/non-free/f/fdk-aac/libfdk-aac0_0.1.3+20140816-2_armhf.deb

# Install our audio decoders
sudo dpkg -i libfdk-aac0_0.1.3+20140816-2_armhf.deb
sudo dpkg -i libfdk-aac-dev_0.1.3+20140816-2_armhf.deb

# Do the FFmpeg *.so fix
cat configFiles/ld.so.conf | sudo tee -a /etc/ld.so.conf
sudo ldconfig

# Copy over our required .asoundrc
cp configFiles/asoundrc ~/.asoundrc

# Should be finished
export PATH=$(pwd)/deps/ffmpeg/bin/ffmpeg:$PATH
ffmpeg

echo "Finished!"
