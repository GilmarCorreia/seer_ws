@echo off

set "sim_version=1.0.0"
set "DISPLAY=:0"
set "env=ubuntu"

@REM REM Prompt the user to enter the operating system
@REM set /p "env=Enter the operating system to build (ubuntu or windows): "

@REM REM Validate the operating system choice
@REM if /i "%env%" neq "ubuntu" if /i "%env%" neq "windows" (
@REM     echo Please choose a valid system to build (Options: ubuntu ^| windows)
@REM     goto :EOF
@REM )

echo Chosen operating system: %env%

REM Prompt the user for the package to build
set /p "pkg=Enter the package to build (sim-min | sim-full | sim-nvidia-min | sim-nvidia-full | coppelia | gazebo | isaac | ros2-humble): "

REM Set default values
set "entrypoint="
set "docker_params="

if /i "%pkg%"=="coppelia" goto VISUAL
if /i "%pkg%"=="gazebo" goto VISUAL
if /i "%pkg%"=="isaac" goto VISUAL
if /i "%pkg%"=="ros2-humble" goto VISUAL

REM Prompt for Docker Compose usage
set /p "use_compose=Do you want to use the default development configuration? (y | n): "
if /i "%use_compose%"=="y" goto BUILD

:VISUAL
    set /p "enable_visual=Do you want to enable visual interface? Note: This option is only valid when using Docker in a WSL2 terminal on Windows. (y | n): "

    if /i "%enable_visual%"=="y" (
        set "docker_params=--env DISPLAY=%DISPLAY% --volume /tmp/.X11-unix:/tmp/.X11-unix"

        if /i "%pkg%"=="sim-min" set "entrypoint=bash -c 'source /root/.bashrc; ros2 launch sim_models model_rsp.launch.py model:=w3_600b'"
        if /i "%pkg%"=="sim-full" set "entrypoint=bash -c 'source /root/.bashrc; ros2 launch sim_models model_rsp.launch.py model:=w3_600b'" 
        if /i "%pkg%"=="sim-nvidia-min" set "entrypoint=bash -c 'source /root/.bashrc; ros2 launch sim_models model_rsp.launch.py model:=w3_600b'"
        if /i "%pkg%"=="sim-nvidia-full" set "entrypoint=bash -c 'source /root/.bashrc; ros2 launch sim_models model_rsp.launch.py model:=w3_600b'" 
        if /i "%pkg%"=="coppelia" set "entrypoint=bash -c 'source /root/.bashrc; $COPPELIASIM_ROOT_DIR/coppeliaSim.sh'"
        if /i "%pkg%"=="gazebo" set "entrypoint=gazebo --verbose"
        if /i "%pkg%"=="ros2" set "entrypoint=/bin/bash"
    )
    
    if /i "%enable_visual%"=="n" set "docker_params=--entrypoint bash"

    goto NVIDIA

:NVIDIA
    set /p "enable_nvidia=Do you want to use an NVIDIA GPU? (y | n): "
    if /i "%enable_nvidia%"=="y" (
        set "docker_params=--runtime nvidia -e NVIDIA_VISIBLE_DEVICES=all -e NVIDIA_DRIVER_CAPABILITIES=all -e MESA_D3D12_DEFAULT_ADAPTER_NAME=NVIDIA --gpus all %docker_params%"
    )
    goto BUILD

:BUILD
    REM Build and run the chosen package
    if /i "%pkg%"=="sim-min" (
        if /i "%use_compose%"=="y" (
            docker-compose -f %pkg%-compose.yml up -d --build
            goto :EOF
        )
        
        docker build . -f config\docker\%env%\sim.Dockerfile --tag=%pkg%:%sim_version%
        docker run -it --rm %docker_params% -p 6080:6080 %pkg%:%sim_version% %entrypoint%
        goto :EOF
    ) 

    if /i "%pkg%"=="sim-full" (
        if /i "%use_compose%"=="y" (
            docker-compose -f %pkg%-compose.yml up -d --build
            goto :EOF
        )

        docker build . -f config\docker\%env%\sim.Dockerfile --tag=%pkg%:%sim_version%
        docker run -it --rm %docker_params% -p 6080:6080 %pkg%:%sim_version% %entrypoint%
        goto :EOF
    )
    
    if /i "%pkg%"=="sim-nvidia-min" (
        if /i "%use_compose%"=="y" (
            docker-compose -f %pkg%-compose.yml up -d --build
            goto :EOF
        )

        docker build . -f config\docker\%env%\sim.Dockerfile --tag=%pkg%:%sim_version%
        docker run -it --rm %docker_params% -p 6080:6080 %pkg%:%sim_version% %entrypoint%
        goto :EOF
    )
    
    if /i "%pkg%"=="sim-nvidia-full" (
        if /i "%use_compose%"=="y" (
            docker-compose -f %pkg%-compose.yml up -d --build
            goto :EOF
        )

        docker build . -f config\docker\%env%\sim.Dockerfile --tag=%pkg%:%sim_version%
        docker run -it --rm %docker_params% -p 6080:6080 %pkg%:%sim_version% %entrypoint%
        goto :EOF
    )
    
    if /i "%pkg%"=="coppelia" (
        docker build . -f config\docker\%env%\coppelia.Dockerfile --tag=coppelia:v4.7.0rev4
        docker run -it --rm %docker_params% coppelia:v4.7.0rev4 %entrypoint%
        goto :EOF
    )
    
    if /i "%pkg%"=="gazebo" (
        docker build . -f config\docker\%env%\gazebo.Dockerfile --tag=gazebo:classic-11.10.2
        docker run -it --rm %docker_params% gazebo:classic-11.10.2 %entrypoint%
        goto :EOF
    )
    
    if /i "%pkg%"=="isaac" (
        if /i "%enable_visual%"=="y" (
            REM Add specific logic for Isaac with visual interface if needed
            echo Isaac with visual interface logic.
            goto :EOF
        )

        docker run --name isaac-sim --entrypoint bash -it --runtime=nvidia --gpus all -e "ACCEPT_EULA=Y" --rm --network=host ^
        -e "PRIVACY_CONSENT=Y" ^
        -v %USERPROFILE%\docker\isaac-sim\cache\kit:/isaac-sim/kit/cache:rw ^
        -v %USERPROFILE%\docker\isaac-sim\cache\ov:/root/.cache/ov:rw ^
        -v %USERPROFILE%\docker\isaac-sim\cache\pip:/root/.cache/pip:rw ^
        -v %USERPROFILE%\docker\isaac-sim\cache\glcache:/root/.cache/nvidia/GLCache:rw ^
        -v %USERPROFILE%\docker\isaac-sim\cache\computecache:/root/.nv/ComputeCache:rw ^
        -v %USERPROFILE%\docker\isaac-sim\logs:/root/.nvidia-omniverse/logs:rw ^
        -v %USERPROFILE%\docker\isaac-sim\data:/root/.local/share/ov/data:rw ^
        -v %USERPROFILE%\docker\isaac-sim\documents:/root/Documents:rw ^
        nvcr.io/nvidia/isaac-sim:4.1.0
        goto :EOF
    )
    
    if /i "%pkg%"=="ros2-humble" (
        docker build . -f config\docker\%env%\ros_humble.Dockerfile --tag=ros2_humble
        docker run -it --rm %docker_params% ros2_humble:latest %entrypoint%
        goto :EOF
    )

    echo Invalid package specified.
