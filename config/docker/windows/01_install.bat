REM ################################################### REM
REM Reinicie o terminal com permissoes de administrador REM
REM ################################################### REM
call RefreshEnv.cmd

REM Instalando o Python 3.8.10
choco install -y python --version 3.8.10

REM Instalando redistribuicoes visual c++, wget, 7-Zip, GraphViz, Cppcheck, curl, git, Winflexbison3 e ninja
choco install -y vcredist2013 vcredist140 wget 7zip graphviz cppcheck curl git winflexbison3 ninja

REM Instalando o OpenSSL 1.1.1.2100
choco install -y openssl --version 1.1.1.2100
setx /m OPENSSL_CONF "C:\Program Files\OpenSSL-Win64\bin\openssl.cfg"

REM Instalando a ultima versao do OpenCV
choco install -y opencv --package-parameters '/InstallationPath:"C:"'
setx /m OpenCV_DIR C:\opencv\build

REM Instalando o CMake
choco install -y cmake

REM Instalando pacotes do cmake
cd %USERPROFILE%\Downloads

wget --no-check-certificate https://github.com/ros2/choco-packages/releases/download/2022-03-15/asio.1.12.1.nupkg
wget --no-check-certificate https://github.com/ros2/choco-packages/releases/download/2022-03-15/bullet.3.17.nupkg
wget --no-check-certificate https://github.com/ros2/choco-packages/releases/download/2022-03-15/cunit.2.1.3.nupkg
wget --no-check-certificate https://github.com/ros2/choco-packages/releases/download/2022-03-15/eigen.3.3.4.nupkg
wget --no-check-certificate https://github.com/ros2/choco-packages/releases/download/2022-03-15/tinyxml-usestl.2.6.2.nupkg
wget --no-check-certificate https://github.com/ros2/choco-packages/releases/download/2022-03-15/tinyxml2.6.0.0.nupkg

choco install -y -s %USERPROFILE%\Downloads asio cunit eigen tinyxml-usestl tinyxml2 bullet

REM Configurando a variavel de ambiente do sistema PATH
setx PATH /m "C:\Python38\Scripts;C:\Python38;%PATH%C:\opencv\build\x64\vc16\bin;C:\Program Files\CMake\bin;C:\Program Files\Git\cmd;C:\Program Files\Graphviz\bin;C:\Program Files\OpenSSL-Win64\bin\;C:\xmllint\bin;"

call RefreshEnv.cmd

REM Baixando pacotes Python
python -m pip install -U pip

pip install -U colcon-common-extensions setuptools catkin_pkg cryptography importlib-metadata lark==1.1.1 lxml matplotlib netifaces numpy opencv-python PyQt5 pillow psutil pycairo pydot pyparsing==2.4.7 pyyaml rosdistro colcon-common-extensions coverage flake8 flake8-blind-except flake8-builtins flake8-class-newline flake8-comprehensions flake8-deprecated flake8-docstrings flake8-import-order flake8-quotes mock mypy==0.931 pep8 pydocstyle pytest pytest-mock vcstool typeguard xacro jinja2 psutil pympler pandas

REM Instalando pacotes xmllint
wget --no-check-certificate https://www.zlatkovic.com/pub/libxml/64bit/iconv-1.14-win32-x86_64.7z
wget --no-check-certificate https://www.zlatkovic.com/pub/libxml/64bit/libtool-2.4.6-win32-x86_64.7z
wget --no-check-certificate https://www.zlatkovic.com/pub/libxml/64bit/libxml2-2.9.3-win32-x86_64.7z
wget --no-check-certificate https://www.zlatkovic.com/pub/libxml/64bit/libxslt-1.1.28-win32-x86_64.7z
wget --no-check-certificate https://www.zlatkovic.com/pub/libxml/64bit/mingwrt-5.2.0-win32-x86_64.7z
wget --no-check-certificate https://www.zlatkovic.com/pub/libxml/64bit/openssl-1.0.2e-win32-x86_64.7z
wget --no-check-certificate https://www.zlatkovic.com/pub/libxml/64bit/xmlsec1-1.2.20-win32-x86_64.7z
wget --no-check-certificate https://www.zlatkovic.com/pub/libxml/64bit/zlib-1.2.8-win32-x86_64.7z

mkdir xmllint
7z x iconv-1.14-win32-x86_64.7z -o%USERPROFILE%\Downloads\xmllint
7z x libtool-2.4.6-win32-x86_64.7z -o%USERPROFILE%\Downloads\xmllint
7z x libxml2-2.9.3-win32-x86_64.7z -o%USERPROFILE%\Downloads\xmllint
7z x libxslt-1.1.28-win32-x86_64.7z -o%USERPROFILE%\Downloads\xmllint
7z x mingwrt-5.2.0-win32-x86_64.7z -o%USERPROFILE%\Downloads\xmllint
7z x openssl-1.0.2e-win32-x86_64.7z -o%USERPROFILE%\Downloads\xmllint
7z x xmlsec1-1.2.20-win32-x86_64.7z -o%USERPROFILE%\Downloads\xmllint
7z x zlib-1.2.8-win32-x86_64.7z -o%USERPROFILE%\Downloads\xmllint

move xmllint C:\

REM Instalando o Visual Studio 2019 Community
choco install -y visualstudio2019community