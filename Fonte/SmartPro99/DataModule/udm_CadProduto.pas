unit udm_CadProduto;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Stan.StorageBin;

type
  TdmCadProduto = class(TDataModule)
    FQryProduto: TFDQuery;
    FMentProduto: TFDMemTable;
    FMentProdutoLENGHT: TIntegerField;
    FMentProdutoCODBARRA: TStringField;
    FMentProdutoDESCRICAO: TStringField;
    FMentProdutoVRVENDA: TFMTBCDField;
    FMentProdutoDESCRICAOALTERADA: TStringField;
    FMentProdutoEXISTENOARQ: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure BdToFMentProduto;
    procedure UpdateProduto(pCodProd, pDescricao: String);

end;

var
  dmCadProduto: TdmCadProduto;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses udm_Conexao, udm_Principal, ufrm_Principal;

{$R *.dfm}

{ TDataModule1 }

procedure TdmCadProduto.BdToFMentProduto;
begin

  try
    try

      DmConexao.AbreConexaoDb;
      FQryProduto.Close;
      FQryProduto.Open;

      FMentProduto.Close;
      FMentProduto.Open;
      FMentProduto.EmptyDataSet;
      DmPrincipal.CopyDataSet(FQryProduto,FMentProduto);
      FMentProduto.Filtered := False;
    except
      frmPrincipal.FMensagemErro := 'Erro ao excutar DbToFMentProduto';
      raise;
    end;

  finally
    FQryProduto.Close;
    DmConexao.FechaConexaoDb;

  end;
end;

procedure TdmCadProduto.UpdateProduto(pCodProd, pDescricao: String);
var
  vSQL : String;
begin

  vSQL := 'update produtos set descricaoalterada = '+ QuotedStr(UpperCase(pDescricao))+
          ' where codbarra = '+ QuotedStr(pCodProd);

  try

    DmPrincipal.ExcuteSQL(vSQL);

  except
    frmPrincipal.FMensagemErro := 'Erro ao executar UpdateProduto';
    raise;

  end;

end;

end.
