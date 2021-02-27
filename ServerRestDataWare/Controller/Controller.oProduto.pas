unit Controller.oProduto;

interface

type
  ToProduto = Class
  private
    FCodBarra: String;
    FVrPromocao: String;
    FAtivo: String;
    FDescricao: String;
    FEstoque: String;
    FPromocao: String;
    FVrVenda: String;
    FUnidade: String;
    FCustoRep: String;
    FIdEmpresa: String;
    FIdProduto: String;
  public
    property IdEmpresa: String read FIdEmpresa write FIdEmpresa;
    property IdProduto: String read FIdProduto write FIdProduto;
    property CodBarra: String read FCodBarra write FCodBarra;
    property Descricao: String read FDescricao write FDescricao;
    property Unidade: String read FUnidade write FUnidade;
    property VrVenda: String read FVrVenda write FVrVenda;
    property CustoRep: String read FCustoRep write FCustoRep;
    property Promocao: String read FPromocao write FPromocao;
    property VrPromocao: String read FVrPromocao write FVrPromocao;
    property Ativo: String read FAtivo write FAtivo;
    property Estoque: String read FEstoque write FEstoque;
  End;

implementation

end.
