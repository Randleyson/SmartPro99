unit Controller.uConexaoSQL;

interface

uses
  Controller.oConfiguracao;

type
  TuConexaoSQL = Class
  private
  public
    function ConexaoComBanco(oConfiguracao: ToConfiguracao;
      out sErro: String): Boolean;
  End;

implementation

uses
  Dao.ConexaoDB, System.SysUtils;

{ TControllerConexaoSQL }

function TuConexaoSQL.ConexaoComBanco(oConfiguracao: ToConfiguracao;
  out sErro: String): Boolean;
var
  ConexaoOracle: TConexaoOracle;
begin
  ConexaoOracle := TConexaoOracle.Create(Nil);
  try
    Result := ConexaoOracle.ConfigurarConexao(oConfiguracao);
  finally
    FreeAndNil(ConexaoOracle);
  end;

end;

end.
