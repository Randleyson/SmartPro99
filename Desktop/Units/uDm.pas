unit uDm;

interface

uses
  System.SysUtils,
  System.Classes,
  uFiredac,
  Data.DB, FireDAC.Phys.FBDef, FireDAC.Stan.Intf, FireDAC.Phys,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.FMXUI.Wait, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, uConfiguracao;

type
  TDm = class(TDataModule)
    QueryTv: TFDQuery;
    QueryProdutos: TFDQuery;
    QueryProdNotTv: TFDQuery;
    QueryProdCadTv: TFDQuery;
    FDConnection: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    DS_ProdNotTv: TFDMemTable;
    DS_ProdCadTv: TFDMemTable;
    DS_Tv: TFDMemTable;
    DS_Produtos: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    Firedac: TFiredac;
    FTipoIntegracao: String;
    FPathArquivo: String;
    FIdTv: Integer;
    procedure DataSetEmMemoria( pOrigen: TFDDataSet; pDestino: TFDDataSet );
    function  ExceSQL(pSQL: String): Boolean;
    function  FBEstaAtivo: Boolean;
  public
    { Public declarations }
    procedure ExcluirTv(pIdTv: integer);
    procedure GravarConfiguracao(pConfiguracao: TConfiguracao);
    procedure InsertProdutos(pProdutos: TDataSet);
    function  InsertTv(pDescricao: String): Tdm;
    function  LerDSProdNotTv(pIdTv: Integer): TDataSet;
    function  LerDSProdCadTv(pIdTv: Integer): TDataSet;
    function  LerDSProdutos: TDataSet;
    function  LerDSTv: TDataSet;
    procedure LerConfiguracao(pConfiguracao: TConfiguracao);
    function  UpdateTv(pIdTV:Integer; pDescricao: String): Tdm;


    { -- }
    //function  DataSetProdutos: TDataSet;
    //function  PathArquivo( aValue: String): TDm;

    //function  TipoIntegracao( aValue: String): TDm;

    //function  ValidaLogin(pLogin,pSenha: String): Boolean;
  end;

var
  Dm: TDm;

implementation

uses
  VCL.Forms,Tlhelp32, Winapi.Windows, uTv;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TDm }

function TDm.FBEstaAtivo: Boolean;
const PROCESS_TERMINATE = $0001;
var
  Co: BOOL;
  FS: THandle;
  FP: TProcessEntry32;
  s:  string;
begin
  FS := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FP.dwSize := Sizeof(FP);
  Co := Process32First(FS, FP);
  while integer(Co) <> 0 do
  begin
    s := s + FP.szExeFile + #13;
    Co := Process32Next(FS, FP);
  end;
  CloseHandle(FS);
  if pos('fbserver', s) > 0 then
    result := true
  else
    result := false;
end;

procedure TDm.DataModuleCreate(Sender: TObject);
begin

  if not FileExists(ExtractFileDir(application.ExeName) + '\Config.ini') then
    raise Exception.Create('Não foi possivel localizar o arquivo config.ini');

  if not FBEstaAtivo then
    raise Exception.Create('o serviço "fbserver" deve estar desativado ou não esta intalado');

  try
    FDConnection             := TFDConnection.Create(Nil);
    FDConnection.LoginPrompt := False;
    FDConnection.Params.Clear;
    FDConnection.Params.Add('LockingMode=Normal');
    FDConnection.Params.LoadFromFile(ExtractFileDir(application.ExeName) + '\Config.ini');
    FDConnection.Connected   := True;
  except on E: Exception do
    raise Exception.Create('Não foi possivel conectar ao banco de dados' + #13 +
                            E.Message );
  end;

  Firedac := TFiredac.New;
end;
{
function TDm.DS_ProdutosNotTV( aParant: Integer): TDataSet;
begin
  Result := Firedac
              .Active(False)
                .SQLClear
                .SQL(' select codbarra, descricao,vrvenda,unidade from produtos p ')
                .SQL(' where codbarra not in ')
                .SQL(' (select codproduto from tv_prod where codtv = :IDTV) ')
                .SQL(' group by codbarra,descricao,vrvenda,unidade')
                .AddParan('IDTV',aParant)
              .Open
            .DataSet;
end;

function TDm.DS_ProdutosCadTV( aParant: Integer): TDataSet;
begin
  Result := Firedac
              .Active(False)
                .SQLClear
                .SQL(' select codbarra, descricao,vrvenda,unidade from produtos p ')
                .SQL(' where codbarra in ')
                .SQL(' (select codproduto from tv_prod where codtv = :IDTV) ')
                .SQL(' group by codbarra,descricao,vrvenda,unidade')
                .AddParan('IDTV',aParant)
              .Open
            .DataSet;
end;
}

procedure TDm.DataSetEmMemoria( pOrigen: TFDDataSet; pDestino: TFDDataSet );
begin

  if pDestino.Active then
  begin
    pDestino.EmptyDataSet;
    pDestino.Close;
  end;
  Application.ProcessMessages;
  TFDMemTable(pDestino).CloneCursor(pOrigen);
  pDestino.Filtered := False;

