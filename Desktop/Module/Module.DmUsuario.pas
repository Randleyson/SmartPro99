unit Module.DmUsuario;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Controller.oUsuario;

type
  TDmUsuario = class(TDataModule)
    Qry_Usuario: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function GetUsuarioBD(oUsuario: ToUsuario): Boolean;
  end;

var
  DmUsuario: TDmUsuario;

implementation

uses
  Doa.DmConexaoSQL;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TDmUsuario }

function TDmUsuario.GetUsuarioBD(oUsuario: ToUsuario): Boolean;
var
  DmConexaoSQL: TDmConexaoSQL;
begin
  Result := True;

  DmConexaoSQL := TDmConexaoSQL.Create(Nil);
  try
    with Qry_Usuario do
    begin
      try
        Close;
        Connection := DmConexaoSQL.ConnectionSQL;
        Filtered := False;
        Filter := 'Login =' + QuotedStr(UpperCase(oUsuario.Login)) +
                  ' AND Senha = ' + QuotedStr(UpperCase(oUsuario.Senha));
        Filtered := True;
        Open;
        First;
        oUsuario.CodUsuario := FieldByName('IdUsuario').AsInteger;
        oUsuario.Nome := FieldByName('Nome').AsString;

      except
        raise

      end
    end;

  finally
    Qry_Usuario.Close;
    FreeAndNil(DmConexaoSQL);

  end;

end;

end.
