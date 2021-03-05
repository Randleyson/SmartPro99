unit Controller.uConexaoSQL;

interface

uses
  Controller.oConfiguracao;

type
  TuConexaoSQL = Class
  private
  public
    function ConexaoComBanco: Boolean;
  End;

implementation

uses
  Dao.ConexaoDB, System.SysUtils;

{ TControllerConexaoSQL }

function TuConexaoSQL.ConexaoComBanco: Boolean;
var
  ConexaoOracle: TDaoConexaoDB;
begin
  ConexaoOracle := TDaoConexaoDB.Create(Nil);
  try
    Result := ConexaoOracle.ConfigurarConexao;
  finally
    FreeAndNil(ConexaoOracle);
  end;

end;

end.
