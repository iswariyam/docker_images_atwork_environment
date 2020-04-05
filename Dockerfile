FROM ros:melodic

ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}

ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

RUN apt update -qq \
    && sudo apt install -y -qq software-properties-common \
    && sudo apt install -y -qq curl figlet wget\
    && sudo apt install -y -qq vim \
    && sudo apt install -y -qq nmap

RUN sudo apt-get install python-rosdep \
    && sudo rm -rf /etc/ros/rosdep/sources.list.d/* \
    && sudo rosdep init -q \
    && rosdep update -q \
    && sudo apt install -y -qq python-rosinstall python-rosinstall-generator python-wstool build-essential python-catkin-tools python-pip \
    && sudo pip install catkin_pkg empy \
    && sudo rm -rf /var/lib/apt/lists/*

# RUN sudo sh -c "echo \"deb http://packages.ros.org/ros/ubuntu xenial main\" > /etc/apt/sources.list.d/ros-latest.list" \
#     && sudo curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | sudo apt-key add - \
#     && sudo apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE \
#     && sudo add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo xenial main" -u \
#     && sudo add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo xenial main" -u

ENV ROBOT=youbot-brsu-4
ENV ROBOT_ENV=brsu-c025

COPY install_script.sh /
RUN chmod +x /install_script.sh && /install_script.sh
ARG UNAME=melodic_user
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME \
    && adduser $UNAME sudo \
    && echo "$UNAME ALL=(ALL:ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$UNAME
USER $UNAME
