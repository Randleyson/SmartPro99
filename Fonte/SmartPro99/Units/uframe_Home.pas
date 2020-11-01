unit uframe_Home;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, FMX.Effects,
  FMX.Filter.Effects;

type
  TFrameHome = class(TFrame)
    Rectangle1: TRectangle;
    LayoutTitulo: TLayout;
    Label1: TLabel;
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
   FrameHome:TFrameHome;

implementation

{$R *.fmx}

uses ufrm_Principal, uframe_Config, uframe_CadTvs, uframe_CadProduto,
  udm_Conexao, udm_Principal, udm_CadProduto, Loading, u_Message;

{ TFrameHome }

procedure TFrameHome.btnCadProdutoClick(Sender: TObject);
begin

  FrameCadProduto.CreateFrameCadProduto;

end;

procedure TFrameHome.btnCadTvClick(Sender: TObject);
begin

  FrameCadTv.CreateFrameCadTv;

end;

procedure TFrameHome.btnConfiguracaoClick(Sender: TObject);
begin

  FrameConfiguracao.CreateFrameConfig;

end;

procedure TFrameHome.btnFecharAplicacaoClick(Sender: TObject);
begin

  if TMessage.MessagemDlg(frmPrincipal,'Deseja fechar o sistema ?') then
  Application.Terminate;

end;

function TFrameHome.PendenciaProduto: Boolean;
begin

  try

    Result := False;
    if DmPrincipal.LengthDescricao > 0 then
    Result := True;

  except
    raise

  end;


end;

procedure TFrameHome.CreateFremeHome;
begin

  try

    if not assigned(FrameHome) then
    FrameHome := TFrameHome.Create(frmPrincipal);
    with FrameHome do
    begin

      Name      := 'FrameHome';
      Parent    := frmPrincipal;

      imgPendencia.Visible := PendenciaProduto;

      BringToFront;

    end;

  except
    raise

  end;

end;

end.
