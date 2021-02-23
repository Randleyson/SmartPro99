program SmartPro99;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.FrmLogin in 'View\View.FrmLogin.pas' {ViewFrmLogin},
  Controller.uFarctory in 'Controller\Controller.uFarctory.pas',
  View.FrmPrincipal in 'View\View.FrmPrincipal.pas' {ViewFrmPrincipal},
  View.FrmConfiguracao in 'View\View.FrmConfiguracao.pas' {ViewFrmConfiguracao},
  View.FrmProdutos in 'View\View.FrmProdutos.pas' {ViewFrmProdutos},
  Controller.oUsuario in 'Controller\Controller.oUsuario.pas',
  Module.DmUsuario in 'Module\Module.DmUsuario.pas' {DmUsuario: TDataModule},
  Controller.uUsuario in 'Controller\Controller.uUsuario.pas',
  Doa.DmConexaoSQL in 'Dao\Doa.DmConexaoSQL.pas' {DmConexaoSQL: TDataModule},
  Controller.oConfiguracao in 'Controller\Controller.oConfiguracao.pas',
  Controller.uConfiguracao in 'Controller\Controller.uConfiguracao.pas',
  Module.DmConfiguracao in 'Module\Module.DmConfiguracao.pas' {DmConfiguracao: TDataModule},
  Controller.uSmartPro99 in 'Controller\Controller.uSmartPro99.pas',
  Controller.uProdutos in 'Controller\Controller.uProdutos.pas',
  Controller.oProdutos in 'Controller\Controller.oProdutos.pas',
  Module.DmProdutos in 'Module\Module.DmProdutos.pas' {DmProdutos: TDataModule},
  View.Frame.Pesquisa in 'View\Frame\View.Frame.Pesquisa.pas' {FramePesquisa: TFrame},
  Controller.uTvs in 'Controller\Controller.uTvs.pas',
  Controller.oTvs in 'Controller\Controller.oTvs.pas',
  Module.DmTvs in 'Module\Module.DmTvs.pas' {DmTvs: TDataModule},
  View.FrmTvs in 'View\View.FrmTvs.pas' {ViewFrmTvs},
  View.Frame.Cabecalho in 'View\Frame\View.Frame.Cabecalho.pas' {FrameCabecalho: TFrame},
  Controller.uMessageDialog in 'Controller\Controller.uMessageDialog.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TViewFrmLogin, ViewFrmLogin);
  Application.Run;
end.
