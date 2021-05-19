program AppSmartPro99;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Principal in 'View\View.Principal.pas' {ViewPrincipal},
  View.TabelaPreco in 'View\View.TabelaPreco.pas' {ViewTabelaPreco: TFrame},
  View.Configuracao in 'View\View.Configuracao.pas' {ViewConfiguracoes: TFrame},
  View.Frames.TabelaCores in 'View\Frames\View.Frames.TabelaCores.pas' {FrameTabelaCores: TFrame},
  View.Frames.ItemLista in 'View\Frames\View.Frames.ItemLista.pas' {FrameItemList: TFrame},
  Model.Behaviors in 'Model\Behaviors\Model.Behaviors.pas',
  Model.Components.RestDataWare.Interfaces in 'Model\Components\RestDataWare\Model.Components.RestDataWare.Interfaces.pas',
  Model.Components.RestDataWare in 'Model\Components\RestDataWare\Model.Components.RestDataWare.pas',
  Units.uFiredac in 'Untis\Units.uFiredac.pas',
  Units.Dm in 'Untis\Units.Dm.pas' {Dm: TDataModule},
  Units.uRestDataWare in 'Untis\Units.uRestDataWare.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TViewPrincipal, ViewPrincipal);
  Application.CreateForm(TDm, Dm);
  Application.Run;
end.
