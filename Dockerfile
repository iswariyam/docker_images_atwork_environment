FROM ros:kinetic

RUN apt update -qq \
    && sudo apt-get install -y -qq software-properties-common \
    && sudo apt-get install -y -qq curl figlet

RUN sudo rm -rf /etc/ros/rosdep/sources.list.d/* \
    && sudo rosdep init -q \
    && sudo rosdep update -q \
    && sudo apt install -y -qq python-rosinstall python-rosinstall-generator python-wstool build-essential python-catkin-tools python-pip \
    && sudo pip install catkin_pkg empy \
    && sudo rm -rf /var/lib/apt/lists/*

COPY install_script.sh /
RUN chmod +x /install_script.sh && /install_script.sh