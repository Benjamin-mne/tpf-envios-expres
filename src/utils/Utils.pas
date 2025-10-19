unit Utils;

interface
    uses Envio;
    procedure OrdenarEnvioPorId(var envios : T_Lista_Envio);
    procedure BuscarEnvioPorId(var envios : T_Lista_Envio; id: integer; var pos: integer);

implementation
    procedure OrdenarEnvioPorId(var envios : T_Lista_Envio);
    var 
        i, j : integer;
        aux : T_Envio;
    begin
        for i := 0 to (Length(envios) - 2) do
            for j := 0 to (Length(envios) - (i + 2)) do
                if (envios[j].id > envios[j + 1].id) then
                begin
                    aux := envios[j];
                    envios[j] := envios[j + 1];
                    envios[j + 1] := aux;
                end;
    end;

    procedure BuscarEnvioPorId(var envios : T_Lista_Envio; id: integer; var pos: integer);
    var 
        pri, ult, med: integer;
    begin
        pos := -1;
        pri := 0;
        ult := Length(envios) - 1;

        while (pos = -1) and (pri <= ult) do
        begin
            med := (pri + ult) div 2;

            if (id = envios[med].id) then
                pos := med
            else if (id > envios[med].id) then
                pri := med + 1
            else
                ult := med - 1;
        end;
    end;


end.
