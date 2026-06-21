@echo off
color 07

:: Verifica permissao de administrador
net session >nul 2>&1
if errorlevel 1 (
    color 0C
    echo Execute este arquivo como Administrador.
    pause
    exit /b
)

if not exist "%~dp0ocx\" (
    color 0C
    echo Pasta "%~dp0ocx" nao encontrada.
    pause
    exit /b
)

echo Copiando e registrando OCX para System32...

for %%F in ("%~dp0ocx\*.ocx") do (
    copy "%%F" "C:\Windows\System32\" /Y >nul 2>nul
    regsvr32 /s "C:\Windows\System32\%%~nxF"
color 0A
    echo %%~nxF atualizado.
)

if exist "C:\Windows\SysWOW64\" (
    echo.
    echo Copiando e registrando OCX para SysWOW64...

    for %%F in ("%~dp0ocx\*.ocx") do (
        copy "%%F" "C:\Windows\SysWOW64\" /Y >nul
        regsvr32 /s "C:\Windows\SysWOW64\%%~nxF" >nul 2>nul
color 0A
	echo %%~nxF atualizado.
    )
)

color 0A
echo.
echo ========================================
echo OCXs copiados e registrados com sucesso.
echo ========================================
pause