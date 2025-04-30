REM Clonando repositorios gazebo_ros_pkgs
cd %SEER_WS_DIR%
git checkout win
git pull
git submodule update --init --recursive
init_submodules.bat

REM Setando variaveis de ambiente do vcpkg
cd %SEER_WS_DIR%
call %ROS_INIT%
call colcon build --packages-select angles ackermann_msgs cv_bridge filters tcb_span tl_expected pluginlib --cmake-args -DCMAKE_PREFIX_PATH="C:/boost" -DBOOST_ROOT="C:/boost" -DBoost_NO_SYSTEM_PATHS=ON -DBUILD_TESTING=OFF -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON -DPython3_EXECUTABLE="C:/Python38/python.exe"

set CMAKE_PREFIX_PATH=C:\vcpkg\installed\x64-windows
set CMAKE_TOOLCHAIN_FILE=C:\vcpkg\scripts\buildsystems\vcpkg.cmake

call colcon build --packages-select rsl --cmake-args -DBUILD_TESTING=OFF -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON -G Ninja

REM Construindo os pacotes
call %ROS_INIT_WS%
call colcon build --packages-ignore rsl gazebo_ros gazebo_ros_pkgs gazebo_plugins gazebo_logger gazebo_ros2_control gazebo_ros2_control_demos --cmake-args -DCMAKE_PREFIX_PATH="C:/boost" -DBOOST_ROOT="C:/boost" -DBoost_NO_SYSTEM_PATHS=ON -DBUILD_TESTING=OFF -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON -DPython3_EXECUTABLE="C:/Python38/python.exe"

call %ROS_INIT_WS%
call %conda% activate gazebo
REM call colcon build --packages-select gazebo_ros gazebo_ros_pkgs gazebo_plugins gazebo_logger gazebo_ros2_control_demos gazebo_ros2_control --cmake-args -DCMAKE_PREFIX_PATH="C:/boost" -DBOOST_ROOT="C:/boost" -DBoost_NO_SYSTEM_PATHS=ON -DBUILD_TESTING=OFF -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON -DPython3_EXECUTABLE="C:/Python38/python.exe"
call colcon build --continue-on-error --packages-ignore rsl --cmake-args -DCMAKE_PREFIX_PATH="C:/boost" -DBOOST_ROOT="C:/boost" -DBoost_NO_SYSTEM_PATHS=ON -DBUILD_TESTING=OFF -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON -DPython3_EXECUTABLE="C:/Python38/python.exe"

REM Adicionando a variavel de ambiente GAZEBO_MODEL_PATH
mkdir %USERPROFILE%\.gazebo\models
setx /m GAZEBO_MODEL_PATH "%USERPROFILE%\.gazebo\models;%SEER_WS_DIR%\install\senai_models\share"
setx /m GAZEBO_PLUGIN_PATH "%SEER_WS_DIR%\install\gazebo_logger\bin;%GAZEBO_PLUGIN_PATH%"