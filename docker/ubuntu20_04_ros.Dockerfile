# FROM ubuntu:20.04
# https://hub.docker.com/r/nvidia/cudagl
FROM nvidia/cudagl:11.4.2-runtime-ubuntu20.04
LABEL maintainer="esther"

# So that it doesn't hang waiting on user inputs, e.g. tzdata
ENV DEBIAN_FRONTEND=noninteractive

# Install basic useful stuff
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        autoconf \
        lsb-core \
        keyboard-configuration \
        ca-certificates \
        dpkg-dev \
        gcc \
        g++ \
        gnupg \
        libncurses5-dev \
        make \
        wget \ 
        tmux \
        gdb \
        curl \
        vim \
        cmake \
        sudo \
        git \
        python3.8 \
        python3-pip \
        ipython3 \
        python3-serial \
    && rm -rf /var/lib/apt/lists/*

# Install useful libraries from package
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       libeigen3-dev \
       libboost-all-dev \
       libopencv-dev \
       python3-opencv \
    && rm -rf /var/lib/apt/lists/*

# TODO(esther): Install useful libraries from source
# gtsam - latest release is 4.1.1 (Dec 2021)
# jsoncpp
# threading library

# WORKDIR /usr/src
# RUN git clone https://github.com/borglab/gtsam.git \
#   && cd gtsam \
#   && git checkout 4.1.1 \
#   && mkdir build \
#   && cd build \
#   && cmake .. \
#   && make install -j{nproc} \
#   && rm -rf /usr/src/gtsam

# Setup a persistent volume within the container that we can mount to.
VOLUME /workspace

# Setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Install ROS - specify distribution here
ENV ROS_DISTRO noetic

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
 && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

RUN apt-get update \
   && apt install -y ros-${ROS_DISTRO}-desktop-full \
      python3-rosinstall \ 
      python3-rosinstall-generator \
      python3-wstool \
      build-essential \
      python3-rosdep \
      python3-catkin-tools \
      ros-${ROS_DISTRO}-serial \
      ros-${ROS_DISTRO}-geographic-msgs \
      ros-${ROS_DISTRO}-ros-control \ 
      ros-${ROS_DISTRO}-ros-controllers \
      ros-${ROS_DISTRO}-moveit \
      ros-${ROS_DISTRO}-gazebo-ros-pkgs \ 
      ros-${ROS_DISTRO}-gazebo-ros-control \
   && rm -rf /var/lib/apt/lists/*

RUN rosdep init \ 
  && rosdep update \
  && echo source "/opt/ros/$ROS_DISTRO/setup.bash"  >> ~/.bashrc

ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

# Below isn't needed since we can echo into ~/.bashrc
# Setup entrypoint
# COPY ./ros_entrypoint.sh /
# RUN chmod +x /ros_entrypoint.sh
# ENTRYPOINT ["/ros_entrypoint.sh"]
# CMD ["bash"]
