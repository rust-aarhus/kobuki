# This is based on information from the following source:
# https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debs.html
#
FROM ubuntu:jammy

# Use bash instead of sh - this is required for the source command
# SHELL ["/bin/bash", "-c"]

# Set locale
RUN apt-get update && apt-get install -y \
    locales \
    && locale-gen en_US en_US.UTF-8 \
    && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

ENV LANG en_US.UTF-8

# Setup Sources
## First ensure that the Ubuntu Universe repository is enabled.
RUN apt-get install -y software-properties-common \
    && add-apt-repository universe

## Now add the ROS 2 GPG key with apt.
RUN apt-get update \
    && apt-get install -y curl \
    && curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

## Then add the repository to your sources list.
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Install ROS 2 packages
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ros-humble-ros-base \
    ros-dev-tools \
    && rosdep init \
    && rosdep update

#
# The following is based on the Capra documentation
#
RUN apt-get install -y \
    ros-humble-kobuki-ros-interfaces \
    ros-humble-kobuki-velocity-smoother \
    ros-humble-sophus
