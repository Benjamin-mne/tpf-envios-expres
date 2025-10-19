@echo off
cls

REM Crear carpeta bin si no existe
if not exist bin mkdir bin

echo ==========================================
echo        COMPILANDO UNITS...
echo ==========================================

echo Compilando envio.pas...
fpc src\model\envio.pas -FUbin
if errorlevel 1 goto Error

echo ==========================================
echo Compilando Utils.pas...
fpc src\utils\Utils.pas -FUbin
if errorlevel 1 goto Error

echo ==========================================
echo Compilando DAOUtils.pas...
fpc src\utils\DAOUtils.pas -FUbin
if errorlevel 1 goto Error

echo ==========================================
echo Compilando DAOenvio.pas...
fpc src\dao\DAOenvio.pas -FUbin
if errorlevel 1 goto Error

echo ==========================================
echo Compilando ControllerEnvio.pas...
fpc src\controller\ControllerEnvio.pas -FUbin
if errorlevel 1 goto Error

echo ==========================================
echo Compilando TestUtils.pas...
fpc src\utils\TestUtils.pas -FUbin
if errorlevel 1 goto Error
echo.

echo ==========================================
echo Compilando menu.pas...
fpc src\view\menu.pas -FUbin
if errorlevel 1 goto Error
echo.

echo ==========================================
echo        COMPILANDO PROGRAMA PRINCIPAL...
echo ==========================================
fpc src\main.pas -FEbin -obin\TPF.exe
if errorlevel 1 goto Error
echo.

echo ==========================================
echo  El programa se ha compilado correctamente.
echo  Puedes ejecutarlo con: bin\TPF.exe
echo ==========================================
goto LimpiarArchivos
echo.

:Error
color 4F
echo.
echo ==========================================
echo  ERROR: La compilacion ha fallado.
echo ==========================================
echo.
pause
goto LimpiarArchivos

:LimpiarArchivos
echo ==========================================
echo        LIMPIANDO ARCHIVOS TEMPORALES ...
echo ==========================================
del /q bin\*.o bin\*.ppu 2>nul
goto End
echo.

:End
echo.
pause
if errorlevel 1 exit /b 1 else exit /b 0
