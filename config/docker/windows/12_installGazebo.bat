REM Criando um ambiente virtual para o gazebo ignition
call RefreshEnv.cmd
call %conda% create -y -n gz-env python=3.10
call %conda% activate gz-env
call %conda% install -y gz-sim9 --channel conda-forge