unit SmarPro99.Model.Dados;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  Data.FireDACJSONReflect,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Stan.StorageJSON,
  FireDAC.Stan.StorageBin,
  System.IOUtils,
  Soap.SOAPHTTPTrans,
  IdBaseComponent,
  IdComponent,
  IdRawBase,
  IdRawClient,
  {Winapi.WinSock,}
  IdIcmpClient
{$IFDEF MSWINDOWS}
    , vcl.Forms
{$ENDIF};

type
  TModelDados = class(TDataModule)
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FQryTv: TFDQuery;
    FQryTabConfig: TFDQuery;
    FQryProdutos: TFDQuery;
    FMentProdWs: TFDMemTable;
    FMentTvWs: TFDMemTable;
    FMentProd: TFDMemTable;
    FMentTv: TFDMemTable;
    FMentConfig: TFDMemTable;
    FQryResolucao: TFDQuery;
    FQryTabConfigIDTV: TIntegerField;
    FQryTabConfigHOSTWS: TStringField;
    FQryTabConfigPORTAWS: TIntegerField;
    FQryTabConfigIDRESOLUCAO: TIntegerField;
    Pingador: TIdIcmpClient;
    FQryOferta: TFDQuery;
    FDMenOferta: TFDMemTable;
    FDMenOfertaCODBARRA: TStringField;
    FDMenOfertaDESCRICAO: TStringField;
    FDMenOfertaVRVENDA: TFloatField;
    FDMenOfertaUNIDADE: TStringField;
    FDMenOfertaPROMOCAO: TStringField;
    FMentResolucaoWs: TFDMemTable;
  private
    { Private declarations }
    FJsonDataSet: TFDJSONDataSets;
    procedure ExectSQL(pSQL: string);

    { Comando SQL }
    function SQL_UpdateIDRProd: String;
    function SQL_DeletaIDRProd: String;
    function SQL_UpdateIDRTv: String;
    function SQL_DeletaIDRTv: String;
    function SQL_InsertTabConfigInicial: String;
    function SQL_DeleteResolucao: string;

  public
    { Public declarations }
    function TestaConexaoWS: Boolean;
    Procedure ReceberProdutosWs(pIdTv: String);
    procedure RecebeResolucao;
    procedure RecebeTvsWs;
    procedure CarregaParamentros;
    procedure CarregaParamResolucao;
    procedure CarregaParamConfig;
    procedure AlteraConfiguracaoTv(pIdTv, pResolucao: String);

    procedure SalvaConfigWs(pHost, pPorta: String);
    procedure SalvaConfiTv(pIdTv: String);

    procedure GravarConfigWs(pHost, pPorta: string);
    procedure QryToFMent(pQry: TFDQuery; pFMent: TFDMemTable);
    procedure FMentToQry(pFMent: TFDMemTable; pQry: TFDQuery);
    function Ping(IP: String): Boolean;
    procedure ListarResolucao;

    procedure AlteraResolucao(pId: integer; pMarTopGridPreco, pLargFrmPrinc,
      pAltFrmPrinc, pTanFontGridPreco, pLargLogo, pLargGridPreco,
      pQuantProdGrid, pAltBarraGridProd: string);

  end;

var
  ModelDados: TModelDados;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses uClientModule, SmartPro99.View.FrmPrincipal,
  SmartPro99.Classe.Resolucao, SmartPro99.View.Logs,
  SmartPro99.View.ConfiguracaoDoLayout, SmarPro99.Model.Conexao;

{$R *.dfm}
{ TDmPrincipal }

{ function TDmPrincipal.IpLocal: String;
  var
  wsaData : TWSAData;
  begin
  WSAStartup(257, wsaData);
  Result := Trim(inet_ntoa( PInAddr( GetHostByName( nil )^.h_addr_list^ )^ ));
  end; }

function TModelDados.Ping(IP: String): Boolean;
begin

  try
    with Pingador do
    begin
      Host := IP;
      ReceiveTimeout := 500;
      Ping;
      if ReplyStatus.ReplyStatusType = rsEcho then
        result := true
      else
        result := false;
    end;
  except

  end;

end;

