unit Menu;

interface
    procedure AgregarEnvio();
    procedure ListarEnvios();
    procedure BuscarEnvio();
    procedure IniciarVistas();
    procedure AvanzarEstadoEnvio();
    procedure CancelarEnvioVista();

implementation
    uses crt, Envio, ControllerEnvio, TestUtils, SysUtils, ViewUtils;

    procedure AgregarEnvio();
    var 
        envio: T_Envio;
        destinatario: T_Destinatario;
        input: string;
    begin
        ClrScr;
        Writeln('====== AGREGAR ENVIO ======');

        Writeln('--- DESTINATARIO ---');
        Write('Nombre: ');
        Readln(destinatario.nombre);
        Write('DNI: '); 
        Readln(destinatario.dni);

        envio.destinatario := destinatario;

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

        CrearEnvio(envio);
        Writeln('Envio agregado correctamente.');
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
    end;

    procedure IniciarVistas();
    var 
        input: string;
        OPOP: longint;

        opciones : V_Opciones;
        tecla, op: integer;
    begin
        ClrScr;
        AgregarOpcion(opciones, 'Agregar envio');
        AgregarOpcion(opciones, 'Listar envios');
        AgregarOpcion(opciones, 'Buscar envio');
        AgregarOpcion(opciones, 'Avanzar estado de envio');
        AgregarOpcion(opciones, 'Cancelar envio');
        AgregarOpcion(opciones, 'Generar datos para probar el programa.');
        AgregarOpcion(opciones, 'Salir');

        op := 0;
        repeat  
            MostrarMenu(opciones, op); 
            tecla:= DetectarTecla(); 

            case tecla of 
                72: // Arriba
                if (op > 0) then 
                    op:=op-1
                else 
                    op:= Length(opciones) - 1;
                80: // Abajo
                if (op < Length(opciones) - 1) then
                    op:=op+1 
                else
                    op:= 0;
                13: // Enter
                begin 
                    case op of 
                        0: 
                        begin 
                            Clrscr; 
                            AgregarEnvio(); 
                            ContinuarMenu;
                        end; 
                        1: 
                        begin 
                            Clrscr; 
                            ListarEnvios();
                            ContinuarMenu;
                        end; 
                        2: 
                        begin 
                            Clrscr; 
                            BuscarEnvio();
                            ContinuarMenu;
                        end;
                        3: 
                        begin 
                            Clrscr; 
                            AvanzarEstadoEnvio();
                            ContinuarMenu;
                        end;
                        4: 
                        begin 
                            Clrscr; 
                            CancelarEnvioVista();
                            ContinuarMenu;
                        end;
                        5: 
                        begin 
                            Clrscr; 
                            GenerarDataDePrueba();
                            Writeln('Se han generado 10 envios.');
                            ContinuarMenu;
                        end;
                        6: 
                        begin 
                            Clrscr; 
                            Writeln('Saliendo...');
                            ContinuarMenu;
                        end;
                    end; 
                end; 
            end;
        until (op = 6) and (tecla = 13);
    end;
end.
