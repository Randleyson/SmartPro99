unit Module.DmTvs;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Controller.oTvs, Doa.DmConexaoSQL;

type
  TDmTvs = class(TDataModule)
    QryTvs: TFDQuery;
    QryProdutoTv: TFDQuery;
    QryProdutos: TFDQuery;
  private
    { Private declarations }
    DmConexaoSQL: TDmConexaoSQL;
    function AtualizarProdutoTv(pDataSetProduto: TFDMemTable;
      oTvs: ToTvs): Boolean;
    procedure DeleteTv(oTvs: ToTvs);
    procedure DeleteProtTv(oTvs: ToTvs);
  public
    { Public declarations }
    function CarergaDataSetTv(pFDMemTable: TFDMemTable): Boolean;
    function CarregaDataSetProdutos(pFDMemTable: TFDMemTable;
      pIdTv: Integer): Boolean;
    function CarregaDataSetProdTvs(pFDMemTable: TFDMemTable;
      pIdTv: Integer): Boolean;
    function InseriTv(oTvs: ToTvs; pDataSetProduto: TFDMemTable): Boolean;
    function UpdateTv(oTvs: ToTvs; pDataSetProduto: TFDMemTable): Boolean;
    function DeletarTv(oTvs: ToTvs): Boolean;


    function SQL_ProdutosNaoTv(pCodTv: Integer): String;
    function SQL_ProdutosTv(pCodTv: Integer): String;
  end;

var
  DmTvs: TDmTvs;

implementation

uses
  System.Variants, Controller.uSmartPro99;

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TDmTvs }

function TDmTvs.CarergaDataSetTv(pFDMemTable: TFDMemTable): Boolean;
begin

  DmConexaoSQL := TDmConexaoSQL.Create(Nil);
  try
    with QryTvs do
    begin
      try
        Close;
        Connection := DmConexaoSQL.ConnectionSQL;
        Open;

        pFDMemTable.Close;
        pFDMemTable.Open;
        pFDMemTable.EmptyDataSet;
        pFDMemTable.Filtered := False;

        TFDMemTable(pFDMemTable).CopyDataSet(QryTvs);

        Result := True;
        if pFDMemTable.isempty then
          Result := False;

      except
        raise

      end;
    end;

  finally
    QryTvs.Close;
    FreeAndNil(DmConexaoSQL);
  end;

end;

function TDmTvs.CarregaDataSetProdutos(pFDMemTable: TFDMemTable;
  pIdTv: Integer): Boolean;
begin

  DmConexaoSQL := TDmConexaoSQL.Create(Nil);
  try
    with QryProdutos do
    begin
      try
        Close;
        Connection := DmConexaoSQL.ConnectionSQL;
        SQL.Text := '';
        SQL.Text := SQL_ProdutosNaoTv(pIdTv);
        Open;

        pFDMemTable.Close;
        pFDMemTable.Open;
        pFDMemTable.EmptyDataSet;
        TFDMemTable(pFDMemTable).CopyDataSet(QryProdutos);

        Result := True;
        if pFDMemTable.isempty then
          Result := False;

      except
        raise

      end;
    end;

  finally
    QryProdutos.Close;
    FreeAndNil(DmConexaoSQL);
  end;

end;

function TDmTvs.DeletarTv(oTvs: ToTvs): Boolean;
begin

  DmConexaoSQL := TDmConexaoSQL.Create(Nil);
  try
    try
      DeleteProtTv(oTvs);
      DeleteTv(oTvs);

      Result := True;
    except
      Raise;
    end;

  finally
    FreeAndNil(DmConexaoSQL);

  end;
end;

procedure TDmTvs.DeleteProtTv(oTvs: ToTvs);
var
  vSQL: String;
begin

  vSQL := 'delete from Tv_Prod where codtv = :IDTV';
  try
    vSQL := TuSmartPro99.SubstituirString(vSQL, ':IDTV', IntToStr(oTvs.IdTv));
    DmConexaoSQL.ExecutaSQL(vSQL);

  except
    raise

  end;

end;

procedure TDmTvs.DeleteTv(oTvs: ToTvs);
var
  vSQL: String;
begin

  vSQL := 'delete from tvs where idtv = :IDTV';
  try
    vSQL := TuSmartPro99.SubstituirString(vSQL, ':IDTV', IntToStr(oTvs.IdTv));
    DmConexaoSQL.ExecutaSQL(vSQL);

  except
    raise

  end;


end;

function TDmTvs.InseriTv(oTvs: ToTvs; pDataSetProduto: TFDMemTable): Boolean;
var
  vSQL: String;
