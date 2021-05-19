unit Doa.DmConexaoSQL;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, Vcl.Forms, FireDAC.Phys.FB, FireDAC.Phys.FBDef;

type
  TDmConexaoSQL = class(TDataModule)
    FDConnection: TFDConnection;
  private
    { Private declarations }
    procedure ConfigurarConexao;
  public
    { Public declarations }
    function ConnectionSQL: TFDConnection;
    function ExecutaSQL(pSQL: String): Boolean;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TDmConexaoSQL }

procedure TDmConexaoSQL.ConfigurarConexao;
begin

  try
    FDConnection.Connected := False;
    FDConnection.LoginPrompt := False;
    FDConnection.Params.Clear;
    FDConnection.Params.LoadFromFile(ExtractFileDir(application.ExeName) +
      '\Config.ini');
    FDConnection.Connected := True;

  except
    on E: Exception do
    begin
      raise Exception.Create('Não foi possivel Conectar ao banco de dados ' + sLineBreak +
        'Erro: '+ E.Message);
    end;

  end;

end;

function TDmConexaoSQL.ExecutaSQL(pSQL: String): Boolean;
begin

  try
    ConfigurarConexao;
    FDConnection.ExecSQL(pSQL);
    FDConnection.Commit;
    Result := True;
  except
    Raise;

  end;

end;


function TDmConexaoSQL.ConnectionSQL: TFDConnection;
begin

  ConfigurarConexao;
  Result := FDConnection;

end;

end.
