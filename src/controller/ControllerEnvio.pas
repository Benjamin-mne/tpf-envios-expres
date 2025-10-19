unit ControllerEnvio;

interface
    uses Envio, DAOenvio, SysUtils;

    procedure CrearEnvio(envio : T_Envio);
    procedure ObtenerTodosLosEnvios(var envios : T_Lista_Envio);
    procedure ObtenerEnvioPorId();
    procedure ActualizarEstadoEnvio();

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
    end;
    
    procedure ObtenerEnvioPorId();
    begin
    end;

    procedure ActualizarEstadoEnvio();
    begin
    end;
end.
