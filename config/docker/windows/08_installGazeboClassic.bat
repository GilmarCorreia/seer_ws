REM Instalando o vcpkg
cd C:\vcpkg
call bootstrap-vcpkg.bat
vcpkg install protobuf protobuf:x64-windows protobuf[zlib] protobuf[zlib]:x64-windows sdformat9:x64-windows ignition-transport8:x64-windows ignition-common3:x64-windows ignition-fuel-tools4:x64-windows tcb-span:x64-windows fmt:x64-windows eigen3:x64-windows
vcpkg integrate install

REM Criando um ambiente virtual para o gazebo
setx conda "C:\tools\Anaconda3\condabin\conda.bat"
call RefreshEnv.cmd
call %conda% create -y -n gazebo-classic python=3.10
call %conda% activate gazebo-classic
call %conda% install -y -c conda-forge gazebo