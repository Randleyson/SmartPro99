unit Controller.uProdutos;

interface

uses
  FireDAC.Comp.Client;

type
  TuProdutos = class
  private
  public
    function CarregaProdutoDb(pFDMemTable: TFDMemTable): Boolean;

    class Function New: TuProdutos;
  end;

implementation

uses
  Module.DmProdutos, System.SysUtils;

{ TuProdutos }

function TuProdutos.CarregaProdutoDb(pFDMemTable: TFDMemTable): Boolean;
var
  DmProdutos: TDmProdutos;
begin

  DmProdutos := TDmProdutos.Create(Nil);
  try
    Result := DmProdutos.CarregaProdutoDb(pFDMemTable);

  finally
    FreeAndNil(DmProdutos);

  end;

end;

class function TuProdutos.New: TuProdutos;
begin
  Result := TuProdutos.Create;
end;

end.
