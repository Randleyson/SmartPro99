program ServerSmartPro99;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.FrmPrincipal in 'View\View.FrmPrincipal.pas' {FrmPrincipal},
  Module.ServerMethod in 'Module\Module.ServerMethod.pas' {DmServerMethod: TDataModule},
  Dao.ConexaoDB in 'Dao\Dao.ConexaoDB.pas' {DaoConexaoDB: TDataModule},
  Controller.oConfiguracao in 'Controller\Controller.oConfiguracao.pas',
  Module.DmConfiguracao in 'Module\Module.DmConfiguracao.pas' {DmConfiguracao: TDataModule},
  Controller.uConfiguracao in 'Controller\Controller.uConfiguracao.pas',
  Controller.uConexaoSQL in 'Controller\Controller.uConexaoSQL.pas',
  Controller.oTvs in 'Controller\Controller.oTvs.pas',
  Controller.uTvs in 'Controller\Controller.uTvs.pas',
  Module.DmTvs in 'Module\Module.DmTvs.pas' {DmTvs: TDataModule},
  Controller.oSincronizacao in 'Controller\Controller.oSincronizacao.pas',
  Controller.uSincronizacao in 'Controller\Controller.uSincronizacao.pas',
  Module.DmSincronizacao in 'Module\Module.DmSincronizacao.pas' {DmSincronizacao: TDataModule},
  Controller.uUtil in 'Controller\Controller.uUtil.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
