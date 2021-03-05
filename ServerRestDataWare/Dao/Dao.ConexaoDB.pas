unit Dao.ConexaoDB;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.Oracle,
  FireDAC.Phys.OracleDef, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, StrUtils,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase;

type
  TDaoConexaoDB = class(TDataModule)
    FDConn: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    function ConfigurarConexao: Boolean;
    function ExcecutarSQL(pSQL: String; out sErro: String): Boolean;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

{ TConexaoOracle }
uses
  View.FrmPrincipal, Controller.oConfiguracao;

function TDaoConexaoDB.ConfigurarConexao: Boolean;
var
  vDatabase: String;
begin

  with oConfiguracao do
  begin
    case AnsiIndexStr(UpperCase(DriverDB), ['ORA', 'FB']) of
      0:
        vDatabase := '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=' + IpDB + ')' +
          '(PORT=' + PortaDB + '))(CONNECT_DATA=(SERVICE_NAME=' +
          BancoDB + ')))';
      1:
        vDatabase := IpDB + ':' + PastaDB + '\' + BancoDB;
    end;

  end;

  try
    try

      FDConn.Connected := False;
      FDConn.LoginPrompt := False;
      FDConn.Params.Clear;
      FDConn.Params.values['OpenMode'] := 'ReadWrite';
      FDConn.Params.values['LockingMode'] := 'Normal';
      FDConn.Params.values['DriverID'] := oConfiguracao.DriverDB;
      FDConn.Params.values['User_Name'] := oConfiguracao.UsuarioDB;
      FDConn.Params.values['Password'] := oConfiguracao.SenhaDB;
      FDConn.Params.values['Database'] := vDatabase;

      FDConn.Connected := True;
      FDConn.Connected := False;
      Result := True;

    except
      on E: Exception do
      begin
        FrmPrincipal.MmLogs.Lines.Add
          ('Não foi possivel conectar o banco de dados');
        FDConn.Connected := False;
        Result := False;
      end;
    end;

  finally
    FDConn.Connected := False;
  end;

end;

procedure TDaoConexaoDB.DataModuleCreate(Sender: TObject);
var
  oConfiguracao: ToConfiguracao;
  sErro: string;
begin

  oConfiguracao := ToConfiguracao.Create;
  try
    oConfiguracao.CarregaConfigIni;
    ConfigurarConexao;

  finally
    FreeAndNil(oConfiguracao);
  end;

end;

function TDaoConexaoDB.ExcecutarSQL(pSQL: String; out sErro: String): Boolean;
begin

  try
    FDConn.ExecSQL(pSQL);
    FDConn.Commit;
    Result := True

  except
    on E: Exception do
    begin
      Result := False;
      sErro := E.Message;
    end;

  end;

end;

end.