function TModelDados.TestaConexaoWS: Boolean;
begin

  try

    FrmPrincipal.fStatusConexaoWs := 1;
    if Ping(FrmPrincipal.fHostWs) then
    begin
      ClientModule.DSRestConnection.Host := FrmPrincipal.fHostWs;
      ClientModule.DSRestConnection.Port := StrToInt(FrmPrincipal.fPortaWs);
      ClientModule.DSRestConnection.TestConnection();
      result := true;
      FrmPrincipal.fStatusConexaoWs := 0;
    end;

  Except
    result := false;

  end;

end;

procedure TModelDados.AlteraConfiguracaoTv(pIdTv, pResolucao: String);
var
  vSQL: string;
begin

  vSQL := 'update tab_config set idtv = ' + pIdTv + ', idresolucao = ' +
    pResolucao;

  try

    ExectSQL(vSQL);

  except
    FrmPrincipal.fMensagemErro := 'Erro ao AlteraTvAtual';
    raise

  end;

end;

procedure TModelDados.AlteraResolucao(pId: integer;
  pMarTopGridPreco, pLargFrmPrinc, pAltFrmPrinc, pTanFontGridPreco, pLargLogo,
  pLargGridPreco, pQuantProdGrid, pAltBarraGridProd: string);
var
  vSQL: String;
begin

  try

    if pId = 1 then
    begin

      vSQL := 'update TAB_RESOLUCAO set   MARTOPGRIDPRECO   = ' +
        pMarTopGridPreco + ' ,LAGFRMPRINC      = ' + pLargFrmPrinc +
        ' ,ALTFRMPRINC      = ' + pAltFrmPrinc + ' ,TANFONTELSTPRECO = ' +
        pTanFontGridPreco + ' ,LARGLOGO         = ' + pLargLogo +
        ' ,LARGGRIDPRECO    = ' + pLargGridPreco + ' ,QUANTPRODGRID    = ' +
        pQuantProdGrid + ' ,ALTBARRAGRIDPROD = ' + pAltBarraGridProd +
        ' where idresolucao = 1';

      ExectSQL(vSQL);
    end;

    vSQL := 'Update TAB_CONFIG set idresolucao = ' + IntToStr(pId);
    ExectSQL(vSQL);

  except
    raise;

  end;

end;

procedure TModelDados.CarregaParamConfig;
begin

  try
    QryToFMent(FQryTabConfig, FMentConfig);
    if FMentConfig.RecordCount = 0 then
    begin
      ExectSQL(SQL_InsertTabConfigInicial);
      QryToFMent(FQryTabConfig, FMentConfig);
    end;

    FrmPrincipal.fIdTvAtual := FMentConfig.FieldByName('idtv').AsString;
    FrmPrincipal.fHostWs := FMentConfig.FieldByName('hostWs').AsString;
    FrmPrincipal.fPortaWs := FMentConfig.FieldByName('PortaWs').AsString;
    FrmPrincipal.fResolucaoAtual := FMentConfig.FieldByName('idResolucao')
      .AsInteger;

  except
    raise

  end;

end;

procedure TModelDados.CarregaParamentros;
begin

  try

    CarregaParamConfig;
    CarregaParamResolucao;

  except
    FrmPrincipal.fMensagemErro :=
      'Não foi possivel Carregar os paramentros de configuracao ';
    raise;
  end;

end;

procedure TModelDados.CarregaParamResolucao;
var
  vSQL: string;
  vFQryTemp: TFDQuery;
begin

  try

    vSQL := 'select * from tab_Resolucao where idresolucao = ' +
      IntToStr(FrmPrincipal.fResolucaoAtual);

    try

      ModelConexao.AbreConexaoSQLlite;
      vFQryTemp := TFDQuery.Create(self);
      vFQryTemp.Close;
      vFQryTemp.Connection := ModelConexao.FDC_SQLlite;
      vFQryTemp.SQL.Text := vSQL;
      vFQryTemp.Open;
      vFQryTemp.First;

      { GERAL }
      TResolucao.fLargFrmPrinc := vFQryTemp.FieldByName('LARGFRMPRINC')
        .AsInteger;
      TResolucao.fAlturaFrmPrinc := vFQryTemp.FieldByName('ALTFRMPRINC')
        .AsInteger;

      { GRID PRECO }
      TResolucao.fQtdeProdGrid := vFQryTemp.FieldByName('QTDEPRODGRID')
        .AsInteger;
      TResolucao.fSizeFonteGrid := vFQryTemp.FieldByName('SIZERFONTEGRID')
        .AsInteger;
      TResolucao.fLargGrid := vFQryTemp.FieldByName('LARGGRIDPRECO').AsInteger;
      TResolucao.fMarTopGrid := vFQryTemp.FieldByName('MARGTOPGRIDPRECO')
        .AsInteger;

      { OFERTA }
      TResolucao.fLargLytOferta := vFQryTemp.FieldByName('LARGLYTOFERTA')
        .AsInteger;
      TResolucao.fMargTopLytOferta := vFQryTemp.FieldByName('MARGTOPLYTOFERTA')
        .AsInteger;
      TResolucao.fAlturaLytImgOferta := vFQryTemp.FieldByName('ALTLYIMGTOFERTA')
        .AsInteger;
      TResolucao.fAlturaImgOferta := vFQryTemp.FieldByName('ALTIMGOFERTA')
        .AsInteger;
      TResolucao.fLargImgOferta := vFQryTemp.FieldByName('LARGIMGOFERTA')
        .AsInteger;

    finally
      vFQryTemp.Free;
      ModelConexao.FechaSQLlite;

    end;

  except
    raise

  end;

