unit ControllerEnvio;

interface
    uses Envio, DAOenvio;

    procedure CrearEnvio(envio : T_Envio);
    procedure ObtenerTodosLosEnvios(var envios : T_Lista_Envio);
    procedure ObtenerEnvioPorId();
    procedure ActualizarEstadoEnvio();

implementation
    procedure CrearEnvio(envio : T_Envio);
    begin
        envio.id:= 'todo: randomId';
        envio.estado:= EnPreparacion;
        envio.fecha:= 'todo:ooo';

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
