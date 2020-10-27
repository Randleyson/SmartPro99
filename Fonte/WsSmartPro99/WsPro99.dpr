program WsPro99;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  ufrm_Principal in 'Untis\ufrm_Principal.pas' {frmPrincipal},
  ServerMethods in 'Untis\ServerMethods.pas' {ServerMethods1: TDSServerModule},
  ServerContainer in 'Untis\ServerContainer.pas' {ServerContainer1: TDataModule},
  WebModule in 'Untis\WebModule.pas' {WebModule1: TWebModule},
  udm_Principal in 'DataModule\udm_Principal.pas' {dmPrincipal: TDataModule},
  udm_Conexao in 'DataModule\udm_Conexao.pas' {dmConexao: TDataModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
