#!/bin/bash

# Set the clone path to the current directory's opencv folder
CLONE_PATH="$PWD/opencv"

# Check and create the opencv directory if it doesn't exist
if [ ! -d "$CLONE_PATH" ]; then
    mkdir -p "$CLONE_PATH"
    echo "Directory $CLONE_PATH created."
fi

# Update and upgrade the system
sudo apt update
sudo apt upgrade -y

# Install dependencies
sudo apt install -y build-essential cmake git pkg-config libgtk-3-dev \
    libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev \
    gfortran openexr libatlas-base-dev python3-dev python3-numpy \
    libtbb2 libtbb-dev libdc1394-22-dev

# Clone OpenCV and OpenCV contrib repositories
cd "$CLONE_PATH"
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git

# Create a build directory
cd "$CLONE_PATH/opencv"
if [ ! -d "build" ]; then
    mkdir build
fi
cd build

# Configure the build with CMake
cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D OPENCV_EXTRA_MODULES_PATH="$CLONE_PATH/opencv_contrib/modules" \
      -D ENABLE_PRECOMPILED_HEADERS=OFF \
      -D WITH_TBB=ON \
      -D WITH_V4L=ON \
      -D WITH_QT=OFF \
      -D WITH_OPENGL=ON \
      -D BUILD_EXAMPLES=ON ..

# Compile OpenCV
make -j$(nproc)

# Install OpenCV
sudo make install
sudo ldconfig

# Verify the installation
pkg-config --modversion opencv4
