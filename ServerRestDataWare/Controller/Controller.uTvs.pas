unit Controller.uTvs;

interface

uses
  FireDAC.Comp.Client, Module.DmTvs;

type
  TuTvs = class
  private
    DmTvs: TDmTvs;
  public
    procedure ListarTvs(pDsListaTvs: TFDMemTable);
    procedure ListarProdutoTv(pDsListaProdutoTv: TFDMemTable; pIdTv: Integer);
  end;

implementation

uses
  System.SysUtils;

{ TuTvs }

procedure TuTvs.ListarProdutoTv(pDsListaProdutoTv: TFDMemTable; pIdTv: Integer);
begin
  DmTvs := TDmTvs.Create(Nil);
  try
    DmTvs.ListarProdutoTv(pDsListaProdutoTv,pIdTv);

  finally
    FreeAndNil(DmTvs);
  end;

end;

procedure TuTvs.ListarTvs(pDsListaTvs: TFDMemTable);
begin
  DmTvs := TDmTvs.Create(Nil);
  try
    DmTvs.ListarTvs(pDsListaTvs);

  finally
    FreeAndNil(DmTvs);
  end;

end;

end.
