unit Controller.uProduto;

interface

uses
  Controller.oProduto;

type
  TControllerProduto = class
  private
  public
    function CarregaProduto(oProduto: ToProduto; sErro: String): Boolean;
    function InsertEtiqueta(pCodOperador: Integer; oProduto: ToProduto;
      sErro: String): Boolean;
  end;

implementation

uses
  Dao.ConexaoOracle, System.SysUtils, Module.DmProduto;

{ TControllerProduto }

function TControllerProduto.CarregaProduto(oProduto: ToProduto;
  sErro: String): Boolean;
var
  DaoProduto: TDmProduto;
begin

  DaoProduto := TDmProduto.Create(nil);
  try
    Result := DaoProduto.CarregaProduto(oProduto, sErro);

  finally
    FreeAndNil(DaoProduto);
  end;

end;

function TControllerProduto.InsertEtiqueta(pCodOperador: Integer;
  oProduto: ToProduto; sErro: String): Boolean;
var
  DaoProduto: TDmProduto;
begin

  DaoProduto := TDmProduto.Create(nil);
  try
    Result := DaoProduto.InsertEtiqueta(pCodOperador,oProduto, sErro);

  finally
    FreeAndNil(DaoProduto);
  end;

end;

end.
