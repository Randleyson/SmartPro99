unit ufrm_Principal;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp, Vcl.ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    edtPorta: TEdit;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    ButtonOpenBrowser: TButton;
    tmSincronizaTxt: TTimer;
    menoLogs: TMemo;
    Label2: TLabel;
    Panel1: TPanel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure ButtonOpenBrowserClick(Sender: TObject);
    procedure tmSincronizaTxtTimer(Sender: TObject);
  private
    { Private declarations }
    FServer: TIdHTTPWebBrokerBridge;
    procedure StartServer;
    procedure AbiriArquivoTx;
    function ExtraiCodBarra(pLinha: String): String;
    function ExtraiDescricao(pLinha: string): String;
    function ExtraiVrvenda(pLinha: String): String;
    function CodBarraExite(pCodBarra: string): Boolean;
    procedure LerLinhaArquivo;



  public
    { Public declarations }
    fArquivoTxt : TextFile;
    fLinha: String;
    fTipoArquivo: String;
    fCaminhoArquivo: String;
    fMensagemErro: string;
    procedure SicronizaProduto;

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses
  WinApi.Windows, Winapi.ShellApi, Datasnap.DSSession, ServerMethods,
  udm_Principal, udm_Conexao;

procedure TfrmPrincipal.AbiriArquivoTx;
begin

  try

    AssignFile(fArquivoTxt, fCaminhoArquivo);
    reset(fArquivoTxt);

  except
    frmPrincipal.fMensagemErro := 'Erro ao abir o arquivo de TXT';
    raise

  end;

end;

procedure TfrmPrincipal.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  btnStart.Enabled := not FServer.Active;
  btnStop.Enabled := FServer.Active;
  edtPorta.Enabled := not FServer.Active;
end;

procedure TfrmPrincipal.ButtonOpenBrowserClick(Sender: TObject);
var
  LURL: string;
begin
  StartServer;
  LURL := Format('http://localhost:%s', [edtPorta.Text]);
  ShellExecute(0,
        nil,
        PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

function TfrmPrincipal.CodBarraExite(pCodBarra: string): Boolean;
begin

  try

    Result := False;
    with dmPrincipal.FQryProduto do
    begin

      Active := False;
      Filter := ' codbarra = '+ QuotedStr(pCodBarra);
      Filtered := True;
      Active := True;

      if RecordCount > 0 then
      Result := True;

    end;

  except
    frmPrincipal.fMensagemErro := 'Não foi posivel verificar se exite codbarra';
    raise

  end;

end;

procedure TfrmPrincipal.btnStartClick(Sender: TObject);
begin

  try

    if not dmConexao.fConexaoFreeboard then
    begin
      menoLogs.Lines.Add(frmPrincipal.fMensagemErro);
      exit;
    end;

    StartServer;
    tmSincronizaTxt.Enabled := True;
    menoLogs.Lines.Add('WS ativado : ' + DateTimeToStr(now));

  except
    on e: exception do
    menoLogs.Lines.Add('Erro ao startar o serviço Ws : '+ E.Message);

  end;

end;

procedure TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

procedure TfrmPrincipal.btnStopClick(Sender: TObject);
begin

  TerminateThreads;
  FServer.Active := False;
  FServer.Bindings.Clear;
  tmSincronizaTxt.Enabled := False;
  menoLogs.Lines.Add('Ws parado : '+ DateTimeToStr(now))

end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin

  try

    FServer := TIdHTTPWebBrokerBridge.Create(Self);
    ButtonOpenBrowser.Visible := False;

    if not Assigned(dmPrincipal) then
    dmPrincipal := TdmPrincipal.Create(self);


    if  not Assigned(dmConexao) then
    dmConexao := TdmConexao.Create(self);

    if not dmConexao.fConexaoFreeboard then
    menoLogs.Lines.Add(frmPrincipal.fMensagemErro);


  except
  
    menoLogs.Lines.Add('Erro : '+ fMensagemErro);

  end;

end;


procedure TfrmPrincipal.LerLinhaArquivo;
var
  vCodbarra,vDescricao,vVrvenda: string;
begin

  try

    Readln(frmPrincipal.fArquivoTxt,fLinha);

    if Length(fLinha) < 50 then
    exit;

    vCodbarra  := ExtraiCodBarra(fLinha);
    vDescricao := ExtraiDescricao(fLinha);
    vVrVenda   := ExtraiVrvenda(fLinha);

    if CodBarraExite(vCodbarra) then
    dmPrincipal.UpdateProduto(vCodbarra,vDescricao,vVrVenda)
    else
    dmPrincipal.InserieProduto(vCodbarra,vDescricao,vVrVenda);

  except
    raise
  end;


end;

function TfrmPrincipal.ExtraiCodBarra(pLinha: String): String;
begin

  if frmPrincipal.fTipoArquivo = '1' then
  begin

    try

      result := Copy(fLinha,6,6);

    except
      frmPrincipal.fMensagemErro := 'Não foi possivel ExtraiCodBarra';
      raise

    end;

  end;

end;

function TfrmPrincipal.ExtraiDescricao(pLinha: string): String;
begin

  if frmPrincipal.fTipoArquivo = '1' then
  begin

    try

      result := Copy(fLinha,21,25);

    except
      frmPrincipal.fMensagemErro := 'Não foi possivel ExtraiDescricao';
      raise

    end;

  end;

end;


function TfrmPrincipal.ExtraiVrvenda(pLinha: String): String;
begin

  if frmPrincipal.fTipoArquivo = '1' then
  begin

    try

      result := copy(Copy(fLinha,12,6),0,4)+'.'+ copy(Copy(fLinha,12,6),5,2);

    except
      frmPrincipal.fMensagemErro := 'Não foi possivel Extrai valor de venda';
      raise

    end;

  end;

end;


procedure TfrmPrincipal.SicronizaProduto;
begin

  try

    dmPrincipal.ParamentroConfiguracao;

    if not fileexists(fCaminhoArquivo) then
    begin
      menoLogs.Lines.Add(fCaminhoArquivo + ' - O caminho do arquivo nao existe.');
      exit
    end;

  except
  on E: Exception do
        menoLogs.Lines.Add(frmPrincipal.fMensagemErro+ E.message);
  end;

  menoLogs.Lines.Add('Processo de Sicronizar Produto Inciado - ' + DateTimeToStr(now));
  TThread.CreateAnonymousThread(procedure
  begin

    try
      try

        AbiriArquivoTx;
        dmPrincipal.MarcaProdExisteNoArqNao;

        while not EOF(fArquivoTxt) do
        LerLinhaArquivo;

        dmPrincipal.DeletaProdNaoNoArq;
        CloseFile(fArquivoTxt);
        menoLogs.Lines.Add('Processo de sicronizar produtos finalizou - '+ DateTimeToStr(now));

      except
      on E: Exception do
        menoLogs.Lines.Add(frmPrincipal.fMensagemErro+ E.message);

      end;

    finally
      TThread.Synchronize(nil,procedure
      begin

      end);

    end;
  end).Start;

end;


procedure TfrmPrincipal.StartServer;
begin

  if not FServer.Active then
  begin

    FServer.Bindings.Clear;
    FServer.DefaultPort := StrToInt(edtPorta.Text);
    FServer.Active := True;

  end;

end;

procedure TfrmPrincipal.tmSincronizaTxtTimer(Sender: TObject);
begin

  try

    SicronizaProduto;

  except
    menoLogs.Lines.Add(frmPrincipal.fMensagemErro);

  end;

end;

end.
