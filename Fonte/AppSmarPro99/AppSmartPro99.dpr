program AppSmartPro99;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrm_Principal in 'Units\ufrm_Principal.pas' {FrmPrincipal},
  udm_Principal in 'DataModule\udm_Principal.pas' {DmPrincipal: TDataModule},
  uClientClasses in 'ClientModule\uClientClasses.pas',
  uClientModule in 'ClientModule\uClientModule.pas' {ClientModule: TDataModule},
  uframe_Configuracao in 'Units\uframe_Configuracao.pas' {FrameConfig: TFrame},
  uframe_TabelaPreco in 'Units\uframe_TabelaPreco.pas' {FrameTabelaPreco: TFrame},
  uframe_FTabelaPreco in 'Units\uframe_FTabelaPreco.pas' {FrameFPreco: TFrame},
  Loading in 'Units\Loading.pas',
  uframe_MensagemInfor in 'Units\uframe_MensagemInfor.pas' {FrameMensagemInfor: TFrame},
  uframe_Logs in 'Units\uframe_Logs.pas' {FrameLogs: TFrame},
  uframa_Edit in 'Units\uframa_Edit.pas' {FrameEdit: TFrame},
  udm_conectSQLlite in 'DataModule\udm_conectSQLlite.pas' {dmConectSQLlite: TDataModule},
  Resolucao in 'Units\Resolucao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
