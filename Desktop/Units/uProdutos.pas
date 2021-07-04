unit uProdutos;

interface

type
  TProduto = class
  private
    FIdProduto: String;
    FDescricao: String;
    FVrVenda: String;
    FUnidade: String;
  public
    property IdProduto: String read FIdProduto write FIdProduto;
    property Descricao: String read FDescricao write FDescricao;
    property Unidade: String read FUnidade write FUnidade;
    property VrVenda: String read FVrVenda write FVrVenda;
    constructor Create;
    destructor Destroy; override;
    class function New: TProduto;
  end;

implementation

{ TProduto }

constructor TProduto.Create;
begin

end;

destructor TProduto.Destroy;
begin

  inherited;
end;

class function TProduto.New: TProduto;
begin
  Result := TProduto.Create;

end;

end.
