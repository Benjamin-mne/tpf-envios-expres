unit Menu;

interface
    procedure AgregarEnvio();
    procedure ListarEnvios();
    procedure BuscarEnvio();
    procedure MostrarMenu();
    procedure AvanzarEstadoEnvio();
    procedure CancelarEnvioVista();

implementation
    uses crt, Envio, ControllerEnvio, TestUtils, SysUtils;

    procedure AgregarEnvio();
    var 
        envio: T_Envio;
        destinatario: T_Destinatario;
        input: string;
    begin
        ClrScr;
        Writeln('====== AGREGAR ENVIO ======');

        // --- Datos del destinatario ---
        Writeln('--- DESTINATARIO ---');
        Write('Nombre: ');
        Readln(destinatario.nombre);
        Write('DNI: '); 
        Readln(destinatario.dni);

        envio.destinatario := destinatario;

        // --- Datos del envio ---
        Writeln('--- ENVIO ---');
        Write('Ciudad destino: ');
        Readln(envio.ciudad_destino);

        repeat
            Write('Peso (kg): ');
            Readln(input);
        until TryStrToFloat(input, envio.peso);

        repeat
            Write('Costo ($): ');
            Readln(input);
        until TryStrToFloat(input, envio.costo);

        // --- Guardar en archivo ---
        CrearEnvio(envio);

        Writeln('Envio agregado correctamente.');
        Write('Presione cualquier tecla para continuar...');
        Readkey;
    end;

    procedure MostrarEnvio(envio : T_Envio);
        function FormatearEstado(estado : E_Estado): string;
        begin
            if (estado = EnPreparacion) then
                FormatearEstado:= 'En preparacion'
            else if (estado = EnCamino) then 
                FormatearEstado:= 'En camino'
            else if (estado = EnDestino) then 
                FormatearEstado:= 'En Destino'
            else 
                FormatearEstado:= 'Cancelado';
        end;
    begin
        with envio do
        begin
            Writeln(' ');
            Writeln('Codigo de envio: ', id);
            Writeln('DNI del destinatario: ', destinatario.dni);
            Writeln('Nombre del destinatario: ', destinatario.nombre);
            Writeln('Ciudad destino: ', ciudad_destino);
            Writeln('Estado envio: ', FormatearEstado(estado));
            Writeln('Peso del paquete: ', peso:0:2);
            Writeln('Costo del envio: ', costo:0:2);
            Writeln('Fecha: ', fecha);
        end;
    end;

    procedure ListarEnvios();
    var 
        envios : T_Lista_Envio;
        i : integer;
    begin
        ObtenerTodosLosEnvios(envios);
        for i:= 0 to Length(envios) - 1 do
            MostrarEnvio(envios[i]);
        
        Readkey;
    end;

    procedure BuscarEnvio();
    var 
        envios : T_Lista_Envio; 
        id : longint;
        pos : integer; 
        input: string;
    begin
        repeat
            Write('Ingrese id de envio: ');
            Readln(input);
        until TryStrToInt(input, id);

        ObtenerEnvioPorId(envios, id, pos);
        if (pos <> -1) then 
            MostrarEnvio(envios[pos])
        else 
            Writeln('No se encontro un envio con el id ingresado.');
        
        Readkey;
    end;

    procedure AvanzarEstadoEnvio();
    var 
        id : longint;
        input: string;
    begin
        repeat
            Write('Ingrese id del envio: ');
            Readln(input);
        until TryStrToInt(input, id);

        if(ActualizarEstadoEnvio(id)) then
            Writeln('Estado del envio actualizado con exito.')
        else 
            Write('El envio no existe o ya esta en su destino.');
        
        Readkey;
    end;

    procedure CancelarEnvioVista();
    var 
        id : longint;
        input: string;
    begin
        repeat
            Write('Ingrese id del envio: ');
            Readln(input);
        until TryStrToInt(input, id);

        if(CancelarEnvio(id)) then
            Writeln('El envio se ha cancelado con exito.')
        else 
            Write('El envio no existe o no es posible cancelarlo en esta etapa.');
        Readkey;
    end;

   procedure MostrarMenu();
    var 
        input: string;
        OP: longint;
    begin
        repeat
            ClrScr;
            Writeln('1. Agregar envio');
            Writeln('2. Listar envios');
            Writeln('3. Buscar envio');
            Writeln('4. Avanzar estado de envio');
            Writeln('5. Cancelar envio');
            Writeln('0. Salir');
            Writeln('');
            Writeln('99. Generar data de prueba');
            
            Write('Opcion: ');
            Readln(input);

            if not TryStrToInt(input, OP) then
            begin
                OP:= -1;
                Continue;
            end;

            case OP of
                1: AgregarEnvio();
                2: ListarEnvios();
                3: BuscarEnvio();
                4: AvanzarEstadoEnvio();
                5: CancelarEnvioVista();
                99: GenerarDataDePrueba();
                0: Writeln('Saliendo...');
            end;
        until OP = 0;
    end;
end.
