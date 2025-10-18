REM Crear carpeta bin si no existe
if not exist bin mkdir bin

@echo off
cls
echo ==========================================
echo        COMPILANDO UNITS...
echo ==========================================
REM Compilar el units
fpc -FUbin -Fu src\model\envio.pas
echo ==========================================
fpc -FUbin -Fu src\utils\DAOUtils.pas
echo ==========================================
fpc -FUbin -Fu src\dao\DAOenvio.pas
echo ==========================================
fpc -FUbin -Fu src\controller\ControllerEnvio.pas
echo ==========================================
fpc -FUbin -Fu src\view\menu.pas
echo.

@echo off
echo ==========================================
echo        COMPILANDO PROGRAMA PRINCIPAL...
echo ==========================================
REM Compilar el programa
fpc src\main.pas -FEbin -obin\TPF.exe
echo.

REM Verificar si la compilacion fue exitosa
if %errorlevel%==0 (
    @echo off
    echo ==========================================
    echo        LIMPIANDO ARCHIVOS TEMPORALES ...
    echo ==========================================
    echo.
    del /q bin\*.o bin\*.ppu 2>nul
    echo ==========================================
    echo  El programa se ha compilado correctamente.
    echo  Puedes ejecutarlo con: bin\TPF.exe
    echo ==========================================
) else (
    echo.
    echo ERROR: La compilacion ha fallado.
)

echo.
pause
