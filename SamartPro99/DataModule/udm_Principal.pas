unit udm_Principal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Comp.Client, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet;

type
  TDmPrincipal = class(TDataModule)
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
  DmPrincipal: TDmPrincipal;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses udm_Conexao, System.Variants, ufrm_Principal;

{$R *.dfm}

{ TDmPrincipal }

procedure TDmPrincipal.CloseFDQTemp;
begin

   if assigned(FDQTemp) then
   FreeAndNil(FDQTemp);

end;

procedure TDmPrincipal.CopyDataSet(pDataSetOrigen,pDataSetDestino: TDataSet);
begin

    try

      TFDMemTable(pDataSetDestino).CopyDataSet(pDataSetOrigen);

    except
      frmPrincipal.FMensagemErro := 'Erro ao AbreFMenTv';
      raise

    end;



end;

procedure TDmPrincipal.CreateFDQuerTemp(pSQL: string);
begin

  if not assigned(FDQTemp) then
  FDQTemp := TFDQuery.Create(self);

  FDQTemp.Close;
  FDQTemp.Connection  := DmConexao.FDC_Freeboard;
  FDQTemp.SQL.Text    := pSQL;

end;

procedure TDmPrincipal.ExcuteSQL(pSQL: string);
begin

  try
    try
      with DmConexao do
      begin

        AbreConexaoDb;
        FDC_Freeboard.ExecSQL(pSQL);
        FDC_Freeboard.Commit;

      end;

    except
      frmPrincipal.FMensagemErro := 'Erro ao ExcuteSQL';
      raise;

    end;

  finally
    DmConexao.FechaConexaoDb;
  end;

end;



procedure TDmPrincipal.FechaDataSet(pTDataSet: TDataSet);
begin

  try
    pTDataSet.Close;
  except
    raise
  end;

end;

function TDmPrincipal.IdTabela(pCampoChave, pTabela : String ): String;
var
  vSQL : String;
begin

   vSQL := 'select max('+ pCampoChave+ ')+1 id from '+ pTabela;
   Result := VarToStrDef(DmConexao.FDC_Freeboard.ExecSQLScalar(vSQL),'1');

end;


procedure TDmPrincipal.InseriPrimeiroConfig;
var
  vSQL: String;
begin
  vSQL := 'Insert into configuracao (idconfig) values (1)';

  try

    ExcuteSQL(vSQL);

  except
    frmPrincipal.fMensagemErro := 'Não foi possivel Inseri o primeiro config';
    raise

  end;

end;

procedure TDmPrincipal.GravarConfiguracao(pTipoArq, pCaminhoArq: string);
var
  vSQL : String;
begin

  vSQL := ' update configuracao                     '+
          ' set localarquivotxt = :localarquivotxt, '+
          ' tipoarquivotxt = :Tipoarquivotxt        ';

  try

    try

      DmPrincipal.CreateFDQuerTemp(vSQL);
      DmPrincipal.FDQTemp.ParamByName('Tipoarquivotxt').Value := pTipoArq;
      DmPrincipal.FDQTemp.ParamByName('localarquivotxt').Value  := UpperCase(pCaminhoArq);
      DmPrincipal.FDQTemp.ExecSQL;

    except
      frmPrincipal.fMensagemErro := 'Não foi possivel Salvar a alteracao no banco';
      raise

    end;

  finally
    DmPrincipal.CloseFDQTemp;

  end;
end;


function TDmPrincipal.LengthDescricao: integer;
var
  vSQL: string;
  vFQry: TFDQuery;
begin

  vSQL := 'select count(*) Qtde from produtos'+
          ' WHERE  char_length(replace(coalesce(DESCRICAOALTERADA,descricao),'+ QuotedStr(' ')+ ','+ QuotedStr('')+')) > 20';

  try

    try
      DmConexao.AbreConexaoDb;
      vFQry             := TFDQuery.Create(self);
      vFQry.Close;
      vFQry.Connection  := DmConexao.FDC_Freeboard;
      vFQry.SQL.Text    := vSQL;
      vFQry.Open;
      Result            := vFQry.FieldByName('Qtde').AsInteger;
      vFQry.Close;

    except
      raise;

    end;

  finally

    DmConexao.FechaConexaoDb;
    vFQry.Free;
  end;


end;

end.
