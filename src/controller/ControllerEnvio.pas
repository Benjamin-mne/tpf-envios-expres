unit ControllerEnvio;

interface
    uses Envio, DAOenvio, SysUtils, Utils;

    procedure CrearEnvio(envio : T_Envio);
    procedure ObtenerTodosLosEnvios(var envios : T_Lista_Envio);
    procedure ObtenerEnvioPorId(var envios : T_Lista_Envio; id: integer; var pos: integer);
    function ActualizarEstadoEnvio(id: integer): boolean;
    function CancelarEnvio(id: integer): boolean;

implementation
    procedure CrearEnvio(envio : T_Envio);
    var 
        fechaActual: TDateTime;
    begin
        fechaActual := Date;

        envio.id:= ObtenerSiguienteIdEnvio();
        envio.estado:= EnPreparacion;
        envio.fecha:= FormatDateTime('dd/mm/yyyy', FechaActual);

        EscribirEnvioEnArchivo(envio);
    end;

    procedure ObtenerTodosLosEnvios(var envios : T_Lista_Envio);
    begin
        LeerEnviosDesdeArchivo(envios);
        OrdenarEnvioPorIdYNombreDestinatario(envios);
    end;
    
    procedure ObtenerEnvioPorId(var envios : T_Lista_Envio; id: integer; var pos: integer);
    begin
        LeerEnviosDesdeArchivo(envios);
        OrdenarEnvioPorId(envios);
        BuscarEnvioPorId_BBIN(envios, id, pos);
    end;

    function ActualizarEstadoEnvio(id: integer): boolean;
    var 
        pos: integer;
        envios: T_Lista_Envio; 

        procedure avanzarEnvio(var envio: T_Envio);
        begin
            if (envio.estado = EnPreparacion) then
                envio.estado := EnCamino
            else if (envio.estado = EnCamino) then
                envio.estado := EnDestino;
        end;

    begin
        LeerEnviosDesdeArchivo(envios);
        BuscarEnvioPorId_Secuencial(envios, id, pos);

        if (pos <> -1) and (envios[pos].estado <> EnDestino) and (envios[pos].estado <> Cancelado) then
        begin
            avanzarEnvio(envios[pos]);
            ActualizarEnvioEnArchivo(pos, envios[pos]);
            ActualizarEstadoEnvio := true;
        end
        else
            ActualizarEstadoEnvio := false;
    end;

    function CancelarEnvio(id: integer): boolean;
    var 
        pos: integer;
        envios: T_Lista_Envio; 
    begin
        LeerEnviosDesdeArchivo(envios);
        BuscarEnvioPorId_Secuencial(envios, id, pos);

        if (pos <> -1) and (envios[pos].estado = EnPreparacion) then
        begin
            envios[pos].estado:= Cancelado;
            ActualizarEnvioEnArchivo(pos, envios[pos]);
            CancelarEnvio := true;
        end
        else
            CancelarEnvio := false;
    end;
end.
