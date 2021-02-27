program WsApolloGestaoMobile;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.FrmPrincipal in 'View\View.FrmPrincipal.pas' {FrmPrincipal},
  Module.ServerMethod in 'Module\Module.ServerMethod.pas' {DmServerMethod: TDataModule},
  Dao.ConexaoDB in 'Dao\Dao.ConexaoDB.pas' {ConexaoOracle: TDataModule},
  Controller.oConfiguracao in 'Controller\Controller.oConfiguracao.pas',
  Module.DmConfiguracao in 'Module\Module.DmConfiguracao.pas' {DmConfiguracao: TDataModule},
  Controller.uConfiguracao in 'Controller\Controller.uConfiguracao.pas',
  Controller.uConexaoSQL in 'Controller\Controller.uConexaoSQL.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
