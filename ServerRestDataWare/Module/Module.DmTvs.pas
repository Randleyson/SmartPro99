unit Module.DmTvs;

interface

uses
  System.SysUtils, System.Classes, Dao.ConexaoDB, FireDAC.Comp.Client,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet;

type
  TDmTvs = class(TDataModule)
    QryListaTvs: TFDQuery;
    QryProdutosTv: TFDQuery;
  private
    { Private declarations }
    DaoConexaoDB: TDaoConexaoDB;
  public
    { Public declarations }
    procedure ListarTvs(pDsListaTvs: TFDMemTable);
    procedure ListarProdutoTv(pDsListaProdutoTv: TFDMemTable; pIdTv: Integer);
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TDmTvs }

procedure TDmTvs.ListarProdutoTv(pDsListaProdutoTv: TFDMemTable;
  pIdTv: Integer);
 var
  vSQL: String;
begin

  vSQL := ' select codbarra,descricao,vrvenda,unidade from produtos p'+
          ' left join tv_prod tp on tp.codproduto = p.codbarra'+
          ' where codtv = '+ IntToStr(pIdTv);

  DaoConexaoDB := TDaoConexaoDB.Create(Nil);
  try
    QryProdutosTv.Close;
    QryProdutosTv.Connection := DaoConexaoDB.FDConn;
    QryProdutosTv.SQL.Clear;
    QryProdutosTv.SQL.Text := vSQL;
    QryProdutosTv.Open();

    pDsListaProdutoTv.Close;
    pDsListaProdutoTv.CloneCursor(QryProdutosTv);

  finally
    QryProdutosTv.close;
    FreeAndNil(DaoConexaoDB);
  end;

end;

procedure TDmTvs.ListarTvs(pDsListaTvs: TFDMemTable);
var
  vSQL: String;
begin

  vSQL := 'select idtv,descricao from tvs';
  DaoConexaoDB := TDaoConexaoDB.Create(Nil);
  try
    QryListaTvs.Close;
    QryListaTvs.Connection := DaoConexaoDB.FDConn;
    QryListaTvs.SQL.Clear;
    QryListaTvs.SQL.Text := vSQL;
    QryListaTvs.Open();

    pDsListaTvs.Close;
    pDsListaTvs.CloneCursor(QryListaTvs);

  finally
    QryListaTvs.close;
    FreeAndNil(DaoConexaoDB);
  end;

end;

end.
