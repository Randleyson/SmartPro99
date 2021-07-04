unit uModel.Dao.TV;

interface

uses
  uEntityTV,
  FireDAC.Comp.Client, uFiredac;

type
  TModelDaoTV = class
  private
    Firedac : TFiredac;
    FThis: TEntityTV;
    FDS_TVs: TFDMemTable;
    FDS_ProdutosNotTV: TFDMemTable;
    FDS_ProdutosCadTV: TFDMemTable;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: TModelDaoTV;
    function This: TEntityTV;
    function Recharge_DS_TVs: TModelDaoTV;
    function Recharge_DS_ProdutosNotTV: TModelDaoTV;
    function Recharge_DS_ProdutosCadTV: TModelDaoTV;
    function DS_TVs: TFDMemTable;
    function DS_ProdutosNotTV: TFDMemTable;
    function DS_ProdutosCadTV: TFDMemTable;

  end;

implementation

uses
  System.SysUtils, Data.DB, FireDAC.Comp.DataSet, uDm;

{ TModelDaoTV }

constructor TModelDaoTV.Create;
begin
  FThis := TEntityTV.New;
  FDS_TVs := TFDMemTable.Create(Nil);
  FDS_ProdutosNotTV := TFDMemTable.Create(Nil);
  FDS_ProdutosCadTV := TFDMemTable.Create(Nil);
end;

destructor TModelDaoTV.Destroy;
begin
  FThis.DisposeOf;
  inherited;
end;

function TModelDaoTV.DS_ProdutosCadTV: TFDMemTable;
begin
  Result := FDS_ProdutosCadTV;
end;

function TModelDaoTV.DS_ProdutosNotTV: TFDMemTable;
begin
  Result := FDS_ProdutosNotTV;
end;

function TModelDaoTV.DS_TVs: TFDMemTable;
begin
  Result := FDS_TVs;
end;

class function TModelDaoTV.New: TModelDaoTV;
begin
  Result := Self.Create;
end;

function TModelDaoTV.Recharge_DS_ProdutosCadTV: TModelDaoTV;
var
  vDataSet: TFDDataSet;
begin
  Result := Self;
  vDataSet := Firedac
                .Active(False)
                  .SQLClear
                  .SQL(' select codbarra, descricao,vrvenda, unidade from produtos ')
                  .SQL(' where codbarra in (select codproduto from tv_prod where codtv = :IDTV) ')
                  .SQL(' group by codbarra, descricao, vrvenda, unidade')
                .AddParan('IDTV',This.IDtv)
              .Open
              .DataSet;

  if FDS_ProdutosCadTV.Active then
  begin
    FDS_ProdutosCadTV.EmptyDataSet;
    FDS_ProdutosCadTV.Close;
  end;
  TFDMemTable(FDS_ProdutosCadTV).CloneCursor(vDataSet);
  FDS_ProdutosCadTV.Filtered := False;
end;

function TModelDaoTV.Recharge_DS_ProdutosNotTV: TModelDaoTV;
var
  vDataSet: TFDDataSet;
begin
  vDataSet := Firedac
                .Active(False)
                  .SQLClear
                  .SQL(' select codbarra, descricao,vrvenda,unidade from produtos p ')
                  .SQL(' where codbarra not in ')
                  .SQL(' (select codproduto from tv_prod where codtv = :IDTV) ')
                  .SQL(' group by codbarra,descricao,vrvenda,unidade')
                  .AddParan('IDTV',This.IDtv)
                .Open
              .DataSet;

  if FDS_ProdutosNotTV.Active then
  begin
    FDS_ProdutosNotTV.EmptyDataSet;
    FDS_ProdutosNotTV.Close;
  end;
  TFDMemTable(FDS_ProdutosNotTV).CloneCursor(vDataSet);
  FDS_ProdutosNotTV.Filtered := False;

end;

function TModelDaoTV.Recharge_DS_TVs: TModelDaoTV;
var
  vDataSet: TFDDataSet;
begin
  Result := Self;
  vDataSet := Firedac
                .Active(False)
                  .SQLClear
                  .SQL('select IdTv,Descricao from tvs')
                .Open
              .DataSet;

  if FDS_TVs.Active then
  begin
    FDS_TVs.EmptyDataSet;
    FDS_TVs.Close;
  end;
  TFDMemTable(DS_TVs).CloneCursor(vDataSet);
  FDS_TVs.Open;
  FDS_TVs.Filtered := False;
end;

function TModelDaoTV.This: TEntityTV;
begin
  Result := FThis;
end;

end.
