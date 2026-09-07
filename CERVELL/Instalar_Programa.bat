@echo off
title Instalador y Migrador - SRI PRO CERVELL
echo ========================================================
echo        INSTALADOR Y MIGRADOR AUTOMATICO
echo              SRI PRO - CERVELL
echo ========================================================
echo.

:: 1. VERIFICAR E INSTALAR PYTHON (Opcional, si no esta instalado)
python --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Python no esta instalado o no esta en el PATH.
    echo Por favor, instala Python marcando la opcion "Add Python to PATH" durante la instalacion.
    echo Descargalo desde: https://www.python.org/downloads/
    pause
    goto :EOF
)

echo [OK] Python detectado.
echo.
echo ========================================================
echo Instalando dependencias necesarias...
echo ========================================================
pip install -r requirements.txt
echo [OK] Dependencias instaladas.
echo.

:: 2. MIGRAR DATOS DESDE LA CARPETA ANTIGUA
set "RUTA_ANTIGUA=D:\User\Escritorio\DESCARGA MASIVA SRI"
set "RUTA_ACTUAL=%~dp0"

echo ========================================================
echo Verificando si existe informacion antigua para migrar...
echo ========================================================

IF EXIST "%RUTA_ANTIGUA%" (
    echo [OK] Carpeta antigua encontrada: "%RUTA_ANTIGUA%"

    :: Copiar la base de datos si existe y no sobreescribir la nueva si ya tiene datos? Mejor solo copiar si existe en la antigua y no existe aqui o avisar
    IF EXIST "%RUTA_ANTIGUA%\sri_bot.db" (
        echo Copiando base de datos sri_bot.db...
        copy /y "%RUTA_ANTIGUA%\sri_bot.db" "%RUTA_ACTUAL%sri_bot.db"
    )

    :: Copiar los documentos
    IF EXIST "%RUTA_ANTIGUA%\DOCUMENTOS DE CLIENTES" (
        echo Copiando DOCUMENTOS DE CLIENTES...
        xcopy /e /i /y "%RUTA_ANTIGUA%\DOCUMENTOS DE CLIENTES" "%RUTA_ACTUAL%DOCUMENTOS DE CLIENTES"
    )

    echo [OK] Migracion completada exitosamente. La informacion original sigue intacta.
) ELSE (
    echo [INFO] No se encontro la carpeta "%RUTA_ANTIGUA%".
    echo Si es una instalacion nueva, puedes ignorar este mensaje.
)

echo.
echo ========================================================
echo INSTALACION FINALIZADA
echo ========================================================
echo Ya puedes iniciar el programa usando "Iniciar_SRI.vbs"
pause
