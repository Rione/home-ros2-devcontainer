FROM ubuntu:22.04

# TODO Add GPU version

ARG USERNAME=ri-one
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Set timezone to ensure when package installation
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# Create default user
# https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    sudo && \
    groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m -s /bin/bash -G adm,sudo $USERNAME && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

# Install ROS 2
# https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debians.html
# Install dependant packages for setup script
RUN sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends \
    locales \
    git \
    ca-certificates \
    lsb-release

# Fix locale to UTF-8
RUN sudo locale-gen en_US en_US.UTF-8 && \
    sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8

# Get setup script
RUN git clone https://github.com/Rione/home_ros2_setup \
    /tmp/ros2_setup

# Pin version and run setup script
WORKDIR /tmp/ros2_setup
RUN git checkout 7f1e02f
RUN DEBIAN_FRONTEND=noninteractive ./setup.bash

WORKDIR /home/$USERNAME
