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
  Controller.oSincronizacao in 'Controller\Controller.oSincronizacao.pas',
  Controller.uSincronizacao in 'Controller\Controller.uSincronizacao.pas',
  Module.DmSincronizacao in 'Module\Module.DmSincronizacao.pas' {DmSincronizacao: TDataModule},
  Controller.uUtil in 'Controller\Controller.uUtil.pas',
  uDm in 'Dm\uDm.pas' {Dm: TDataModule},
  uFiredac in 'Units\uFiredac.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TDm, Dm);
  Application.Run;
end.
