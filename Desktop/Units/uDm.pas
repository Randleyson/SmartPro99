unit uDm;

interface

uses
  System.SysUtils,
  System.Classes,
  uFiredac,
  Data.DB;

type
  TDm = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    Firedac: TFiredac;
    FTipoIntegracao: String;
    FPathArquivo: String;
    FIdTv: Integer;
  public
    { Public declarations }
    function DS_ProdutosNotTV( aParant: Integer): TDataSet;
    function DS_ProdutosCadTV( aParant: Integer): TDataSet;
    function DataSetProdutos: TDataSet;
    function DataSetTv: TDataSet;
    procedure ExcluirTv( pIdTv: integer);
    procedure InsertProdutos(pProdutos: TDataSet);
    function InsertTv(pDescricao: String): Tdm;
    function PathArquivo( aValue: String): TDm; overload;
    function PathArquivo: String; overload;
    function SalvarConfiguracao: TDm;
    function TipoIntegracao( aValue: String): TDm; overload;
    function TipoIntegracao: String; overload;
    function UpdateTv(pIdTV:Integer; pDescricao: String): Tdm;
    function ValidaLogin(pLogin,pSenha: String): Boolean;
  end;

var
  Dm: TDm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TDm }

procedure TDm.DataModuleCreate(Sender: TObject);
begin
  Firedac := TFiredac.New;
end;

function TDm.DS_ProdutosNotTV( aParant: Integer): TDataSet;
begin
  Result := Firedac
              .Active(False)
                .SQLClear
                .SQL(' select codbarra, descricao from produtos p ')
                .SQL(' where codbarra not in ')
                .SQL(' (select codproduto from tv_prod where codtv = :IDTV) ')
                .SQL(' group by codbarra,descricao')
                .AddParan('IDTV',aParant)
              .Open
            .DataSet;
end;

function TDm.DS_ProdutosCadTV( aParant: Integer): TDataSet;
begin
  Result := Firedac
              .Active(False)
                .SQLClear
                .SQL(' select codbarra, descricao from produtos p ')
                .SQL(' where codbarra in ')
                .SQL(' (select codproduto from tv_prod where codtv = :IDTV) ')
                .SQL(' group by codbarra,descricao')
                .AddParan('IDTV',aParant)
              .Open
            .DataSet;
end;

function TDm.DataSetProdutos: TDataSet;
begin
  Result := Firedac
              .Active(false)
              .SQLClear
                .SQL('select * from produtos')
              .Open
              .DataSet;
end;

function TDm.DataSetTv: TDataSet;
begin
  Result := Firedac
              .Active(False)
                .SQLClear
                .SQL('select idTv,Descricao from tvs')
                .Open
              .DataSet;
end;

procedure TDm.ExcluirTv(pIdTv: integer);
begin
  Firedac
    .Active(False)
      .SQLClear
      .SQL('delete from Tv_Prod where codtv = :IDTV')
      .AddParan('IDTV',pIdTv)
    .ExceSQL;

   Firedac
    .Active(False)
      .SQLClear
      .SQL('delete from tvs where idtv = :IDTV')
      .AddParan('IDTV',pIdTv)
    .ExceSQL;
end;

procedure TDm.InsertProdutos(pProdutos: TDataSet);
begin
  {BACKUP PRODUTOS}
  Firedac
    .Active(False)
      .SQLClear
      .SQL('Update tv_prod set ie = ''E'' where codtv = :IDTV')
      .AddParan('IDTV',FIdTv)
    .ExceSQL;

    {INSERT NOVOS REGISTRO}
    pProdutos.First;
    while not pProdutos.EOF do
    begin
      Firedac
        .Active(False)
          .SQLClear
          .SQL('insert Into tv_prod (codproduto,codtv) values (:CODBARRA,:IDTV)')
          .AddParan('CODBARRA',pProdutos.Fields[0].AsString)
          .AddParan('IDTV',FIdTv)
        .ExceSQL;
      pProdutos.Next;
    end;

    {EXCLUIR OS REGISTRO}
    Firedac
      .Active(False)
        .SQLClear
        .SQL('Delete from tv_prod where ie = ''E'' and codtv = :IDTV')
        .AddParan('IDTV',FIdTv)
      .ExceSQL;

end;

function TDm.InsertTv(pDescricao: String): TDm;
begin
  Result := Self;
  Firedac
    .Active(False)
      .SQLClear
      .SQL(' Insert Into Tvs (Descricao)')
      .SQL(' values (:Descricao) ')
      .AddParan('Descricao',pDescricao)
    .ExceSQL;

  FIdTv := Firedac
            .Active(False)
              .SQLClear
              .SQL('select max(idtv) from tvs')
            .Open
            .DataSet.Fields[0].AsInteger;

end;

function TDm.PathArquivo: String;
begin
  Result := Firedac
    .Active(False)
      .SQLClear
      .SQL('select localarquivo from configuracao')
    .Open
  .DataSet.Fields[0].AsString;
end;

function TDm.SalvarConfiguracao: TDm;
begin
  Firedac
    .Active(False)
      .SQLClear
      .SQL('Update Configuracao set PadraoArquivo = :PADRAOARQUIVO,')
      .SQL(' LocalArquivo = :LOCALARQUIVO')
      .AddParan('PADRAOARQUIVO',FTipoIntegracao)
      .AddParan('LOCALARQUIVO',FPathArquivo)
    .ExceSQL;
end;

function TDm.PathArquivo(aValue: String): TDm;
begin
  Result := Self;
  if not FileExists(aValue) then
    raise Exception.Create('Arquivo Não Localizado');
  FPathArquivo := aValue;
end;

function TDm.TipoIntegracao(aValue: String): TDm;
begin
  Result := Self;
  FTipoIntegracao := aValue;
end;

function TDm.TipoIntegracao: String;
begin
  Result := Firedac
              .Active(False)
                .SQLClear
                .SQL('select padraoarquivo from configuracao')
              .Open
            .DataSet.Fields[0].AsString;
end;

function TDm.UpdateTv(pIdTV: Integer; pDescricao: String): Tdm;
begin
  REsult := Self;
  FIdTv  := pIdTV;
  Firedac
    .Active(False)
      .SQLClear
      .SQL(' update Tvs set Descricao = :Descricao ')
      .SQL(' where idtv = :IDTV')
      .AddParan('IDTV',FIdTv)
      .AddParan('Descricao',pDescricao)
    .ExceSQL;
end;

function TDm.ValidaLogin(pLogin, pSenha: String): Boolean;
begin
  Result := False;
  if Firedac
      .Active(False)
        .SQLClear
        .SQL('select idUsuario,Login,senha,nome from Usuario')
        .SQL('where Login = :LOGIN AND Senha = :SENHA')
        .AddParan('LOGIN',pLogin)
        .AddParan('SENHA',pSenha)
      .Open
      .DataSet.RecordCount > 0 then
    Result := True;
  Firedac.Active(False);
end;

end.