end;

procedure TModelDados.ExectSQL(pSQL: string);
begin

  try

    try

      if not ModelConexao.FDC_SQLlite.Connected then
        ModelConexao.AbreConexaoSQLlite;

      ModelConexao.FDC_SQLlite.ExecSQL(pSQL);
      ModelConexao.FDC_SQLlite.Commit;

    except
      raise
    end;

  finally
    ModelConexao.FechaSQLlite;

  end;

end;

procedure TModelDados.FMentToQry(pFMent: TFDMemTable; pQry: TFDQuery);
begin

  try

    try

      ModelConexao.AbreConexaoSQLlite;
      pQry.Close;
      pQry.Open;
      pQry.EmptyDataSet;
      pQry.CopyDataSet(pFMent);

    except
      FrameLogs.AddLogs('Erro ao QryProdToFMentProd');

    end;
  finally

    pFMent.Close;
    ModelConexao.FechaSQLlite;

  end;

end;

procedure TModelDados.GravarConfigWs(pHost, pPorta: string);
var
  vSQL: String;
begin

  vSQL := 'update tab_config set hostws =' + QuotedStr(pHost) + ' , portaws = '
    + QuotedStr(pPorta);

  try

    ExectSQL(vSQL);

  except
    FrmPrincipal.fMensagemErro := 'Erro ao excutar GravarConfigWs';
    raise

  end;

end;

procedure TModelDados.ListarResolucao;
begin
  try
    try

      ModelConexao.AbreConexaoSQLlite;
      with FQryResolucao do
      begin
        Close;
        Open;
        First;

        while not Eof do
        begin

          FrameConfLayout.Resolucao(FieldByName('idresolucao').AsString,
            FieldByName('nome').AsString, FieldByName('MARTOPGRIDPRECO')
            .AsString, FieldByName('LAGFRMPRINC').AsString,
            FieldByName('ALTFRMPRINC').AsString, FieldByName('TANFONTELSTPRECO')
            .AsString, FieldByName('LARGLOGO').AsString,
            FieldByName('LARGGRIDPRECO').AsString, FieldByName('QUANTPRODGRID')
            .AsString, FieldByName('ALTBARRAGRIDPROD').AsString, RecNo);
          FQryResolucao.Next;
        end;
      end;

    finally
      FQryResolucao.Close;
      ModelConexao.FechaSQLlite;
    end;

  except
    raise

  end;

end;

procedure TModelDados.QryToFMent(pQry: TFDQuery; pFMent: TFDMemTable);
begin

  try

    try

      ModelConexao.AbreConexaoSQLlite;
      pQry.Close;
      pQry.Open;

      pFMent.Open;
      pFMent.EmptyDataSet;
      pFMent.CopyDataSet(pQry);

      pQry.RecordCount;
      pFMent.RecordCount;

    except
      FrameLogs.AddLogs('Erro ao QryProdToFMentProd');

    end;
  finally

    pQry.Close;
    ModelConexao.FechaSQLlite;

  end;

end;

procedure TModelDados.RecebeResolucao;
var
  vSQL: String;
