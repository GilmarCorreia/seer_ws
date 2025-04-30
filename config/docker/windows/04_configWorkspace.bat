REM Baixando os pacotes do workspace do seer
cd %SEER_DIR%

git clone --recurse-submodules https://%USER%:%PASSWORD%@github.com/CDC-IA/seer_ws.git
cd seer_ws
git config --global --add safe.directory C:\seer\seer_ws
git checkout win
git submodule update --init --recursive
init_submodules.bat

setx /m SEER_WS_DIR %SEER_DIR%\seer_ws
call RefreshEnv.cmd

REM Construindo o workspace
cd %SEER_WS_DIR%

call %ROS_INIT%
call colcon build --merge-install --packages-select senai_controls senai_models --cmake-args -DPython3_EXECUTABLE="C:/Python38/python.exe"

REM Setando a variavel de ambiente do workspace
setx /m ROS_INIT_WS %SEER_WS_DIR%\install\setup.bat
call RefreshEnv.cmd

call %ROS_INIT_WS%