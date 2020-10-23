unit Dm_Produtos;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmProduto = class(TDataModule)
    FDQProdutos: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InsertProduto(pCod,pDescri,pVrVenda: string);
    procedure DeleteFromProduto;
  end;

var
  dmProduto: TdmProduto;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Dm_Principal;

{$R *.dfm}

{ TdmProduto }

procedure TdmProduto.DeleteFromProduto;
begin

  DmPrincipal.FDC_Freeboard.ExecSQL('Delete from produtos');
  DmPrincipal.FDC_Freeboard.Commit;

end;

procedure TdmProduto.InsertProduto(pCod, pDescri, pVrVenda: string);
var
  vSql: String;
begin

  vSql := 'Insert into produtos (CODPRODUTO,DESCRICAO,VRVENDA)'+
          ' values('+ QuotedStr(pCod) +','+ QuotedStr(UpperCase(pDescri)) +
          ','+ StringReplace(pVrVenda,',','.',[rfReplaceAll])+')';

  DmPrincipal.FDC_Freeboard.ExecSQL(vSql);
  DmPrincipal.FDC_Freeboard.Commit;

end;

end.
