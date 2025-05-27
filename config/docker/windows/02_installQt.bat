REM ############################################### REM
REM Abra o terminal com permissoes de administrador REM
REM ############################################### REM

REM Instalando o Qt5
cd %USERPROFILE%\Downloads
wget --no-check-certificate https://download.qt.io/archive/qt/5.12/5.12.12/qt-opensource-windows-x86-5.12.12.exe
start qt-opensource-windows-x86-5.12.12.exe
setx /m Qt5_DIR C:\Qt\Qt5.12.12\5.12.12\msvc2017_64
setx /m QT_QPA_PLATFORM_PLUGIN_PATH C:\Qt\Qt5.12.12\5.12.12\msvc2017_64\plugins\platforms
call RefreshEnv.cmd