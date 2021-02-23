unit Controller.oProdutos;

interface

type
  ToProdutos = class
  private
    FCodBarra: String;
    FDescricao: String;
    FVrVenda: Currency;
    FUnidade: String;
  public
    property Codbarra: String read FCodBarra write FCodBarra;
    property Descricao: String read FDescricao write FDescricao;
    property Unidade: String read FUnidade write FUnidade;
    property VrVenda: Currency read FVrVenda write FVrVenda;
  end;

var
  oProdutos: ToProdutos;

implementation

end.
