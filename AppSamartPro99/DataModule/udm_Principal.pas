unit udm_Principal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client,Data.FireDACJSONReflect, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin,System.IOUtils
  {$IFDEF MSWINDOWS}
  ,vcl.Forms
  {$ENDIF};

type
  TDmPrincipal = class(TDataModule)
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
  private
    { Private declarations }
    FJsonDataSet: TFDJSONDataSets;
    procedure ExectSQL(pSQL: string);

    {Comando SQL}
    function SQL_UpdateIDRProd : String;
    function SQL_DeletaIDRProd : String;
    function SQL_UpdateIDRTv : String;
    function SQL_DeletaIDRTv : String;
    function SQL_InsertTabConfigInicial: String;

  public
    { Public declarations }
    function TestaConexaoWS: Boolean;
    Procedure ReceberProdutosWs(pIdTv: String);
    procedure RecebeTvsWs;
    procedure CarregaParamentros;
    procedure AlteraConfiguracaoTv(pIdTv,pResolucao: String);

    procedure SalvaConfigWs(pHost,pPorta: String);
    procedure SalvaConfiTv(pIdtv: String);

    procedure GravarConfigWs(pHost,pPorta: string);
    procedure QryToFMent(pQry: TFDQuery; pFMent: TFDMemTable);

  end;

var
  DmPrincipal: TDmPrincipal;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses uClientModule, ufrm_Principal, udm_conectSQLlite, uframe_Logs;

{$R *.dfm}

{ TDmPrincipal }

function TDmPrincipal.TestaConexaoWS: Boolean;
begin

  try

    ClientModule.DSRestConnection.host := FrmPrincipal.fHostWs;
    ClientModule.DSRestConnection.Port := StrToInt(FrmPrincipal.fPortaWs);
    ClientModule.DSRestConnection.TestConnection();
    Result                             := True;
    FrmPrincipal.fStatusConexaoWs      := 0;

  Except

    Result                             := False;
    FrmPrincipal.fStatusConexaoWs      := 1;

  end;

end;


procedure TDmPrincipal.AlteraConfiguracaoTv(pIdTv,pResolucao: String);
var
  vSQL: string;
begin

  vSQL := 'update tab_config set idtv = '+ pIdTv+ ', idresolucao = '+ pResolucao;

  try

    DmPrincipal.ExectSQL(vSQL);

  except
    FrmPrincipal.fMensagemErro := 'Erro ao AlteraTvAtual';
    raise

  end;

end;

procedure TDmPrincipal.CarregaParamentros;
begin

 try

   QryToFMent(FQryTabConfig,FMentConfig);

   if FMentConfig.RecordCount = 0 then
   begin
     ExectSQL(SQL_InsertTabConfigInicial);
     QryToFMent(FQryTabConfig,FMentConfig);
   end;

   FrmPrincipal.fIdTvAtual      := FMentConfig.FieldByName('idtv').AsString;
   FrmPrincipal.fHostWs         := FMentConfig.FieldByName('hostWs').AsString;
   FrmPrincipal.fPortaWs        := FMentConfig.FieldByName('PortaWs').AsString;
   FrmPrincipal.fResolucaoAtual := FMentConfig.FieldByName('idResolucao').AsInteger;

 except
   FrmPrincipal.fMensagemErro := 'Não foi possivel Carregar os paramentros de configuracao ';
   raise;
 end;

end;

procedure TDmPrincipal.ExectSQL(pSQL: string);
begin

  try

    try

      if not dmConectSQLlite.FDC_SqlLite.Connected then
      dmConectSQLlite.AbreConexaoSQLlite;

      dmConectSQLlite.FDC_SqlLite.ExecSQL(pSQL);
      dmConectSQLlite.FDC_SqlLite.Commit;

    except
      raise
    end;

  finally
    dmConectSQLlite.FechaSQLlite;

  end;

end;

procedure TDmPrincipal.GravarConfigWs(pHost, pPorta: string);
var
  vSQL: String;
begin

  vSQL := 'update tab_config set hostws ='+QuotedStr(pHost)+' , portaws = '+ QuotedStr(pPorta);

  try

    ExectSQL(vSQL);

  except
    FrmPrincipal.fMensagemErro := 'Erro ao excutar GravarConfigWs';
    raise

  end;



end;

