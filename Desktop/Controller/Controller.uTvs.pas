unit Controller.uTvs;

interface

uses
  FireDAC.Comp.Client, Controller.oTvs;

type
  TuTvs = class
  private
  public
    function CarergaDataSetTv(pFDMemTable: TFDMemTable): Boolean;
    function CarregaDataSetProdutos(pFDMemTable: TFDMemTable; pIdTv: Integer): Boolean;
    function CarregaDataSetProdTvs(pFDMemTable: TFDMemTable; pIdTv: Integer): Boolean;
    function InseriTv(oTvs: ToTvs; pDataSetProduto: TFDMemTable): Boolean;
    function UpdateTv(oTvs: ToTvs; pDataSetProduto: TFDMemTable): Boolean;
    function DeletarTv(oTvs: ToTvs): Boolean;


  end;

var
  uTvs: TuTvs;

implementation

{ TuTvs }

uses Controller.uFarctory;

function TuTvs.CarregaDataSetProdTvs
  (pFDMemTable: TFDMemTable; pIdTv: Integer): Boolean;
begin
  try
    Result := uFarctory.TvsDm.CarregaDataSetProdTvs(pFDMemTable,pIdTv);
  finally
    uFarctory.TvsDestroyDm;
  end;

end;

function TuTvs.CarregaDataSetProdutos
  (pFDMemTable: TFDMemTable; pIdTv: Integer): Boolean;
begin
  try
    Result := uFarctory.TvsDm.CarregaDataSetProdutos(pFDMemTable,pIdTv);
  finally
    uFarctory.TvsDestroyDm;
  end;
end;

function TuTvs.DeletarTv(oTvs: ToTvs): Boolean;
begin
  try
    Result := uFarctory.TvsDm.DeletarTv(oTvs);
  finally
    uFarctory.TvsDestroyDm;
  end;
end;

function TuTvs.UpdateTv(oTvs: ToTvs; pDataSetProduto: TFDMemTable): Boolean;
begin
  try
    Result := uFarctory.TvsDm.UpdateTv(oTvs,pDataSetProduto);
  finally
    uFarctory.TvsDestroyDm;
  end;

end;

function TuTvs.InseriTv(oTvs: ToTvs; pDataSetProduto: TFDMemTable): Boolean;
begin
  try
    Result := uFarctory.TvsDm.InseriTv(oTvs,pDataSetProduto);
  finally
    uFarctory.TvsDestroyDm;
  end;

end;

function TuTvs.CarergaDataSetTv
  (pFDMemTable: TFDMemTable): Boolean;
begin
  try
    Result := uFarctory.TvsDm.CarergaDataSetTv(pFDMemTable);
  finally
    uFarctory.TvsDestroyDm;
  end;

end;

end.
