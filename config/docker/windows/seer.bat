setx /m OPENSSL_CONF "C:\Program Files\OpenSSL-Win64\bin\openssl.cfg"

setx /m OpenCV_DIR C:\opencv\build

setx /m Qt5_DIR C:\Qt\Qt5.12.12\5.12.12\msvc2017_64
setx /m QT_QPA_PLATFORM_PLUGIN_PATH C:\Qt\Qt5.12.12\5.12.12\msvc2017_64\plugins\platforms

setx /m ROS_DISTRO humble
setx /m ROS_INIT C:\opt\ros\%ROS_DISTRO%\local_setup.bat

setx /m SEER_DIR %USERPROFILE%\seer
setx /m SEER_WS_DIR %SEER_DIR%\seer_ws
setx /m ROS_INIT_WS %SEER_WS_DIR%\install\setup.bat

setx /m COPPELIASIM_ROOT_DIR "C:\Program Files\CoppeliaRobotics\CoppeliaSimEdu"
setx /m BOOST_ROOT C:\boost
setx /m BOOST_LIBRARYDIR C:\boost\stage\lib

REM Configurando a variavel de ambiente do sistema PATH
setx PATH /m "C:\Python38\Scripts;C:\Python38;%PATH%C:\opencv\build\x64\vc16\bin;C:\Program Files\CMake\bin;C:\Program Files\Git\cmd;C:\Program Files\Graphviz\bin;C:\Program Files\OpenSSL-Win64\bin\;C:\xmllint\bin;C:\opt\ros\%ROS_DISTRO%;C:\opt\ros\%ROS_DISTRO%\bin;C:\boost;C:\boost\stage\lib;C:\boost\libs\python;"

setx conda "%USERPROFILE%\anaconda3\Library\bin\conda.bat"

setx /m GAZEBO_MODEL_PATH "%USERPROFILE%\.gazebo\models;%SEER_WS_DIR%\install\senai_models\share"
setx /m GAZEBO_PLUGIN_PATH "%SEER_WS_DIR%\install\gazebo_logger\bin;%GAZEBO_PLUGIN_PATH%"

SETX /m ISAAC_SIM_PACKAGE_PATH "%USERPROFILE%\AppData\Local\ov\pkg\isaac-sim-4.1.0"