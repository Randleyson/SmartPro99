unit Controller.uUsuario;

interface

uses
  Controller.oUsuario;

type
  TuUsuario = class
  private
  public
    function GetUsuarioBD(oUsuario: ToUsuario): Boolean;
    class function New: TuUsuario;
  end;

implementation

uses
  System.SysUtils, Module.DmUsuario;

{ TuUsuario }

function TuUsuario.GetUsuarioBD(oUsuario: ToUsuario): Boolean;
var
  DmUsuario: TDmUsuario;
begin

  DmUsuario := TDmUsuario.Create(nil);
  try
    Result := DmUsuario.GetUsuarioBD(oUsuario);

  finally
    FreeAndNil(DmUsuario);

  end;

end;

class function TuUsuario.New: TuUsuario;
begin
  Result := TuUsuario.Create;

end;

end.
