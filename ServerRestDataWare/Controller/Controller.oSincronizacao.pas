unit Controller.oSincronizacao;

interface

uses
  Controller.uSincronizacao;

type
  ToSincronizacao = class
    FArquivoIntegracao: TextFile;
    FLinha: String;
    uSincronizacao: TuSincronizacao;
    function GetCodbarra: String;
    function GetDescricao: String;
    function GetVrvenda: String;
  public
    procedure SincronizarProdutos;
    function QuantidadeLinha: Integer;

  end;

var
  oSincronizacao: ToSincronizacao;

implementation

uses
  Controller.oConfiguracao, System.SysUtils, Controller.uUtil,
  View.FrmPrincipal;

{ ToSincronizacao }

function ToSincronizacao.GetCodbarra: String;
begin

  try
    result := Copy(FLinha, 6, 6);

  except
    raise
  end;

end;

function ToSincronizacao.GetDescricao: String;
begin

  try
    result := Copy(FLinha, 21, 25);

  except
    raise

  end;

end;

procedure ToSincronizacao.SincronizarProdutos;
var
  vCodBarra, vDescricao, vVrVenda: String;
begin

  //Abrer o arquivo
  AssignFile(FArquivoIntegracao, oConfiguracao.PathAquivoIntegracao);
  reset(FArquivoIntegracao);
  uSincronizacao := TuSincronizacao.Create;
  try

    //Marcar todos os produtos com nao exite no arquivo
    uSincronizacao.UpdateNaoExistenteArquivo;

    //Inserir ou atualiza os produtos
    while not EOF(FArquivoIntegracao) do
    begin

      Readln(FArquivoIntegracao, FLinha);

      if Length(FLinha) < 50 then
        exit;

      vCodBarra := GetCodbarra;
      vDescricao := GetDescricao;
      vVrVenda := GetVrvenda;

      if uSincronizacao.ProdutoExistenteDB(vCodBarra) then
        uSincronizacao.UpdateProdutoExistente(vCodBarra,vDescricao,vVrVenda)
      else
        uSincronizacao.InserieProduto(vCodBarra,vDescricao,vVrVenda);

      FrmPrincipal.PBarSincronizara.Value := FrmPrincipal.PBarSincronizara.Value+1;
    end;

    //Deleta os produtos que nao estao no arquivo
    uSincronizacao.DeletarNaoExistenteArquivo;


  finally
    CloseFile(FArquivoIntegracao);
    FreeAndNil(uSincronizacao);
  end;

end;

function ToSincronizacao.GetVrvenda: String;
begin

  try
    result := Copy(Copy(FLinha, 12, 6), 0, 4) + '.' +
      Copy(Copy(FLinha, 12, 6), 5, 2);

  except
    raise

  end;

end;

function ToSincronizacao.QuantidadeLinha: Integer;
begin
  Result := TuUtil.NumeroDeLinhasTXT(oConfiguracao.PathAquivoIntegracao);

end;

end.
