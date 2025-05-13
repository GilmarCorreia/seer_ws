REM ############################################### REM
REM Abra o terminal com permissoes de administrador REM
REM ############################################### REM

REM Instalando o vcpkg
cd C:\
git clone https://github.com/microsoft/vcpkg.git
cd vcpkg
call bootstrap-vcpkg.bat
vcpkg install jsoncpp:x64-windows libzip:x64-windows
vcpkg integrate install

REM Construindo o pacote sim_ros2_interface
cd %SIM_WS_DIR%

call %ROS_INIT_WS%
set CMAKE_PREFIX_PATH=C:\vcpkg\installed\x64-windows
set CMAKE_TOOLCHAIN_FILE=C:\vcpkg\scripts\buildsystems\vcpkg.cmake
call colcon build --merge-install --packages-select sim_ros2_interface --cmake-args -DPython3_EXECUTABLE="C:/Python38/python.exe"