FROM ros:humble-ros-base

    # Installing gazebo
    RUN apt-get update && apt-get install -y --no-install-recommends \
        ros-humble-ros-gz* \ 
        ros-humble-gz* \ 
        mesa-utils \ 
        mesa-vulkan-drivers \
        libgl1-mesa-dri \
        #ros-humble-gz-ros2-control para o JAZZY 
        && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*

    WORKDIR /home/seer
    
    COPY config/docker/ubuntu/02_configuring_gazebo.sh scripts/02_configuring_gazebo.sh
    RUN bash scripts/02_configuring_gazebo.sh