end;
{
function TDm.DataSetProdutos: TDataSet;
begin
  Result := Firedac
              .Active(false)
              .SQLClear
                .SQL('select * from produtos')
              .Open
              .DataSet;
end;}
{
function TDm.DataSetTv: TDataSet;
begin
  Result := Firedac
              .Active(False)
                .SQLClear
                .SQL('select IdTv,Descricao from tvs')
                .Open
              .DataSet;
end;
}

function TDm.ExceSQL(pSQL: String): Boolean;
begin

  FDConnection.ExecSQL(pSQL);
  FDConnection.Commit;

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

  InsertProdutos(DS_ProdCadTv);

end;

procedure TDm.LerConfiguracao(pConfiguracao: TConfiguracao);
var
  vSQL: String;
  vFQuery: TFDQuery;
begin

  vSQL := 'select tipointegracao,localarquivo from configuracao';

  vFQuery := TFDQuery.Create(Nil);
  try

    vFQuery.Close;
    vFQuery.Connection := FDConnection;
    vFQuery.SQL.Clear;
    vFQuery.Open(vSQL);

    pConfiguracao.TipoIntegracaoToString(vFQuery.Fields[0].AsString);
    pConfiguracao.LocalArquivo := vFQuery.Fields[1].AsString;

  finally
    vFQuery.DisposeOf;
  end;


end;


function TDm.LerDSProdCadTv(pIDTV: Integer): TDataSet;
var
  vSQL: String;
begin

  vSQL := ' select codbarra, descricao, vrvenda, unidade'+
          ' from produtos p'+
          ' where codbarra in (select codproduto from tv_prod where codtv = :IDTV)'+
          ' group by codbarra,descricao,vrvenda,unidade';


  QueryProdCadTv.Close;
  QueryProdCadTv.Connection := FDConnection;
  QueryProdCadTv.SQL.Clear;
  QueryProdCadTv.SQL.Add(vSQL);
  QueryProdCadTv.ParamByName('IDTV').Value := pIDTV;
  QueryProdCadTv.Open;
  try
    DataSetEmMemoria(QueryProdCadTv,DS_ProdCadTv);
  finally
    QueryProdCadTv.Close;
  end;

  Result := DS_ProdCadTv;

end;

function TDm.LerDSProdNotTv(pIDTV: Integer): TDataSet;
var
  vSQL: String;
begin

  vSQL := ' select codbarra, descricao, vrvenda, unidade'+
          ' from produtos p'+
          ' where codbarra not in (select codproduto from tv_prod where codtv = :IDTV)'+
          ' group by codbarra,descricao,vrvenda,unidade';


  QueryProdNotTv.Close;
  QueryProdNotTv.Connection := FDConnection;
  QueryProdNotTv.SQL.Clear;
  QueryProdNotTv.SQL.Add(vSQL);
  QueryProdNotTv.ParamByName('IDTV').Value := pIDTV;
  QueryProdNotTv.Open;
  try
    DataSetEmMemoria(QueryProdNotTv, DS_ProdNotTv);
  finally
    QueryProdNotTv.Close;
  end;

  Result := DS_ProdNotTv;

end;

function TDm.LerDSProdutos: TDataSet;
var
  vSQL: String;
begin

  vSQL := ' select codbarra, descricao, vrvenda, unidade from produtos';

  QueryProdutos.Close;
  QueryProdutos.Connection := FDConnection;
  QueryProdutos.SQL.Clear;
  QueryProdutos.SQL.Add(vSQL);
  QueryProdutos.Open;
  try
    DataSetEmMemoria(QueryProdutos,DS_Produtos);
  finally
    QueryProdutos.Close;
  end;
  Result := DS_Produtos;

end;

function TDm.LerDSTv: TDataSet;
var
  vSQL: String;
begin

  vSQL := 'select IdTv,Descricao from tvs';

  QueryTv.Close;
  QueryTv.Connection := FDConnection;
  QueryTv.SQL.Clear;
  QueryTv.SQL.Add(vSQL);
  QueryTv.Open;
  try
    DataSetEmMemoria(QueryTv, DS_Tv);

  finally
    QueryTv.Close;
  end;

  Result := DS_Tv;
end;
{
function TDm.PathArquivo: String;
begin
  Result := Firedac
    .Active(False)
      .SQLClear
      .SQL('select localarquivo from configuracao')
    .Open
  .DataSet.Fields[0].AsString;
end;  }

procedure TDm.GravarConfiguracao(pConfiguracao: TConfiguracao);
begin
  Firedac
    .Active(False)
      .SQLClear
      .SQL('Update Configuracao set TipoIntegracao = :PADRAOARQUIVO,')
      .SQL(' LocalArquivo = :LOCALARQUIVO')
      .AddParan('PADRAOARQUIVO',pConfiguracao.TipoIntegracaoToString)
      .AddParan('LOCALARQUIVO',pConfiguracao.LocalArquivo)
    .ExceSQL;
end;

{
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
}
function TDm.UpdateTv(pIdTV: Integer; pDescricao: String): Tdm;
begin
  Result := Self;
  FIdTv  := pIdTV;
  Firedac
    .Active(False)
      .SQLClear
      .SQL(' update Tvs set Descricao = :Descricao ')
      .SQL(' where idtv = :IDTV')
      .AddParan('IDTV',FIdTv)
      .AddParan('Descricao',pDescricao)
    .ExceSQL;

  InsertProdutos(DS_ProdCadTv);
end;
{
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
end;   }

end.
