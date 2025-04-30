REM Instalando pacotes isaac do python
conda create -y --name isaacsim python==3.10 
conda activate isaacsim
pip install isaacsim==4.2.0.2 isaacsim-extscache-physics==4.2.0.2 isaacsim-extscache-kit==4.2.0.2 isaacsim-extscache-kit-sdk==4.2.0.2 --extra-index-url https://pypi.nvidia.com

SETX /m ISAAC_SIM_PACKAGE_PATH "%USERPROFILE%\AppData\Local\ov\pkg\isaac-sim-4.2.0"
call RefreshEnv.cmd

REM Lancando o Isaac Sim
%ISAAC_SIM_PACKAGE_PATH%\isaac-sim.bat