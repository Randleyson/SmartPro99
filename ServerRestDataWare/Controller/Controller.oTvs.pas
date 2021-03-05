unit Controller.oTvs;

interface

uses
  FireDAC.Comp.Client;

type
  ToTvs = class
  private
    FDsListaTvs: TFDMemTable;
    FDsListaProdutoTv: TFDMemTable;
    FIdTv: Integer;
    function GetDsListaTvs: TFDMemTable;
    function GetListarProdutosTv: TFDMemTable;
  public
    property IdTv: Integer read FIdTv write FIdTv;
    property DataSetListaTvs: TFDMemTable read GetDsListaTvs write FDsListaTvs;
    property DataSetProdutosTv: TFDMemTable read GetListarProdutosTv
      write FDsListaProdutoTv;
    Destructor Destroy; override;
  end;

implementation

{ ToTvs }

uses Controller.uTvs, System.SysUtils;

destructor ToTvs.Destroy;
begin
  FDsListaTvs.Close;
  FreeAndNil(FDsListaTvs);
  inherited;
end;

function ToTvs.GetDsListaTvs: TFDMemTable;
var
  uTvs: TuTvs;
begin

  uTvs := TuTvs.Create;
  FDsListaTvs := TFDMemTable.Create(nil);
  try
    uTvs.ListarTvs(FDsListaTvs);

  finally
    FreeAndNil(uTvs);
    Result := FDsListaTvs;
  end;

end;

function ToTvs.GetListarProdutosTv: TFDMemTable;
var
  uTvs: TuTvs;
begin

  uTvs := TuTvs.Create;
  FDsListaProdutoTv := TFDMemTable.Create(nil);
  try
    uTvs.ListarProdutoTv(FDsListaProdutoTv,IdTv);

  finally
    FreeAndNil(uTvs);
    Result := FDsListaProdutoTv;
  end;

end;

end.
