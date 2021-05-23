program ServerSmartPro99;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.FrmPrincipal in 'View\View.FrmPrincipal.pas' {FrmPrincipal},
  uServerMethod in 'Units\uServerMethod.pas' {DmServerMethod: TDataModule},
  uDm in 'Units\uDm.pas' {Dm: TDataModule},
  uFiredac in 'Units\uFiredac.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TDmServerMethod, DmServerMethod);
  Application.CreateForm(TDm, Dm);
  Application.Run;
end.
