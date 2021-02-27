unit Module.DmLogin;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Dao.ConexaoOracle,
  Controller.oLogin;

type
  TDmLogin= class(TDataModule)
    FDQueryLogin: TFDQuery;
    FDQueryEmpPermitida: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    DaoConexaoOracle: TConexaoOracle;
  public
    { Public declarations }
    function ValidaLogin(oLogin: ToLogin; out sErro: String): Boolean;
    function EmpresaPermitida(oLogin: ToLogin; out sErro: String): Boolean;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TDaoDmLogin }

function TDmLogin.EmpresaPermitida(oLogin: ToLogin;
  out sErro: String): Boolean;
var
  vSQL: String;
begin

  vSQL := 'SELECT CODEMPRESA,FANTASIA FROM GET_GESTAOMOBILE_LOGIN' +
    ' WHERE CODOPERADOR = :CodOperador';

  with FDQueryEmpPermitida do
  begin

    Connection := DaoConexaoOracle.FDConnOracle;
    try
      Close;
      SQL.Clear;
      SQL.Add(vSQL);

      ParamByName('CODOPERADOR').Value := oLogin.CodUsuario;

      Open;
      oLogin.EmpresaPermitida := FDQueryEmpPermitida;
      Result := True;
    except
      on E: Exception do
      begin
        sErro := E.Message;
        Result := False;
      end;

    end;

  end;

end;

function TDmLogin.ValidaLogin(oLogin: ToLogin; out sErro: String): Boolean;
var
  vSQL: string;
begin

  vSQL := 'SELECT CODOPERADOR, LOGIN, NOME, SENHA, RAZAOSOCIAL,CNPJ' +
    ' FROM GET_GESTAOMOBILE_LOGIN' + ' WHERE LOGIN = :Login ' +
    ' AND SENHA = :Senha ' + ' AND ROWNUM = 1';

  with FDQueryLogin do
  begin
    Connection := DaoConexaoOracle.FDConnOracle;
    Close;
    SQL.Clear;
    SQL.Add(vSQL);

    ParamByName('Login').Value := oLogin.Login;
    ParamByName('Senha').Value := oLogin.Senha;

    try
      Open;
      if RecordCount > 0 then
      begin
        Result := True;
        oLogin.CodUsuario := FieldByName('codoperador').AsInteger;
        oLogin.RazaoEmpresa := FieldByName('razaosocial').AsString;
        oLogin.Cnpj := FieldByName('cnpj').AsString;
        oLogin.NomeUsuario := FieldByName('nome').AsString;
      end
      else
      begin
        Result := False;
        sErro := 'Usuario o senha Invalida';
      end;

    except
      on E: Exception do
      begin
        Result := False;
        sErro := E.Message;
      end;
    end;

  end;
end;

procedure TDmLogin.DataModuleCreate(Sender: TObject);
begin
  DaoConexaoOracle := TConexaoOracle.Create(nil);
end;

procedure TDmLogin.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(DaoConexaoOracle);
end;

end.
