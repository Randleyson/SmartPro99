unit Controller.uSincronizacao;

interface

uses
  Module.DmSincronizacao;

type
  TuSincronizacao = Class
  private
    DmSincronizacao: TDmSincronizacao;
  public
    procedure UpdateNaoExistenteArquivo;
    procedure DeletarNaoExistenteArquivo;
    function ProdutoExistenteDB(pCodBarra: String): Boolean;
    procedure UpdateProdutoExistente(pCodBarra, pDescricao, pVrVenda: String);
    procedure InserieProduto(pCodBarra, pDescricao, pVrVenda: String);

    constructor Create;
    destructor Destroy; override;

  End;

implementation

uses
  System.SysUtils;

{ TuSincronizacao }

constructor TuSincronizacao.Create;
begin

  DmSincronizacao := TDmSincronizacao.Create(Nil);

end;

procedure TuSincronizacao.DeletarNaoExistenteArquivo;
begin

  DmSincronizacao.DeletarNaoExistenteArquivo;

end;

destructor TuSincronizacao.Destroy;
begin
  FreeAndNil(DmSincronizacao);
  inherited;
end;

procedure TuSincronizacao.InserieProduto(pCodBarra, pDescricao,
  pVrVenda: String);
begin

  DmSincronizacao.InserieProduto(pCodBarra, pDescricao, pVrVenda);

end;

function TuSincronizacao.ProdutoExistenteDB(pCodBarra: String): Boolean;

begin

  Result := DmSincronizacao.ProdutoExistenteDB(pCodBarra);

end;

procedure TuSincronizacao.UpdateNaoExistenteArquivo;

begin

  DmSincronizacao.UpdateNaoExitenteArquivo;

end;

procedure TuSincronizacao.UpdateProdutoExistente(pCodBarra, pDescricao,
  pVrVenda: String);
begin

  DmSincronizacao.UpdateProdutoExistente(pCodBarra, pDescricao, pVrVenda);

end;

end.
