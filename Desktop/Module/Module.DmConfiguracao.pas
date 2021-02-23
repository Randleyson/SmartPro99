unit Module.DmConfiguracao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Controller.oConfiguracao;

type
  TDmConfiguracao = class(TDataModule)
    Qry_GetConfiguracao: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function CarregaConfiguracaoDB(oConfiguracao: ToConfiguracao): Boolean;
    function GravaAlteracaoDb(oConfiguracao: ToConfiguracao): Boolean;
  end;

implementation

uses
  Doa.DmConexaoSQL, Controller.uSmartPro99;

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TDmConfiguracao }

function TDmConfiguracao.CarregaConfiguracaoDB(oConfiguracao
  : ToConfiguracao): Boolean;
var
  DmConexaoSQL: TDmConexaoSQL;
begin

  Result := True;
  DmConexaoSQL := TDmConexaoSQL.Create(Nil);
  try
    try
      with Qry_GetConfiguracao do
      begin
        Close;
        Connection := DmConexaoSQL.ConnectionSQL;
        Open;
        First;
        oConfiguracao.PadraoArquivo := FieldByName('PadraoArquivo').AsString;
        oConfiguracao.LocalArquivo := FieldByName('LocalArquivo').AsString;

      end;

    Except
      Qry_GetConfiguracao.Close;
      raise;

    end;

  finally
    Qry_GetConfiguracao.Close;
    FreeAndNil(DmConexaoSQL);

  end;

end;

function TDmConfiguracao.GravaAlteracaoDb(oConfiguracao: ToConfiguracao): Boolean;
var
  DmConexaoSQL: TDmConexaoSQL;
  vSQL: String;
begin

  vSQL :=  'Update Configuracao set PadraoArquivo = :PADRAOARQUIVO,' +
           ' LocalArquivo = :LOCALARQUIVO';

  vSQL := TuSmartPro99.SubstituirString
    (vSQL,':PADRAOARQUIVO',QuotedStr(oConfiguracao.NewPadraoArquivo));
  vSQL := TuSmartPro99.SubstituirString
    (vSQL,':LOCALARQUIVO',QuotedStr(oConfiguracao.NewLocalArquivo));

  Result := True;
  DmConexaoSQL := TDmConexaoSQL.Create(Nil);
  try
    try
     DmConexaoSQL.ConnectionSQL.ExecSQL(vSQL);
     DmConexaoSQL.ConnectionSQL.Commit;

    Except
      raise;
    end;

  finally
    FreeAndNil(DmConexaoSQL);

  end;


end;

end.