begin

  vSQL := 'Insert Into Tvs (Descricao) values (' +
    QuotedStr(oTvs.Descricao) + ')';

  DmConexaoSQL := TDmConexaoSQL.Create(Nil);
  try
    try
      DmConexaoSQL.ExecutaSQL(vSQL);
      oTvs.IdTv := StrToInt(DmConexaoSQL.ConnectionSQL.ExecSQLScalar
        ('select max(idtv) from tvs'));

      AtualizarProdutoTv(pDataSetProduto, oTvs);

    except
      Raise;
    end;

  finally
    FreeAndNil(DmConexaoSQL);

  end;

end;

function TDmTvs.SQL_ProdutosNaoTv(pCodTv: Integer): String;
var
  vSQL: String;
begin

  vSQL := 'select codbarra, descricao from produtos p '+
          ' where codbarra not in '+
          ' (select codproduto from tv_prod where codtv = :IDTV) '+
          ' group by codbarra,descricao';

  vSQL := StringReplace(vSQL, ':IDTV', IntToStr(pCodTv), [rfReplaceAll, rfIgnoreCase]);

  Result := vSQL;

end;

function TDmTvs.SQL_ProdutosTv(pCodTv: Integer): String;
var
  vSQL: String;
begin

  vSQL := 'select codbarra, descricao from produtos p '+
          ' where codbarra in '+
          ' (select codproduto from tv_prod where codtv = :IDTV) '+
          ' group by codbarra,descricao';

  vSQL := StringReplace(vSQL, ':IDTV', IntToStr(pCodTv), [rfReplaceAll, rfIgnoreCase]);

  Result := vSQL;

end;

function TDmTvs.AtualizarProdutoTv(pDataSetProduto: TFDMemTable;
  oTvs: ToTvs): Boolean;
var
  vSQL: String;
begin

  try
    { FAZ BACKUP }
    vSQL := 'Update tv_prod set ie = ''E'' where codtv = :CODTV';
    TuSmartPro99.SubstituirString(vSQL, ':CODTV', IntToStr(oTvs.IdTv));
    DmConexaoSQL.ExecutaSQL(vSQL);

    { INSERT NOVOS REGISTRO }
    pDataSetProduto.First;
    while not pDataSetProduto.EOF do
    begin
      vSQL :=
        'insert Into tv_prod (codproduto,codtv) values ('':CODPRODUTO'',:CODTV)';
      vSQL :=
        TuSmartPro99.SubstituirString(vSQL, ':CODPRODUTO',pDataSetProduto.FieldByName('codbarra').AsString);
      vSQL :=
        TuSmartPro99.SubstituirString(vSQL, ':CODTV', IntToStr(oTvs.IdTv));
      DmConexaoSQL.ExecutaSQL(vSQL);
      pDataSetProduto.Next;
    end;

    { EXCLUIR OS REGISTRO }
    vSQL := 'Delete from tv_prod where ie = ''E'' and codtv = :CODTV';
    vSQL := TuSmartPro99.SubstituirString(vSQL, ':CODTV', IntToStr(oTvs.IdTv));
    DmConexaoSQL.ExecutaSQL(vSQL);

    Result := True;

  except
    Raise

  end;

end;

function TDmTvs.UpdateTv(oTvs: ToTvs; pDataSetProduto: TFDMemTable): Boolean;
var
  vSQL: String;
begin

  vSQL := 'update tvs set descricao = :DESCRICAO where idtv = :IDTV';

  DmConexaoSQL := TDmConexaoSQL.Create(Nil);
  try
    try
      vSQL := TuSmartPro99.SubstituirString(vSQL, ':DESCRICAO',
        QuotedStr(oTvs.Descricao));
      vSQL := TuSmartPro99.SubstituirString(vSQL, ':IDTV', IntToStr(oTvs.IdTv));
      DmConexaoSQL.ExecutaSQL(vSQL);
      AtualizarProdutoTv(pDataSetProduto, oTvs);

    except
      Raise;

    end;

  finally
    FreeAndNil(DmConexaoSQL);

  end;

end;

function TDmTvs.CarregaDataSetProdTvs(pFDMemTable: TFDMemTable;
  pIdTv: Integer): Boolean;
begin

  DmConexaoSQL := TDmConexaoSQL.Create(Nil);
  try
    with QryProdutoTv do
    begin
      try
        Close;
        Connection := DmConexaoSQL.ConnectionSQL;
        SQL.Text := '';
        SQL.Text := SQL_ProdutosTv(pIdTv);
        Open;

        pFDMemTable.Close;
        pFDMemTable.Open;
        pFDMemTable.EmptyDataSet;
        TFDMemTable(pFDMemTable).CopyDataSet(QryProdutoTv);

        Result := True;
        if pFDMemTable.isempty then
          Result := False;

      except
        raise

      end;
    end;

  finally
    QryProdutoTv.Close;
    FreeAndNil(DmConexaoSQL);
  end;

end;

end.
