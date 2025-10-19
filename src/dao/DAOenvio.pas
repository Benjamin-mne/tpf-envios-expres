unit DAOenvio;

interface
    uses Envio; 

    function ObtenerSiguienteIdEnvio(): integer;
    procedure EscribirEnvioEnArchivo(envio : T_Envio);
    procedure LeerEnviosDesdeArchivo(var envios : T_Lista_Envio);
    procedure ActualizarEnvioEnArchivo(pos: integer; envioActualizado: T_Envio);

implementation
    uses SysUtils, DAOUtils;
    const RUTA = '../data/envio.dat';

    function ObtenerSiguienteIdEnvio(): integer;
    var 
        archivo : T_ARCHIVO_ENVIO;
    begin
        Assign(archivo, RUTA);
        ChechearCarpetaYArchivoExisten(RUTA, archivo);

        Reset(archivo);
        ObtenerSiguienteIdEnvio := FileSize(archivo) + 1;
        Close(archivo);
    end;


    procedure EscribirEnvioEnArchivo(envio : T_Envio);
    var 
        archivo : T_ARCHIVO_ENVIO;
    begin
        Assign(archivo, RUTA);
        ChechearCarpetaYArchivoExisten(RUTA, archivo);

        Reset(archivo);
        Seek(archivo, FileSize(archivo));
        Write(archivo, envio);
        Close(archivo);
    end;

    procedure LeerEnviosDesdeArchivo(var envios: T_Lista_Envio);
    var
        i: integer;
        archivo: T_ARCHIVO_ENVIO;
    begin
        Assign(archivo, RUTA);
        ChechearCarpetaYArchivoExisten(RUTA, archivo);

        Reset(archivo);

        SetLength(envios, FileSize(archivo));

        for i := 0 to Length(envios) - 1 do
            Read(archivo, envios[i]);

        Close(archivo);
    end;

    procedure ActualizarEnvioEnArchivo(pos: integer; envioActualizado: T_Envio);
    var
        archivo: T_ARCHIVO_ENVIO;
    begin
        Assign(archivo, RUTA);
        ChechearCarpetaYArchivoExisten(RUTA, archivo);

        Reset(archivo);
        Seek(archivo, pos);
        Write(archivo, envioActualizado);
        Close(archivo);
    end;
end.