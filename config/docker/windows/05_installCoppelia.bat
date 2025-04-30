REM ############################################### REM
REM Abra o terminal com permissoes de administrador REM
REM ############################################### REM

REM Baixando o CoppeliaSim
choco install -y xsltproc
pip install xmlschema pyzmq cbor2 coppeliasim-zmqremoteapi-client

cd %USERPROFILE%\Downloads
wget --no-check-certificate https://www.coppeliarobotics.com/files/V4_7_0_rev4/CoppeliaSim_Edu_V4_7_0_rev4_Setup.exe
start CoppeliaSim_Edu_V4_7_0_rev4_Setup.exe

setx /m COPPELIASIM_ROOT_DIR "C:\Program Files\CoppeliaRobotics\CoppeliaSimEdu"
call RefreshEnv.cmd

REM Instalando o Boost - pacotes C++ para o Coppelia Sim
cd %USERPROFILE%\Downloads
wget --no-check-certificate https://archives.boost.io/release/1.86.0/source/boost_1_86_0.zip
7z x boost_1_86_0.zip
setx /m BOOST_ROOT C:\boost
setx /m BOOST_LIBRARYDIR C:\boost\stage\lib
ren boost_1_86_0 boost
move boost C:\
cd C:\boost
setx PATH /m "%PATH%C:\boost;C:\boost\stage\lib;C:\boost\libs\python;"
call RefreshEnv.cmd
call bootstrap vc142 && .\b2 && .\b2 install --with-python --with-thread --with-system --with-regex --with-filesystem --with-program_options --with-iostreams --with-date_time