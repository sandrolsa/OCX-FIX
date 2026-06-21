@echo off
color 0A

:: ==========================================================
:: EXTRAI OCX.ZIP
:: ==========================================================

if exist "%~dp0ocx" rd /s /q "%~dp0ocx"

7z x "%~dp0OCX.zip" -o"%~dp0ocx" -y >nul 2>&1

:: ==========================================================
:: VERIFICA PERMISSAO DE ADMINISTRADOR
:: ==========================================================

net session >nul 2>&1

if errorlevel 1 (
    color 0C
    echo Execute este arquivo como Administrador.
    pause
    exit /b
)

:: ==========================================================
:: VERIFICA PASTA OCX
:: ==========================================================

if not exist "%~dp0ocx\" (
    color 0C
    echo Pasta "%~dp0ocx" nao encontrada.
    pause
    exit /b
)

:: ==========================================================
:: SYSTEM32
:: ==========================================================

echo Copiando e registrando OCX para System32...

for /r "%~dp0ocx" %%F in (*.ocx) do (
    copy "%%F" "C:\Windows\System32\" /Y >nul 2>nul
    regsvr32 /s "C:\Windows\System32\%%~nxF"
    echo %%~nxF atualizado.
)

:: ==========================================================
:: SYSWOW64
:: ==========================================================

if exist "C:\Windows\SysWOW64\" (

    echo.
    echo Copiando e registrando OCX para SysWOW64...

    for /r "%~dp0ocx" %%F in (*.ocx) do (
        copy "%%F" "C:\Windows\SysWOW64\" /Y >nul 2>nul
        "%SystemRoot%\SysWOW64\regsvr32.exe" /s "C:\Windows\SysWOW64\%%~nxF"
        echo %%~nxF atualizado.
    )
)

:: ==========================================================
:: LIMPEZA
:: ==========================================================

if exist "%~dp0ocx" (
    rd /s /q "%~dp0ocx"
)

:: ==========================================================
:: FINALIZACAO
:: ==========================================================

color 0A

echo.
echo ========================================
echo OCXs copiados e registrados com sucesso.
echo ========================================

pause