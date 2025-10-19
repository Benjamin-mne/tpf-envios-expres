unit Menu;

interface
    procedure AgregarEnvio();
    procedure ListarEnvios();
    procedure MostrarMenu();

implementation
    uses crt, Envio, ControllerEnvio;

    procedure AgregarEnvio();
    var 
        envio: T_Envio;
        destinatario: T_Destinatario;
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

        Write('Peso (kg): ');
        Readln(envio.peso);

        Write('Costo ($): ');
        Readln(envio.costo);

        // --- Guardar en archivo ---
        CrearEnvio(envio);

        Writeln('Envio agregado correctamente.');
        Write('Presione cualquier tecla para continuar...');
        Readkey;
    end;

    procedure MostrarEnvio(envio : T_Envio);
    begin
        with envio do
        begin
            Writeln(' ');
            Writeln('Codigo de envio: ', id);
            Writeln('DNI del destinatario: ', destinatario.dni);
            Writeln('Nombre del destinatario: ', destinatario.nombre);
            Writeln('Ciudad destino: ', ciudad_destino);
            Writeln('Estado envio: ', estado);
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

    procedure MostrarMenu();
    var OP: byte;
    begin
        repeat
            ClrScr;
            Writeln('1. Agregar envio');
            Writeln('2. Listar envios');
            Writeln('0. Salir');
            Write('Opcion: ');
            Readln(OP);

            case OP of
                1: AgregarEnvio();
                2: ListarEnvios();
                0: Writeln('Saliendo...');
            end;
        until (OP = 0);
    end;
end.
