unit View.FrmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Menus;

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
    BtnTvs: TRectangle;
    Label3: TLabel;
    ToolBar: TToolBar;
    Label4: TLabel;
    LblUsuario: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnConfiguracaoClick(Sender: TObject);
    procedure BtnProdutosClick(Sender: TObject);
    procedure BtnTvsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure FecharAplicacao;
    procedure IniciaFrmPrincial;
    procedure AbreFrmConfiguracao;
    procedure AbreFrmProduto;
    procedure AbreFrmTvs;
  public
    { Public declarations }
  end;

var
  ViewFrmPrincipal: TViewFrmPrincipal;

implementation

{$R *.fmx}

uses Controller.oUsuario, Controller.uFarctory;

procedure TViewFrmPrincipal.AbreFrmConfiguracao;
begin
  uFarctory.ConfiguracaoView.ShowModal;
end;

procedure TViewFrmPrincipal.AbreFrmProduto;
begin
  uFarctory.ProdutosView.ShowModal;

end;

procedure TViewFrmPrincipal.AbreFrmTvs;
begin
  uFarctory.TvsView.ShowModal;

end;

procedure TViewFrmPrincipal.BtnConfiguracaoClick(Sender: TObject);
begin
  AbreFrmConfiguracao;
end;

procedure TViewFrmPrincipal.BtnProdutosClick(Sender: TObject);
begin
  AbreFrmProduto;
end;

procedure TViewFrmPrincipal.BtnTvsClick(Sender: TObject);
begin
  AbreFrmTvs;
end;

procedure TViewFrmPrincipal.FecharAplicacao;
begin
  FreeAndNil(uFarctory);
end;

procedure TViewFrmPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FecharAplicacao;
end;

procedure TViewFrmPrincipal.FormShow(Sender: TObject);
begin
  IniciaFrmPrincial;
end;

procedure TViewFrmPrincipal.IniciaFrmPrincial;
begin
  LblUsuario.Text := IntToStr(oUsuario.CodUsuario) + ' - ' + oUsuario.Nome;

end;

end.
