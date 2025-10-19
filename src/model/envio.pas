unit Envio;

interface
    type
        T_Destinatario = record
            dni: string[10];
            nombre: string[60];
        end;

        E_Estado = (EnPreparacion, EnCamino, EnDestino, Cancelado);

        T_Envio = record 
            id: integer;
            destinatario: T_Destinatario;
            ciudad_destino: string[30];
            estado: E_Estado;
            peso: real;
            costo: real;
            fecha: string[10];
        end;

        T_Lista_Envio = array of T_Envio;

implementation
begin
end.