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
    WORKDIR /home/ubuntu/seer

    ENV SEER_DIR=/home/ubuntu/seer
    ENV SEER_WS_DIR=/home/ubuntu/seer/seer_ws

    COPY config/docker/ubuntu/seer.sh seer.sh

    COPY config/docker/ubuntu/01_configuring_coppeliasim.sh scripts/01_configuring_coppeliasim.sh
    RUN bash scripts/01_configuring_coppeliasim.sh

    COPY config/docker/ubuntu/02_configuring_gazebo.sh scripts/02_configuring_gazebo.sh
    RUN bash scripts/02_configuring_gazebo.sh

    # Importing SSH config
    RUN sudo apt-get install -y openssh-client
    RUN sudo mkdir -p /home/ubuntu/.ssh
    COPY config/docker/ubuntu/seer-ssh-key /home/ubuntu/.ssh/seer-ssh-key
    RUN sudo chmod -R 777 /home/ubuntu/.ssh
    RUN echo "Host github.com\n\tStrictHostKeyChecking no\n\tIdentityFile /home/ubuntu/.ssh/seer-ssh-key" >> /home/ubuntu/.ssh/config

    COPY config/docker/ubuntu/03_configuring_workspace.sh scripts/03_configuring_workspace.sh
    RUN bash scripts/03_configuring_workspace.sh

    # Instala o noVNC e o websockify
    RUN git clone https://github.com/novnc/noVNC $SEER_DIR/Downloads/noVNC && \
    cd $SEER_DIR/Downloads/noVNC && \
    git checkout v1.5.0 && \
    wget https://github.com/novnc/websockify/archive/refs/tags/v0.12.0.tar.gz && \
    tar -xvf v0.12.0.tar.gz && \
    mv websockify-0.12.0 $SEER_DIR/Downloads/noVNC/websockify && \
    rm v0.12.0.tar.gz

    # # Configura o VNC e noVNC
    # RUN mkdir -p /root/.vnc && \
    # echo "" | vncpasswd -f > /root/.vnc/passwd && \
    # chmod 600 /root/.vnc/passwd

    # Expõe as portas necessárias
    EXPOSE 5900 6080

    # Adiciona script de inicialização
    COPY config/docker/ubuntu/start.sh $SEER_DIR/start.sh
    COPY config/docker/ubuntu/exps.sh $SEER_DIR/exps.sh
    RUN sudo chmod +x $SEER_DIR/start.sh && sudo chmod a+wx $SEER_DIR/exps.sh

    # Define o comando para iniciar o VNC e noVNC
    CMD ["/home/ubuntu/seer/start.sh"]