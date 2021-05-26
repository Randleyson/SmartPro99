unit View.FrmPrincipal;

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
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Menus,
  FMX.Layouts;

type
  TViewFrmPrincipal = class(TForm)
    MenuBar: TMenuBar;
    SmartPro99: TMenuItem;
    Cadastro: TMenuItem;
    Configuração: TMenuItem;
    Ajudas: TMenuItem;
    Sair: TMenuItem;
    Produtos: TMenuItem;
    Usuarios: TMenuItem;
    Tvs: TMenuItem;
    RectBotao: TRectangle;
    BtnConfiguracao: TRectangle;
    Label1: TLabel;
    BtnProdutos: TRectangle;
    Label2: TLabel;
    Label3: TLabel;
    ToolBar: TToolBar;
    Label4: TLabel;
    LblUsuario: TLabel;
    RectClient: TRectangle;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Layout1: TLayout;
    LytFrame: TLayout;
    procedure BtnConfiguracaoClick(Sender: TObject);
    procedure BtnProdutosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RectBotaoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FUsuario: String;
    const cVersao: String = '2.0.0';
    procedure FinalizaFrames;
  public
    { Public declarations }
    property Usuario: String read FUsuario write FUsuario;
  end;

var
  ViewFrmPrincipal: TViewFrmPrincipal;

implementation

{$R *.fmx}

uses  View.CadProdutos,
      View.Configuracao,
      View.CadTVs;

procedure TViewFrmPrincipal.BtnConfiguracaoClick(Sender: TObject);
begin
  FinalizaFrames;
  if not Assigned(FrameConfiguracao) then
    FrameConfiguracao       := TFrameConfiguracao.Create(Nil);
  FrameConfiguracao.Parent  := LytFrame;
  FrameConfiguracao.BringToFront;
end;

procedure TViewFrmPrincipal.BtnProdutosClick(Sender: TObject);
begin
  FinalizaFrames;
  if not Assigned(FrameCadProdutos) then
    FrameCadProdutos      := TFrameCadProdutos.Create(Nil);
  FrameCadProdutos.Parent := LytFrame;
  FrameCadProdutos.BringToFront;
end;

procedure TViewFrmPrincipal.FinalizaFrames;
begin
  if Assigned(FrameCadProdutos) then
    FrameCadProdutos.CloseCadProduto;
  if Assigned(FrameConfiguracao) then
    FrameConfiguracao.CloseConfiguracao;
  if Assigned(FrameCadTVs) then
    FrameCadTVs.CloseCadTVs;
end;

procedure TViewFrmPrincipal.FormDestroy(Sender: TObject);
begin
  FinalizaFrames;
end;

procedure TViewFrmPrincipal.FormShow(Sender: TObject);
begin
  LblUsuario.Text := 'Versão: ' + cVersao;
end;

procedure TViewFrmPrincipal.RectBotaoClick(Sender: TObject);
begin
  FinalizaFrames;
  if not Assigned(FrameCadTVs) then
    FrameCadTVs       := TFrameCadTVs.Create(Nil);
  FrameCadTVs.Parent  := LytFrame;
  FrameCadTVs.BringToFront;
end;

end.
