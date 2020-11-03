unit SmartPro99.View.FrmPrincipal;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.ListBox,
  FMX.TabControl,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Objects;

type
  TFrmPrincipal = class(TForm)
    tmSplash: TTimer;
    Image1: TImage;
    Rectangle1: TRectangle;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmSplashTimer(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    fIdTvAtual: String;
    fHostWs: String;
    fPortaWs: String;
    fResolucaoAtual: integer;
    fIPlocal: string;
    fComErro: Boolean;
    fMensagemErro: String;
    fStatusConexaoWs: integer;
    fNovaCarga: Boolean;

    procedure RecebeAtualizaWs;

    function ifVasiu(pCampo, pRetorno: string): String;
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}
{$R *.LgXhdpiTb.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPhone55in.fmx IOS}
{$R *.iPhone.fmx IOS}

uses uClientModule, SmartPro99.View.Message, SmarPro99.Model.Dados,
  SmarPro99.Model.Conexao, SmartPro99.View.TabelaDePreco,
  SmartPro99.Classe.Resolucao;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin

  try

    tmSplash.Interval := 3000;

  except
    FrameMsgInfor.CreateFrameMsgInfor(FrmPrincipal.fMensagemErro);

  end;

end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin

  tmSplash.Enabled := True;

end;

function TFrmPrincipal.ifVasiu(pCampo, pRetorno: string): String;
begin

  if pCampo = '' then
    Result := pRetorno
  else
    Result := pCampo

end;

procedure TFrmPrincipal.RecebeAtualizaWs;
begin

  try

    ModelDados.CarregaParamentros;
    if ModelDados.TestaConexaoWS then
    begin

      ModelDados.ReceberProdutosWs(FrmPrincipal.fIdTvAtual);
      ModelDados.RecebeResolucao;
      fNovaCarga := True;

    end;

  except
    raise;

  end;

end;

procedure TFrmPrincipal.tmSplashTimer(Sender: TObject);
begin

  try
    try

      if not Assigned(ModelConexao) then
        ModelConexao := TModelConexao.Create(self);

      if not Assigned(ModelDados) then
        ModelDados := TModelDados.Create(self);

      if not Assigned(ClientModule) then
        ClientModule := TClientModule.Create(self);

      ModelDados.CarregaParamentros;

      if ModelDados.TestaConexaoWS then
      begin

        RecebeAtualizaWs;
        VeiwTabelaDePreco.CreateFrameTabelaPreco;

      end
      else
      begin

        VeiwTabelaDePreco.CreateFrameTabelaPreco;
        FrameMsgInfor.CreateFrameMsgInfor
          ('Não foi possivel conectar ao servidor. Favor verificar as configuração de conexão')

      end;

      Width := TResolucao.fLargFrmPrinc; // Screen.Width;
      Height := TResolucao.fAlturaFrmPrinc; // Screen.Height;

    except
      on E: Exception do
      begin
        FrmPrincipal.fComErro := True;
        FrameMsgInfor.CreateFrameMsgInfor
          ('Não foi possivel iniciar o aplicativo Erro : ' + E.Message);

      end;

    end;

  finally
    tmSplash.Enabled := False;

  end;
end;

end.
