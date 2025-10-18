unit DAOUtils; 

interface
    uses Envio; 
    type T_ARCHIVO_ENVIO = file of T_Envio;

    procedure CrearCarpetaSiNoExiste(RUTA : string);
    procedure CrearArchivoEnvioSiNoExiste(RUTA : string; var archivo : T_ARCHIVO_ENVIO);
    procedure ChechearCarpetaYArchivoExisten(RUTA : string; var archivo : T_ARCHIVO_ENVIO);


implementation
    uses SysUtils;

    procedure CrearCarpetaSiNoExiste(RUTA : string);
    var 
        carpeta: string;
    begin
        carpeta := ExtractFilePath(RUTA);
        
        if not DirectoryExists(carpeta) then
            CreateDir(carpeta);
    end;

    procedure CrearArchivoEnvioSiNoExiste(RUTA : string; var archivo : T_ARCHIVO_ENVIO);
    begin
        if not FileExists(RUTA) then
            Rewrite(archivo);
    end;

    procedure ChechearCarpetaYArchivoExisten(RUTA : string; var archivo : T_ARCHIVO_ENVIO);
    begin
        CrearCarpetaSiNoExiste(RUTA);
        CrearArchivoEnvioSiNoExiste(RUTA, archivo);
    end;

end.