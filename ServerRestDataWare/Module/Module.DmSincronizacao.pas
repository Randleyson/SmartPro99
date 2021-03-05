unit Module.DmSincronizacao;

interface

uses
  System.SysUtils, System.Classes, Dao.ConexaoDB;

type
  TDmSincronizacao = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    DaoConexao: TDaoConexaoDB;
  public
    { Public declarations }
    procedure UpdateNaoExitenteArquivo;
    function ProdutoExistenteDB(pCodBarra: String): Boolean;
    procedure UpdateProdutoExistente(pCodBarra, pDescricao, pVrVenda: String);
    procedure InserieProduto(pCodBarra, pDescricao, pVrVenda: String);
    procedure DeletarNaoExistenteArquivo;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses Controller.oSincronizacao, Controller.uUtil;
{$R *.dfm}
{ TDmSincronizacao }

procedure TDmSincronizacao.DataModuleCreate(Sender: TObject);
begin
  DaoConexao := TDaoConexaoDB.Create(Nil);
end;

procedure TDmSincronizacao.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(DaoConexao);
end;

procedure TDmSincronizacao.DeletarNaoExistenteArquivo;
var
  vSQL: String;
begin

  vSQL := 'Delete from produtos where EXISTENOARQ = ''N''';

  DaoConexao.FDConn.ExecSQL(vSQL);
  DaoConexao.FDConn.Commit;

end;

procedure TDmSincronizacao.InserieProduto(pCodBarra, pDescricao,
  pVrVenda: String);
var
  vSQL: String;
begin

  vSQL := 'INSERT INTO produtos (codbarra,descricao,vrvenda,existenoarq) values '
    + '(:CODBARRA, :DESCRICAO, :VRVENDA, :EXISTENOARQ)';

  vSQL := TuUtil.SubstituirStr(vSQL, ':CODBARRA', QuotedStr(pCodBarra));
  vSQL := TuUtil.SubstituirStr(vSQL, ':DESCRICAO', QuotedStr(pDescricao));
  vSQL := TuUtil.SubstituirStr(vSQL, ':VRVENDA', QuotedStr(pVrVenda));
  vSQL := TuUtil.SubstituirStr(vSQL, ':EXISTENOARQ', QuotedStr('S'));

  DaoConexao.FDConn.ExecSQL(vSQL);
  DaoConexao.FDConn.Commit;

end;

function TDmSincronizacao.ProdutoExistenteDB(pCodBarra: String): Boolean;
var
  vSQL: String;
begin

  vSQL := 'select count(*) from produtos where codbarra = :CODBARRA';
  vSQL := TuUtil.SubstituirStr(vSQL, ':CODBARRA', QuotedStr(pCodBarra));

  DaoConexao.FDConn.Connected := True;
  Result := (StrToIntDef(DaoConexao.FDConn.ExecSQLScalar(vSQL), 0) > 0);

end;

procedure TDmSincronizacao.UpdateNaoExitenteArquivo;
var
  vSQL: String;
begin

  vSQL := 'Update produtos set EXISTENOARQ = ''N''';

  DaoConexao.FDConn.ExecSQL(vSQL);
  DaoConexao.FDConn.Commit;

end;

procedure TDmSincronizacao.UpdateProdutoExistente(pCodBarra, pDescricao,
  pVrVenda: String);
var
  vSQL: String;
begin

  vSQL := 'update produtos set descricao = :DESCRICAO,' +
    ' vrvenda = :VRVENDA, EXISTENOARQ= :EXISTENOARQ' +
    ' WHERE codbarra = :CODBARRA';

  vSQL := TuUtil.SubstituirStr(vSQL, ':DESCRICAO', QuotedStr(pDescricao));
  vSQL := TuUtil.SubstituirStr(vSQL, ':VRVENDA', QuotedStr(pVrVenda));
  vSQL := TuUtil.SubstituirStr(vSQL, ':EXISTENOARQ', QuotedStr('S'));
  vSQL := TuUtil.SubstituirStr(vSQL, ':CODBARRA', QuotedStr(pCodBarra));

  DaoConexao.FDConn.ExecSQL(vSQL);
  DaoConexao.FDConn.Commit;

end;

end.
