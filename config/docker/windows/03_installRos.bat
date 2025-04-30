REM ############################################### REM
REM Abra o terminal com permissoes de administrador REM
REM ############################################### REM

REM Baixando o ROS2 na versao mais recente
cd %USERPROFILE%\Downloads
setx /m ROS_DISTRO humble
call RefreshEnv.cmd

wget --no-check-certificate https://github.com/ros2/ros2/releases/download/release-%ROS_DISTRO%-20240807/ros2-%ROS_DISTRO%-20240807-windows-release-amd64.zip
7z x ros2-humble-20240807-windows-release-amd64.zip -oC:\opt\ros
ren C:\opt\ros\ros2-windows humble 

setx /m ROS_INIT C:\opt\ros\%ROS_DISTRO%\local_setup.bat
setx PATH /m "%PATH%C:\opt\ros\%ROS_DISTRO%;C:\opt\ros\%ROS_DISTRO%\bin;"
call RefreshEnv.cmd

call %ROS_INIT%