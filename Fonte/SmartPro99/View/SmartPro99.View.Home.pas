unit SmartPro99.View.Home;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, FMX.Effects,
  FMX.Filter.Effects;

type
  TViewHome = class(TFrame)
    Rectangle1: TRectangle;
    LayoutTitulo: TLayout;
    Line1: TLine;
    LayoutRodaPe: TLayout;
    LayoutMenu: TLayout;
    Layout1: TLayout;
    btnConfiguracao: TSpeedButton;
    Image1: TImage;
    Label2: TLabel;
    btnCadProduto: TSpeedButton;
    imgCadProduto: TImage;
    Label4: TLabel;
    btnCadTv: TSpeedButton;
    ImgCatTv: TImage;
    Label3: TLabel;
    btnFecharAplicacao: TSpeedButton;
    Rectangle2: TRectangle;
    FillRGBEffect1: TFillRGBEffect;
    Rectangle3: TRectangle;
    imgPendencia: TImage;
    Layout2: TLayout;
    Image2: TImage;
    Label1: TLabel;
    procedure btnConfiguracaoClick(Sender: TObject);
    procedure btnCadTvClick(Sender: TObject);
    procedure btnFecharAplicacaoClick(Sender: TObject);
    procedure btnCadProdutoClick(Sender: TObject);
  private
    { Private declarations }
    function PendenciaProduto: Boolean;
  public
    { Public declarations }
    procedure CreateFremeHome;
  end;

var
   ViewHome:TViewHome;

implementation

{$R *.fmx}

uses
  SmartPro99.Model.Principal, SmartPro99.View.Principal,
  SmartPro99.View.Configuracao, SmartPro99.View.CadTv,
  SmartPro99.View.CadProduto, SmartPro99.Controlle.Message;

{ TFrameHome }

procedure TViewHome.btnCadProdutoClick(Sender: TObject);
begin

  ViewCadProdutos.CreateFrameCadProduto;

end;

procedure TViewHome.btnCadTvClick(Sender: TObject);
begin

  ViewCadTvs.CreateFrameCadTv;

end;

procedure TViewHome.btnConfiguracaoClick(Sender: TObject);
begin

  ViewConfiguracao.CreateFrameConfig;

end;

procedure TViewHome.btnFecharAplicacaoClick(Sender: TObject);
begin

  if TMessage.MessagemDlg(ViewPrincipal,'Deseja fechar o sistema ?') then
  Application.Terminate;

end;

function TViewHome.PendenciaProduto: Boolean;
begin

  try

    Result := False;
    if ModelPrincipal.LengthDescricao > 0 then
    Result := True;

  except
    raise

  end;


end;

procedure TViewHome.CreateFremeHome;
begin

  try

    if not assigned(ViewHome) then
    ViewHome := TViewHome.Create(ViewPrincipal);
    with ViewHome do
    begin

      Name      := 'FrameHome';
      Parent    := ViewPrincipal;

      imgPendencia.Visible := PendenciaProduto;

      BringToFront;

    end;

  except
    raise

  end;

end;

end.