begin

  vSQL := 'select * from resolucao';

  try

    { RECEBER RESOLUCAO DO WS }
    FJsonDataSet := ClientModule.ServerMethods1Client.Get(vSQL);
    FMentResolucaoWs.Close;
    FMentResolucaoWs.AppendData(TFDJSONDataSetsReader.GetListValue
      (FJsonDataSet, 0));
    FMentResolucaoWs.Open;

    { GRAVA NO BANCO SQLLITE }
    ExectSQL(SQL_DeleteResolucao);
    FMentToQry(FMentResolucaoWs, FQryResolucao);

  except
    FrmPrincipal.fMensagemErro := 'Não foi executar RecebeResolucao';
    raise

  end;

end;

procedure TModelDados.ReceberProdutosWs(pIdTv: String);
var
  vSQL, resultado: String;
begin

  vSQL := ' select p.codbarra,descricao, vrvenda,unidade,promocao from produtos p'
    + ' left join tv_prod tp on (tp.codbarra = p.codbarra)' +
    ' where idtv = ' + pIdTv;

  try

    try

      { RECEBE PRODUTOS DO WS }
      FJsonDataSet := ClientModule.ServerMethods1Client.Get(vSQL);
      FMentProdWs.Close;
      FMentProdWs.AppendData(TFDJSONDataSetsReader.GetListValue
        (FJsonDataSet, 0));
      FMentProdWs.Open;

      ExectSQL(SQL_UpdateIDRProd);
      { INSERIE NO BANCO SQLLITE }
      FMentToQry(FMentProdWs, FQryProdutos);
      ExectSQL(SQL_DeletaIDRProd);

    except
      FrmPrincipal.fMensagemErro :=
        'Não foi possivel deletar os registro de produtos do SQLlite';
      raise

    end;

  finally
    FMentProdWs.Close;
    FQryProdutos.Close;
    ModelConexao.FechaSQLlite;

  end;

end;

procedure TModelDados.RecebeTvsWs;
var
  vSQL: String;
begin

  vSQL := ' select idtv,descricaotv,iptv from tv';

  try

    try

      { RECEBE TV DO WS }
      FJsonDataSet := ClientModule.ServerMethods1Client.Get(vSQL);

      FMentTvWs := TFDMemTable.Create(self);
      FMentTvWs.Close;
      FMentTvWs.AppendData(TFDJSONDataSetsReader.GetListValue(FJsonDataSet, 0));
      FMentTvWs.Open;
      ExectSQL(SQL_UpdateIDRTv);

      { INSERI TV NO SQLLITE }
      FMentToQry(FMentTvWs, FQryTv);
      ExectSQL(SQL_DeletaIDRTv);

    except
      FrmPrincipal.fMensagemErro :=
        'Não foi possivel Receber os registro de TV do Ws';
      raise
    end;

  finally

    FMentTvWs.Close;
    FQryTv.Close;

  end;

end;

procedure TModelDados.SalvaConfigWs(pHost, pPorta: String);
var
  vSQL: String;

begin

  vSQL := 'Update tab_config set hostWs = ' + QuotedStr(pHost) + ',' +
    ' PortaWs = ' + FrmPrincipal.ifVasiu(pPorta, 'null');

  try
    ExectSQL(vSQL);
  except
    FrmPrincipal.fMensagemErro :=
      'Não foi possivel Salvar as configuracao do Ws no banco SQLlite';
    raise

  end;

end;

procedure TModelDados.SalvaConfiTv(pIdTv: String);
var
  vSQL: String;
begin
  vSQL := 'Update tab_config set IdTv = ' + pIdTv;

  try
    ExectSQL(vSQL);
  except
    FrmPrincipal.fMensagemErro :=
      'Não foi possivel Salvar as configuracao da Tv no banco SQLlite';
    raise

  end;

end;

function TModelDados.SQL_DeletaIDRProd: String;
begin

  result := 'Delete from tab_produtos where idr = ''E''';

end;

function TModelDados.SQL_DeletaIDRTv: String;
begin

  result := 'Delete from tab_tv where idr = ''E''';

end;

function TModelDados.SQL_DeleteResolucao: string;
begin

  result := 'delete from tab_resolucao where idresolucao <> 1';

end;

function TModelDados.SQL_InsertTabConfigInicial: String;
begin

  result := 'Insert into tab_config (idtv,idresolucao) values (0,2)';

end;

function TModelDados.SQL_UpdateIDRProd: String;
begin

  result := 'Update tab_produtos set idr = ''E''';

end;

function TModelDados.SQL_UpdateIDRTv: String;
begin

  result := 'Update tab_tv set idr = ''E''';

end;

end.
