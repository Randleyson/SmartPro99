unit SmartPro99.Model.Produto;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Stan.StorageBin;

type
  TModelProduto = class(TDataModule)
    FQryProduto: TFDQuery;
    FMentProduto: TFDMemTable;
    FMentProdutoLENGHT: TIntegerField;
    FMentProdutoCODBARRA: TStringField;
    FMentProdutoDESCRICAO: TStringField;
    FMentProdutoVRVENDA: TFMTBCDField;
    FMentProdutoDESCRICAOALTERADA: TStringField;
    FMentProdutoEXISTENOARQ: TStringField;
    FMentProdutoUNIDADE: TStringField;
    FMentProdutoPROMOCAO: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure BdToFMentProduto;
    procedure UpdateProduto(pCodProd, pDescricao: String);

end;

var
  ModelProduto: TModelProduto;

implementation

uses
  SmartPro99.Model.Conexao, SmartPro99.Model.Principal,
  SmartPro99.View.Principal;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

procedure TModelProduto.BdToFMentProduto;
begin

  try
    try

      ModelConexao.AbreConexaoDb;
      FQryProduto.Close;
      FQryProduto.Open;

      FMentProduto.Close;
      FMentProduto.Open;
      FMentProduto.EmptyDataSet;
      ModelPrincipal.CopyDataSet(FQryProduto,FMentProduto);
      FMentProduto.Filtered := False;

    except
      ViewPrincipal.FMensagemErro := 'Erro ao excutar DbToFMentProduto';
      raise;
    end;

  finally
    FQryProduto.Close;
    ModelConexao.FechaConexaoDb;

  end;
end;

procedure TModelProduto.UpdateProduto(pCodProd, pDescricao: String);
var
  vSQL : String;

begin

  if pDescricao =  '' then
  vSQL := 'update produtos set descricaoalterada = null' +
          ' where codbarra = '+ QuotedStr(pCodProd)
  else
  vSQL := 'update produtos set descricaoalterada = ' +  QuotedStr(UpperCase(pDescricao))+
          ' where codbarra = '+ QuotedStr(pCodProd);

  try

    ModelPrincipal.ExcuteSQL(vSQL);

  except
    ViewPrincipal.FMensagemErro := 'Erro ao executar UpdateProduto';
    raise;

  end;

end;

end.