procedure TDmPrincipal.QryToFMent(pQry: TFDQuery; pFMent: TFDMemTable);
begin

  try

    try

      dmConectSQLlite.AbreConexaoSQLlite;
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
    dmConectSQLlite.FechaSQLlite;

  end;

end;

procedure TDmPrincipal.ReceberProdutosWs(pIdTv: String);
var
  vSQL: String;
begin

  vSQL := ' select p.codbarra,descricao,vrvenda from produtos p'+
          ' left join tv_prod tp on (tp.codbarra = p.codbarra)'+
          ' where idtv = '+ pIdTv ;

  try


    try

      {Receber Produtos do Ws}

      FJsonDataSet          := ClientModule.ServerMethods1Client.Get(vSQL);
      FMentProdWs.Close;
      FMentProdWs.AppendData(TFDJSONDataSetsReader.GetListValue(FJsonDataSet,0));
      FMentProdWs.Open;

      {Inserir No SQLite}
      ExectSQL(SQL_UpdateIDRProd);

      dmConectSQLlite.AbreConexaoSQLlite;
      FQryProdutos.Close;
      FQryProdutos.Open;
      FQryProdutos.EmptyDataSet;
      FQryProdutos.CopyDataSet(FMentProdWs);

      ExectSQL(SQL_DeletaIDRProd);

    except
      FrmPrincipal.fMensagemErro := 'Não foi possivel deletar os registro de produtos do SQLlite';
      raise

    end;

  finally
    FMentProdWs.Close;
    FQryProdutos.Close;
    dmConectSQLlite.FechaSQLlite;

  end;

end;

procedure TDmPrincipal.RecebeTvsWs;
var
  vSQL: String;
begin

  vSQL := ' select idtv,descricaotv,iptv from tv';

  try

    try
      {Receber TV do Ws}
      FJsonDataSet := ClientModule.ServerMethods1Client.Get(vSQL);

      FMentTvWs := TFDMemTable.Create(self);
      FMentTvWs.Close;
      FMentTvWs.AppendData(TFDJSONDataSetsReader.GetListValue(FJsonDataSet,0));
      FMentTvWs.Open;

      {Inserio os dados no SQLlite}
      ExectSQL(SQL_UpdateIDRTv);

      FQryTv.Close;
      FQryTv.Open;
      FQryTv.EmptyDataSet;
      FQryTv.CopyDataSet(FMentTvWs);

      ExectSQL(SQL_DeletaIDRTv);

    except
      FrmPrincipal.fMensagemErro := 'Não foi possivel Receber os registro de TV do Ws';
      raise
    end;

  finally

    FMentTvWS.Close;
    FQryTv.Close;

  end;

end;

procedure TDmPrincipal.SalvaConfigWs(pHost, pPorta: String);
var
  vSQL : String;

begin

  vSQL := 'Update tab_config set hostWs = '+ QuotedStr(pHost)+ ','+
          ' PortaWs = ' + FrmPrincipal.ifVasiu(pPorta,'null');
          
   try
    ExectSQL(vSQL);
  except
    FrmPrincipal.fMensagemErro := 'Não foi possivel Salvar as configuracao do Ws no banco SQLlite';
    raise

  end;

end;

procedure TDmPrincipal.SalvaConfiTv(pIdtv: String);
var
  vSQL: String;
begin
  vSQL := 'Update tab_config set IdTv = '+ pIdtv;

  try
    ExectSQL(vSQL);
  except
    FrmPrincipal.fMensagemErro := 'Não foi possivel Salvar as configuracao da Tv no banco SQLlite';
    raise

  end;

end;

function TDmPrincipal.SQL_DeletaIDRProd: String;
begin

  Result := 'Delete from tab_produtos where idr = ''E''';

end;

function TDmPrincipal.SQL_DeletaIDRTv: String;
begin

  Result := 'Delete from tab_tv where idr = ''E''';

end;

function TDmPrincipal.SQL_InsertTabConfigInicial: String;
begin

  Result := 'Insert into tab_config (idtv) values (0)';

end;

function TDmPrincipal.SQL_UpdateIDRProd: String;
begin

  Result := 'Update tab_produtos set idr = ''E''';

end;

function TDmPrincipal.SQL_UpdateIDRTv: String;
begin

  Result := 'Update tab_tv set idr = ''E''';

end;

end.
