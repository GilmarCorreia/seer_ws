# Preparando o ambiente Windows para ROS + Coppelia Sim

## Requisitos

Para instalar os programas no windows é necessário possuir:

- 64-bit Windows 10/11 - Versão Home, Empresarial ou Pro
- TLS 1.2 ativado

## Pacotes

### Chocolatey

Chocolatey é um gerenciador de pacotes para o Windows, similar ao apt-get do Linux. Ele facilita a instalação, atualização e gerenciamento de softwares e bibliotecas no sistema operacional Windows. Usando o Chocolatey, você pode instalar aplicativos e ferramentas diretamente da linha de comando, simplificando o processo e garantindo que você tenha as versões mais recentes dos programas. Para instalar o Chocolatey, você pode usar um comando no PowerShell com privilégios administrativos, e após a instalação, gerenciar pacotes fica muito mais fácil e eficiente.

Abra o PowerShell com privilégios de administrador e execute o comando:

```sheel
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

Feche e abra o terminal novamente e digite choco para verificar se a instalação ocorreu corretamente.

#### Instalação dos Pacotes Necessários
Instale o Python e algumas distribuições necessárias abrindo o terminal com privilégios de administrador:

```bash
choco install -y python --version 3.8.3
choco install -y vcredist2013 vcredist140

choco install -y openssl --version 1.1.1.2100
setx /m OPENSSL_CONF "C:\Program Files\OpenSSL-Win64\bin\openssl.cfg"

choco upgrade git -y
choco install -y cmake wget 7zip.install wingetUI chocolateyGUI graphviz

cd "%UserProfile%\Downloads"

wget https://github.com/ros2/choco-packages/releases/download/2022-03-15/asio.1.12.1.nupkg
wget https://github.com/ros2/choco-packages/releases/download/2022-03-15/bullet.3.17.nupkg
wget https://github.com/ros2/choco-packages/releases/download/2022-03-15/cunit.2.1.3.nupkg
wget https://github.com/ros2/choco-packages/releases/download/2022-03-15/eigen.3.3.4.nupkg
wget https://github.com/ros2/choco-packages/releases/download/2022-03-15/tinyxml2.6.0.0.nupkg

choco install -y -s "%UserProfile%\Downloads" asio cunit eigen tinyxml2 bullet

python -m pip install -U pip setuptools
python -m pip install -U catkin_pkg cryptography empy importlib-metadata jsonschema lark==1.1.1 lxml matplotlib netifaces numpy opencv-python PyQt5 pillow psutil pycairo pydot pyparsing==2.4.7 pytest pyyaml rosdistro

wget https://www.zlatkovic.com/pub/libxml/64bit/libxml2-2.9.3-win32-x86_64.7z
wget https://www.zlatkovic.com/pub/libxml/64bit/iconv-1.14-win32-x86_64.7z
wget https://www.zlatkovic.com/pub/libxml/64bit/zlib-1.2.8-win32-x86_64.7z

