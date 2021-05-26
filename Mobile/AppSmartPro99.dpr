program AppSmartPro99;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Principal in 'View\View.Principal.pas' {FrmPrincipal},
  View.TabelaPreco in 'View\View.TabelaPreco.pas' {ViewTabelaPreco: TFrame},
  View.Configuracao in 'View\View.Configuracao.pas' {ViewConfiguracoes: TFrame},
  View.Frames.TabelaCores in 'View\Frames\View.Frames.TabelaCores.pas' {FrameTabelaCores: TFrame},
  View.Frames.ItemLista in 'View\Frames\View.Frames.ItemLista.pas' {FrameItemList: TFrame},
  uBehaviors in 'Untis\uBehaviors.pas',
  uFiredac in 'Untis\uFiredac.pas',
  Units.Dm in 'Untis\Units.Dm.pas' {Dm: TDataModule},
  uRestDataWare in 'Untis\uRestDataWare.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TDm, Dm);
  Application.Run;
end.
