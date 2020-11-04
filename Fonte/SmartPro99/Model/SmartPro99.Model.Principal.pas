unit SmartPro99.Model.Principal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Comp.Client, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet;

type
  TModelPrincipal = class(TDataModule)
    FQryConfig: TFDQuery;
  private

    { Private declarations }
  public
    { Public declarations }
    FDQTemp: TFDQuery;
    procedure ExcuteSQL(pSQL: string);
    procedure FechaDataSet(pTDataSet: TDataSet);
    function IdTabela(pCampoChave, pTabela : String ): String;
    procedure CreateFDQuerTemp(pSQL: string);
    procedure CloseFDQTemp;
    procedure CopyDataSet(pDataSetOrigen,pDataSetDestino: TDataSet);
    function LengthDescricao: integer;

    {CONFIGURACAO}
    procedure InseriPrimeiroConfig;
    procedure GravarConfiguracao(pTipoArq,pCaminhoArq: string);

  end;

var
  ModelPrincipal: TModelPrincipal;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses System.Variants, SmartPro99.View.Principal, SmartPro99.Model.Conexao;

{$R *.dfm}

{ TDmPrincipal }

procedure TModelPrincipal.CloseFDQTemp;
begin

   if assigned(FDQTemp) then
   FreeAndNil(FDQTemp);

end;

procedure TModelPrincipal.CopyDataSet(pDataSetOrigen,pDataSetDestino: TDataSet);
begin

    try

      TFDMemTable(pDataSetDestino).CopyDataSet(pDataSetOrigen);

    except
      ViewPrincipal.FMensagemErro := 'Erro ao AbreFMenTv';
      raise

    end;



end;

procedure TModelPrincipal.CreateFDQuerTemp(pSQL: string);
begin

  if not assigned(FDQTemp) then
  FDQTemp := TFDQuery.Create(self);

  FDQTemp.Close;
  FDQTemp.Connection  := ModelConexao.FDC_Freeboard;
  FDQTemp.SQL.Text    := pSQL;

end;

procedure TModelPrincipal.ExcuteSQL(pSQL: string);
begin

  try
    try
      with ModelConexao do
      begin

        AbreConexaoDb;
        FDC_Freeboard.ExecSQL(pSQL);
        FDC_Freeboard.Commit;

      end;

    except
      ViewPrincipal.FMensagemErro := 'Erro ao ExcuteSQL';
      raise;

    end;

  finally
    ModelConexao.FechaConexaoDb;
  end;

end;



procedure TModelPrincipal.FechaDataSet(pTDataSet: TDataSet);
begin

  try
    pTDataSet.Close;
  except
    raise
  end;

end;

function TModelPrincipal.IdTabela(pCampoChave, pTabela : String ): String;
var
  vSQL : String;
begin

   vSQL := 'select max('+ pCampoChave+ ')+1 id from '+ pTabela;
   Result := VarToStrDef(ModelConexao.FDC_Freeboard.ExecSQLScalar(vSQL),'1');

end;


procedure TModelPrincipal.InseriPrimeiroConfig;
var
  vSQL: String;
begin
  vSQL := 'Insert into configuracao (idconfig,TIPOARQUIVOTXT) values (1,1)';

  try

    ExcuteSQL(vSQL);

  except
    ViewPrincipal.fMensagemErro := 'Não foi possivel Inseri o primeiro config';
    raise

  end;

end;

procedure TModelPrincipal.GravarConfiguracao(pTipoArq, pCaminhoArq: string);
var
  vSQL : String;
begin

  vSQL := ' update configuracao                     '+
          ' set localarquivotxt = :localarquivotxt, '+
          ' tipoarquivotxt = :Tipoarquivotxt        ';

  try

    try

      CreateFDQuerTemp(vSQL);
      FDQTemp.ParamByName('Tipoarquivotxt').Value := pTipoArq;
      FDQTemp.ParamByName('localarquivotxt').Value  := UpperCase(pCaminhoArq);
      FDQTemp.ExecSQL;

    except
      ViewPrincipal.fMensagemErro := 'Não foi possivel Salvar a alteracao no banco';
      raise

    end;

  finally
    CloseFDQTemp;

  end;
end;


function TModelPrincipal.LengthDescricao: integer;
var
  vSQL: string;
  vFQry: TFDQuery;
begin

  vSQL := 'select count(*) Qtde from produtos'+
          ' WHERE  char_length(replace(coalesce(DESCRICAOALTERADA,descricao),'+ QuotedStr(' ')+ ','+ QuotedStr('')+')) > 20';

  try

    try
      ModelConexao.AbreConexaoDb;
      vFQry             := TFDQuery.Create(self);
      vFQry.Close;
      vFQry.Connection  := ModelConexao.FDC_Freeboard;
      vFQry.SQL.Text    := vSQL;
      vFQry.Open;
      Result            := vFQry.FieldByName('Qtde').AsInteger;
      vFQry.Close;

    except
      raise;

    end;

  finally

    ModelConexao.FechaConexaoDb;
    vFQry.Free;
  end;


end;

end.
