#!/bin/bash

sim_version="1.0.0"
env="ubuntu"

# # Prompt the user to enter the operating system
# read -p "Enter the operating system to build (ubuntu or windows): " env

# # Validate the operating system choice
# if [ "$env" == "ubuntu" ] || [ "$env" == "windows" ]; then
    echo "Chosen operating system: $env"
# else
#     echo "Please choose a valid system to build (Options: ubuntu | windows)"
#     exit 1
# fi

# Prompt the user for the package to build
read -p "Enter the package to build (sim-min | sim-full | sim-nvidia-min | sim-nvidia-full | coppelia | gazebo | isaac | ros2-humble): " pkg

if [ "$pkg" == "coppelia" ] || [ "$pkg" == "gazebo" ] || [ "$pkg" == "isaac" ] || [ "$pkg" == "ros2" ]; then
    use_compose="n"
else
    # Prompt the user to use the default development configuration
    read -p "Do you want to use the default development configuration? (y | n): " use_compose
fi

# Initialize Docker parameters
docker_params=""
entrypoint=""

if [ "$use_compose" == "n" ]; then
    read -p "Do you want to enable visual interface? Note: This option is only valid when using Docker in a WSL2 terminal on Windows. (y | n): " enable_visual

    if [ "$enable_visual" == "y" ]; then
        docker_params="--env DISPLAY=$DISPLAY --volume /tmp/.X11-unix:/tmp/.X11-unix"

        if [ "$pkg" == "sim-min" ] || [ "$pkg" == "sim-full" ] || [ "$pkg" == "sim-nvidia-min" ] || [ "$pkg" == "sim-nvidia-full" ]; then
            entrypoint='bash -c "source /root/.bashrc; ros2 launch sim_models model_rsp.launch.py model:=w3_600b"'
        elif [ "$pkg" == "coppelia" ]; then
            entrypoint='bash -c "source /root/.bashrc; $COPPELIASIM_ROOT_DIR/coppeliaSim.sh"'
        elif [ "$pkg" == "gazebo" ]; then
            entrypoint='gazebo --verbose'
        elif [ "$pkg" == "ros2" ]; then
            entrypoint='/bin/bash'
        fi
    else
        docker_params="--entrypoint bash"
    fi

    read -p "Do you want to use an NVIDIA GPU? (y | n): " enable_nvidia
    if [ "$enable_nvidia" == "y" ]; then
        docker_params="--runtime nvidia -e NVIDIA_VISIBLE_DEVICES=all -e NVIDIA_DRIVER_CAPABILITIES=all -e MESA_D3D12_DEFAULT_ADAPTER_NAME=NVIDIA --gpus all $docker_params"
    fi
fi

# Build and run the chosen package
if [ "$pkg" == "sim-min" ] || [ "$pkg" == "sim-full" ] || [ "$pkg" == "sim-nvidia-min" ] || [ "$pkg" == "sim-nvidia-full" ]; then
    if [ "$use_compose" == "y" ]; then
        #docker-compose -f $pkg-compose.yml build
        docker-compose -f $pkg-compose.yml up -d --build
    else
        docker build . -f config/docker/$env/sim.Dockerfile --tag=$pkg:$sim_version
        docker run -it --rm $docker_params -p 6080:6080 $pkg:$sim_version $entrypoint
    fi
elif [ "$pkg" == "coppelia" ]; then
    docker build . -f config/docker/$env/coppelia.Dockerfile --tag=coppelia:v4.9.0rev6
    docker run -it --rm $docker_params coppelia:v4.9.0rev6 $entrypoint
elif [ "$pkg" == "gazebo" ]; then
    docker build . -f config/docker/$env/gazebo.Dockerfile --tag=gazebo:classic-11.10.2
    docker run -it --rm $docker_params gazebo:classic-11.10.2 $entrypoint
elif [ "$pkg" == "isaac" ]; then
    if [ "$enable_visual" == "y" ]; then
        # Add specific logic for Isaac with visual interface if needed
        echo "Isaac with visual interface logic."
    else
        docker run --name isaac-sim --entrypoint bash -it --runtime=nvidia --gpus all -e "ACCEPT_EULA=Y" --rm --network=host \
        -e "PRIVACY_CONSENT=Y" \
        -v ~/docker/isaac-sim/cache/kit:/isaac-sim/kit/cache:rw \
        -v ~/docker/isaac-sim/cache/ov:/root/.cache/ov:rw \
        -v ~/docker/isaac-sim/cache/pip:/root/.cache/pip:rw \
        -v ~/docker/isaac-sim/cache/glcache:/root/.cache/nvidia/GLCache:rw \
        -v ~/docker/isaac-sim/cache/computecache:/root/.nv/ComputeCache:rw \
        -v ~/docker/isaac-sim/logs:/root/.nvidia-omniverse/logs:rw \
        -v ~/docker/isaac-sim/data:/root/.local/share/ov/data:rw \
        -v ~/docker/isaac-sim/documents:/root/Documents:rw \
        nvcr.io/nvidia/isaac-sim:4.1.0
    fi
elif [ "$pkg" == "ros2" ]; then
    docker build . -f config/docker/$env/ros_humble.Dockerfile --tag=ros2_humble
    docker run -it --rm $docker_params ros2_humble:latest $entrypoint
else
    echo "Invalid package specified."
fi
