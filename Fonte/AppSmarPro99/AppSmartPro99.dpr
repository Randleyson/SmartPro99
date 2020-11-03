program AppSmartPro99;

uses
  System.StartUpCopy,
  FMX.Forms,
  SmartPro99.View.FrmPrincipal in 'View\SmartPro99.View.FrmPrincipal.pas' {FrmPrincipal},
  SmarPro99.Model.Dados in 'Model\SmarPro99.Model.Dados.pas' {ModelDados: TDataModule},
  uClientClasses in 'ClientModule\uClientClasses.pas',
  uClientModule in 'ClientModule\uClientModule.pas' {ClientModule: TDataModule},
  SmartPro99.View.Configuracao in 'View\SmartPro99.View.Configuracao.pas' {FrameConfig: TFrame},
  SmartPro99.View.TabelaDePreco in 'View\SmartPro99.View.TabelaDePreco.pas' {VeiwTabelaDePreco: TFrame},
  SmartPro99.View.Frames.Produto in 'View\Frames\SmartPro99.View.Frames.Produto.pas' {FrameFPreco: TFrame},
  SmartPro99.Classe.Loading in 'Classe\SmartPro99.Classe.Loading.pas',
  SmartPro99.View.Message in 'View\SmartPro99.View.Message.pas' {FrameMensagemInfor: TFrame},
  SmartPro99.View.Logs in 'View\SmartPro99.View.Logs.pas' {FrameLogs: TFrame},
  SmartPro99.View.TextEdit in 'View\SmartPro99.View.TextEdit.pas' {FrameEdit: TFrame},
  SmarPro99.Model.Conexao in 'Model\SmarPro99.Model.Conexao.pas' {ModelConexao: TDataModule},
  SmartPro99.View.ConfiguracaoDoLayout in 'View\SmartPro99.View.ConfiguracaoDoLayout.pas' {FrameConfLayout: TFrame},
  SmartPro99.View.Frames.Oferta in 'View\Frames\SmartPro99.View.Frames.Oferta.pas' {FrameOferta: TFrame},
  SmartPro99.Classe.Resolucao in 'Classe\SmartPro99.Classe.Resolucao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
