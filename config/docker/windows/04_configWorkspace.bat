REM Baixando os pacotes do workspace sim
cd %SIM_DIR%

git clone --recurse-submodules https://github.com/GilmarCorreia/sim_ws.git
cd sim_ws
git config --global --add safe.directory C:\sim\sim_ws
git checkout win
git submodule update --init --recursive
init_submodules.bat

setx /m SIM_WS_DIR %SIM_DIR%\sim_ws
call RefreshEnv.cmd

REM Construindo o workspace
cd %SIM_WS_DIR%

call %ROS_INIT%
call colcon build --merge-install --packages-select sim_controls sim_models --cmake-args -DPython3_EXECUTABLE="C:/Python38/python.exe"

REM Setando a variavel de ambiente do workspace
setx /m ROS_INIT_WS %SIM_WS_DIR%\install\setup.bat
call RefreshEnv.cmd

call %ROS_INIT_WS%