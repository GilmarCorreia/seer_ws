FROM ros:humble-ros-base

    # Install packages
    RUN apt-get update && apt-get install -y --no-install-recommends \
        ros-humble-desktop \
        ros-humble-xacro \
        ros-humble-robot-state-publisher \
        ros-humble-joint-state-publisher-gui \
        ros-humble-ros2-control \
        ros-humble-ros2-controllers \
        git \
        python3-colcon-common-extensions \
        python3-setuptools && \
        apt-get clean

    WORKDIR /home/sim

    COPY config/docker/ubuntu/03_configuring_workspace.sh scripts/03_configuring_workspace.sh
    RUN sudo bash scripts/03_configuring_workspace.sh