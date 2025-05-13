FROM ros:humble-ros-base AS base_image

    ENV DEBIAN_FRONTEND=noninteractive

    RUN apt-get update && apt-get install -y --no-install-recommends \
        xfce4 \
        xfce4-terminal \
        xfce4-panel \
        xfce4-session \
        xinit \
        xfce4-goodies \
        xubuntu-desktop \
        x11vnc \
        x11-utils \
        dbus-x11 \
        libgl1-mesa-glx \
        libxext6 \
        libx11-dev \
        mesa-utils \
        xterm \ 
        x11-apps \
        xvfb \
        htop \
        nano \
        gedit && \
        apt-get clean

    RUN apt-get update && apt-get install -y --no-install-recommends \
        wget \
        tar \
        xz-utils \
        software-properties-common \
        python3.10 \
        python3-pip \
        ros-humble-gazebo* \
        ros-humble-desktop \
        ros-humble-xacro \
        ros-humble-robot-state-publisher \
        ros-humble-joint-state-publisher-gui \
        ros-humble-ros2-control \
        ros-humble-ros2-controllers \
        git \
        python3-colcon-common-extensions \
        python3-setuptools \
        xsltproc && \
        apt-get clean

    RUN useradd -ms /bin/bash ubuntu
    RUN echo 'ubuntu:ubuntu' | chpasswd
    RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

FROM base_image
    USER ubuntu
    WORKDIR /home/ubuntu/sim

    ENV SIM_DIR=/home/ubuntu/sim
    ENV SIM_WS_DIR=/home/ubuntu/sim/sim_ws

    COPY config/docker/ubuntu/sim.sh sim.sh

    COPY config/docker/ubuntu/01_configuring_coppeliasim.sh scripts/01_configuring_coppeliasim.sh
    RUN bash scripts/01_configuring_coppeliasim.sh

    COPY config/docker/ubuntu/02_configuring_gazebo.sh scripts/02_configuring_gazebo.sh
    RUN bash scripts/02_configuring_gazebo.sh

    COPY config/docker/ubuntu/03_configuring_workspace.sh scripts/03_configuring_workspace.sh
    RUN bash scripts/03_configuring_workspace.sh

    # Instala o noVNC e o websockify
    RUN git clone https://github.com/novnc/noVNC $SIM_DIR/Downloads/noVNC && \
    cd $SIM_DIR/Downloads/noVNC && \
    git checkout v1.5.0 && \
    wget https://github.com/novnc/websockify/archive/refs/tags/v0.12.0.tar.gz && \
    tar -xvf v0.12.0.tar.gz && \
    mv websockify-0.12.0 $SIM_DIR/Downloads/noVNC/websockify && \
    rm v0.12.0.tar.gz

    # # Configura o VNC e noVNC
    # RUN mkdir -p /root/.vnc && \
    # echo "" | vncpasswd -f > /root/.vnc/passwd && \
    # chmod 600 /root/.vnc/passwd

    # Expõe as portas necessárias
    EXPOSE 5900 6080

    # Adiciona script de inicialização
    COPY config/docker/ubuntu/start.sh $SIM_DIR/start.sh
    RUN sudo chmod +x $SIM_DIR/start.sh

    # Define o comando para iniciar o VNC e noVNC
    CMD ["/home/ubuntu/sim/start.sh"]