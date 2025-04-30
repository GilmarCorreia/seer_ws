FROM chocolatey/choco:latest-windows

    # Configuring seer_dir
    WORKDIR seer

    ENV SEER_DIR=C:\\seer

    COPY config/docker/windows/01_install.bat scripts/01_install.bat
    RUN scripts\01_install.bat

    # Restore the default Windows shell for correct batch processing.
    SHELL ["cmd", "/S", "/C"]

    # Installing vscode tools
    RUN curl -SL --output vs_buildtools.exe https://aka.ms/vs/17/release/vs_buildtools.exe && (start /w vs_buildtools.exe --quiet --wait --norestart --nocache `\
            --installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2022\BuildTools" `\
            --add Microsoft.VisualStudio.Workload.AzureBuildTools `\
            --remove Microsoft.VisualStudio.Component.Windows10SDK.10240 `\
            --remove Microsoft.VisualStudio.Component.Windows10SDK.10586 `\
            --remove Microsoft.VisualStudio.Component.Windows10SDK.14393 `\
            --remove Microsoft.VisualStudio.Component.Windows81SDK `\
            || IF "%ERRORLEVEL%"=="3010" EXIT 0) \
            && del /q vs_buildtools.exe

    # COPY config/docker/windows/02_installQt.bat scripts/02_installQt.bat
    # RUN scripts\02_installQt.bat

    COPY config/docker/windows/03_installRos.bat scripts/03_installRos.bat
    RUN scripts\03_installRos.bat

    COPY config/docker/windows/04_configWorkspace.bat scripts/04_configWorkspace.bat
    RUN call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\Tools\VsDevCmd.bat" && C:\seer\scripts\04_configWorkspace.bat

    # COPY config/docker/windows/05_installCoppelia.bat scripts/05_installCoppelia.bat
    # RUN scripts\05_installCoppelia.bat

    ENTRYPOINT ["cmd.exe"]