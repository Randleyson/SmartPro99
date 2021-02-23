unit Controller.oUsuario;

interface

type
  ToUsuario = class
  private
    FLogin: String;
    FSenha: String;
    FCodUsuario: Integer;
    FNome: String;
  public
    property Login: String read FLogin write FLogin;
    property Senha: String read FSenha write FSenha;
    property CodUsuario: Integer read FCodUsuario write FCodUsuario;
    property Nome: String read FNome write FNome;

    function ValidaLogin: Boolean;
  end;
var
  oUsuario : ToUsuario;

implementation

uses
  System.SysUtils, Controller.uUsuario;

{ ToUsuario }

function ToUsuario.ValidaLogin: Boolean;
begin

  try
    TuUsuario.New.GetUsuarioBD(oUsuario);

    if CodUsuario <> 0 then
      Result := True
    else
      Result := False;

  except
    raise
  end;


end;

end.
