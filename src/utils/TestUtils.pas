unit TestUtils;

interface
    uses Envio, ControllerEnvio, SysUtils;

    procedure GenerarDataDePrueba();

implementation

    procedure GenerarDataDePrueba();
    const
        CANTIDAD = 10;
        NOMBRES: array[0..4] of string = ('Juan', 'Ana', 'Pedro', 'Lucia', 'Carlos');
        APELLIDOS: array[0..4] of string = ('Perez', 'Gomez', 'Rodriguez', 'Fernandez', 'Lopez');
        CIUDADES: array[0..4] of string = ('Concepcion del Uruguay', 'Gualeguaychu', 'San Jose', 'Colon', 'Urdinarrain');
    var
        envios: T_Lista_Envio;
        i, idxNombre, idxApellido, idxCiudad: integer;
        destinatario: T_Destinatario;
    begin
        Randomize;
        SetLength(envios, CANTIDAD);

        for i := 0 to CANTIDAD - 1 do
        begin
            idxNombre := Random(Length(NOMBRES));
            idxApellido := Random(Length(APELLIDOS));
            idxCiudad := Random(Length(CIUDADES));

            destinatario.nombre := NOMBRES[idxNombre] + ' ' + APELLIDOS[idxApellido];
            destinatario.dni := Format('%08d', [10000000 + Random(90000000)]);

            envios[i].destinatario := destinatario;
            envios[i].ciudad_destino := CIUDADES[idxCiudad];
            envios[i].peso := 1 + Random(50);
            envios[i].costo := envios[i].peso * (50 + Random(50));

            CrearEnvio(envios[i]);
        end;
    end;
end.
