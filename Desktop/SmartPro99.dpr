program SmartPro99;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.FrmLogin in 'View\View.FrmLogin.pas' {ViewFrmLogin},
  View.FrmPrincipal in 'View\View.FrmPrincipal.pas' {ViewFrmPrincipal},
  uUtilis in 'Units\uUtilis.pas',
  View.Frame.Pesquisa in 'View\Frame\View.Frame.Pesquisa.pas' {FramePesquisa: TFrame},
  View.Frame.Cabecalho in 'View\Frame\View.Frame.Cabecalho.pas' {FrameCabecalho: TFrame},
  uMsgDialog in 'Units\uMsgDialog.pas',
  View.Frame.PaletaCores in 'View\Frame\View.Frame.PaletaCores.pas' {FramePaletaCores: TFrame},
  uDm in 'Units\uDm.pas' {Dm: TDataModule},
  uFiredac in 'Units\uFiredac.pas',
  View.Configuracao in 'View\View.Configuracao.pas' {FrameConfiguracao: TFrame},
  View.CadProdutos in 'View\View.CadProdutos.pas' {FrameCadProdutos: TFrame},
  View.CadTVs in 'View\View.CadTVs.pas' {FrameCadTVs: TFrame},
  uEntityTV in 'Units\uEntityTV.pas',
  uModel.Dao.TV in 'Units\uModel.Dao.TV.pas',
  uController in 'Units\uController.pas',
  uTv in 'Units\uTv.pas',
  uProdutos in 'Units\uProdutos.pas',
  uConfiguracao in 'Units\uConfiguracao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TViewFrmPrincipal, ViewFrmPrincipal);
  Application.Run;
end.
