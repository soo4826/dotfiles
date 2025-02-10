# FROM ubuntu:focal
FROM ros:noetic-ros-core-focal

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    x11-apps \
    tmux \
    python3-vcstools \
    python3-rosdep \
    python3-rosinstall \
    python3-pip \
    zip \
    tmux \
    && rm -rf /var/lib/apt/lists/*

# install python package
RUN pip3 install opencv-python tqdm

# bootstrap rosdep
RUN rosdep init && \
  rosdep update --rosdistro $ROS_DISTRO

# install ros noetic full
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-noetic-desktop \
    ros-noetic-image-transport-plugins \
    && rm -rf /var/lib/apt/lists/*

# Add User
ARG HOST_UID
ARG HOST_GID
ARG HOST_USER
RUN groupadd -g $HOST_GID $HOST_USER && \
    useradd -rm -u $HOST_UID -g $HOST_USER -s /bin/bash $HOST_USER && \
    usermod -aG sudo $HOST_USER && \
    echo "$HOST_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${HOST_USER}
ENV TERM=xterm-256color

RUN echo "source /opt/ros/noetic/setup.bash" >> /home/$HOST_USER/.bashrc
