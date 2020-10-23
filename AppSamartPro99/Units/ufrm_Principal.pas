unit ufrm_Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, FMX.TabControl, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFrmPrincipal = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }


  public
    { Public declarations }
    fIdTvAtual: String;
    fHostWs: String;
    fPortaWs: String;
    fResolucaoAtual: integer;
    fComErro: Boolean;
    fMensagemErro: String;
    fStatusConexaoWs: Integer;
    fNovaCarga: Boolean;

    procedure RecebeAtualizaWs;

    function ifVasiu(pCampo,pRetorno: string): String;
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}
{$R *.LgXhdpiTb.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPhone55in.fmx IOS}
{$R *.iPhone.fmx IOS}

uses udm_Principal, uClientModule, uframe_TabelaPreco, uframe_Configuracao,
  Loading, uframe_MensagemInfor, udm_conectSQLlite, uframe_Logs, Resolucao;

procedure TFrmPrincipal.Button1Click(Sender: TObject);
begin

    try
        ClientModule.DSRestConnection.TestConnection();
      Except
      On E:Exception do showmessage(E.Message);
      end;

end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin

  try
    if not Assigned(dmConectSQLlite) then
    dmConectSQLlite := TdmConectSQLlite.Create(self);

    if not Assigned(DmPrincipal) then
    DmPrincipal  := TDmPrincipal.Create(self);

    if not Assigned(ClientModule) then
    ClientModule := TClientModule.Create(self);

  except
    FrameMsgInfor.CreateFrameMsgInfor(FrmPrincipal.fMensagemErro);

  end;

end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin

  FrameLogs.CreateFrameLogs;

  if fComErro then
  begin
    FrameLogs.AddLogs(FrmPrincipal.fMensagemErro);
    exit;
  end;

  try

    DmPrincipal.CarregaParamentros;
    Width        := TResolucao.LfrmPrinc; //Screen.Width;
    Height       := TResolucao.AfrmPrinc; //Screen.Height;

    if DmPrincipal.TestaConexaoWS then
    begin

      dmPrincipal.ReceberProdutosWs(FrmPrincipal.fIdTvAtual);
      FrameTabelaPreco.CreateFrameTabelaPreco;

    end
    else
    begin

      FrameTabelaPreco.CreateFrameTabelaPreco;
      FrameMsgInfor.CreateFrameMsgInfor('Não foi possivel conectar ao servidor. Favor verificar as configuração de conexão')

    end;

  except
  on E: Exception do
    begin
      FrmPrincipal.fComErro := True;
      FrameMsgInfor.CreateFrameMsgInfor('Não foi possivel iniciar o aplicativo Erro : '+E.Message);

    end;

  end;

end;

function TFrmPrincipal.ifVasiu(pCampo,pRetorno: string): String;
begin

  if pCampo = '' then
  Result := pRetorno
  else
  result := pCampo


end;

procedure TFrmPrincipal.RecebeAtualizaWs;
begin

  try

    DmPrincipal.CarregaParamentros;
    if DmPrincipal.TestaConexaoWS then
    begin

      DmPrincipal.ReceberProdutosWs(FrmPrincipal.fIdTvAtual);
      fNovaCarga := True;

    end;

  except
    raise;

  end;

end;


end.