7z x libxml2-2.9.3-win32-x86_64.7z -o"C:\xmllint"
7z x iconv-1.14-win32-x86_64.7z -o"C:\xmllint"
7z x zlib-1.2.8-win32-x86_64.7z -o"C:\xmllint"
terminar!!!!
```

### Visual Studio Community 2019

O Visual Studio 2019 Community é uma versão gratuita e completa do ambiente de desenvolvimento integrado (IDE) da Microsoft, destinado a desenvolvedores individuais, estudantes, projetos acadêmicos e pequenas equipes de desenvolvimento. Ele oferece um conjunto robusto de ferramentas para desenvolvimento de aplicações em diversas linguagens, como C++, C#, Python e muitas outras. Com ele, você pode criar aplicações web, desktop, móveis, jogos e muito mais. O Visual Studio 2019 Community inclui recursos avançados como depuração, profiling, IntelliSense, integração com o Git e suporte para o desenvolvimento em nuvem e DevOps.

Baixe o Visual Studio Community do [link](https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=Community&rel=16&src=myvs&utm_medium=microsoft&utm_source=my.visualstudio.com&utm_campaign=download&utm_content=vs+community+2019)

Verifique no processo de instalação se a caixa "Desktop development with C++" está ativado.

### OpenCV 

OpenCV (Open Source Computer Vision Library) é uma biblioteca de código aberto altamente otimizada para processamento de imagens e visão computacional. Desenvolvida inicialmente pela Intel, ela oferece ferramentas e algoritmos eficientes para análise de imagens e vídeos, incluindo funções para detectar e reconhecer faces, objetos, rastreamento de movimentos, extração de características, entre outras. OpenCV é amplamente utilizada em aplicações de visão computacional em tempo real, robótica, realidade aumentada e inteligência artificial, sendo compatível com várias linguagens de programação, como C++, Python e Java.

Baixe o OpenCv do [link](https://opencv.org/releases/) e durante a instalação coloque em C:\opencv

### Robot Operating System (ROS)

ROS 2 (Robot Operating System 2) é uma plataforma de software de código aberto para o desenvolvimento de aplicações robóticas. É a segunda versão do ROS, projetada para ser mais modular, flexível e adequada para sistemas robóticos comerciais e de pesquisa. ROS 2 fornece ferramentas e bibliotecas para construção de aplicativos robóticos, incluindo suporte para comunicação entre componentes (nós) via mensagens, serviços e ações. Ele é projetado para ser utilizado em ambientes distribuídos, com foco em desempenho, segurança, e suporte para sistemas em tempo real, tornando-se ideal para robôs autônomos, drones, veículos autônomos e outros sistemas complexos.

No terminal com privilégios de administrador: 

```bash
mkdir c:\opt\chocolatey
set ChocolateyInstall=c:\opt\chocolatey
choco source add -n=ros-win -s="https://aka.ms/ros/public" --priority=1
choco upgrade ros-humble-desktop -y --execution-timeout=0 --pre
```

### Coppelia Sim

CoppeliaSim é uma plataforma de simulação de robótica avançada, anteriormente conhecida como V-REP (Virtual Robot Experimentation Platform). É uma ferramenta de código aberto que permite a simulação de ambientes robóticos complexos e a modelagem de robôs, sensores e atuadores. CoppeliaSim é amplamente utilizado em pesquisa, educação e desenvolvimento de protótipos, pois oferece um motor de física integrado, suporte para simulações em tempo real e interações com hardware real. Ele também suporta diversas linguagens de programação, como Python, C++, Java e Lua, facilitando a integração e o controle de robôs simulados.

Baixe o Coppelia Sim Edu do [link](https://www.coppeliarobotics.com)

No terminal com privilégios de administrador: 

```bash
setx /m COPPELIASIM_ROOT_DIR "C:\Program Files\CoppeliaRobotics\CoppeliaSimEdu"

cd "%UserProfile%\Downloads"
wget https://archives.boost.io/release/1.78.0/source/boost_1_78_0.7z
7z x boost_1_78_0.7z -o"C:\boost"
cd "C:\boost\boost_1_78_0"
bootstrap
b2 toolset=msvc

setx /m BOOST_ROOT "C:\boost\boost_1_78_0"
setx /m BOOST_LIBRARYDIR "C:\boost\boost_1_78_0\stage\lib"

pip install pyzmq cbor2
```

### Configurações finais

Adicione no PATH do windows os caminhos:

- C:\Program Files\OpenSSL-Win64\bin\
- C:\opencv\x64\vc16\bin
- C:\xmllint\bin

## Criando o workspace do ROS2

Abra o terminal "x64 Native Tools Command Prompt for VS 2019" com privilégios de adminstrador:

```bash
c:\opt\ros\humble\x64\setup.bat
cd "%UserProfile%\Desktop" 
mkdir -p "ros2_ws\src"
cd ros2_ws\src

git clone https://github.com/CDC-IA/senai_models.git
git clone https://github.com/CoppeliaRobotics/simROS2.git sim_ros2_interface

pip install xmlschema
choco install -y xsltproc

cd ..
colcon build
```

Após construído é possível carregar os pacotes do workspace - Abra o terminal "x64 Native Tools Command Prompt for VS 2019" com privilégios de adminstrador:

```bash
c:\opt\ros\humble\x64\setup.bat
%UserProfile%\Desktop\ros2_ws\install\local_setup.bat 
```

Começe a usar os comandos do ros2 no Windows :)