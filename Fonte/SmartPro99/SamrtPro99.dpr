program SamrtPro99;

uses
  System.StartUpCopy,
  FMX.Forms,
  SmartPro99.View.Principal in 'View\SmartPro99.View.Principal.pas' {ViewPrincipal},
  SmartPro99.View.Configuracao in 'View\SmartPro99.View.Configuracao.pas' {ViewConfiguracao: TFrame},
  SmartPro99.View.Home in 'View\SmartPro99.View.Home.pas' {ViewHome: TFrame},
  SmartPro99.Model.Conexao in 'Model\SmartPro99.Model.Conexao.pas' {ModelConexao: TDataModule},
  SmartPro99.Model.Principal in 'Model\SmartPro99.Model.Principal.pas' {ModelPrincipal: TDataModule},
  SmartPro99.View.CadTv in 'View\SmartPro99.View.CadTv.pas' {ViewCadTvs: TFrame},
  SmartPro99.View.CadProduto in 'View\SmartPro99.View.CadProduto.pas' {ViewCadProdutos: TFrame},
  SmartPro99.Controlle.Loading in 'Controlle\SmartPro99.Controlle.Loading.pas',
  SmartPro99.Model.Tvs in 'Model\SmartPro99.Model.Tvs.pas' {ModelTvs: TDataModule},
  SmartPro99.Model.Produto in 'Model\SmartPro99.Model.Produto.pas' {ModelProduto: TDataModule},
  SmartPro99.View.MessageDlg in 'View\SmartPro99.View.MessageDlg.pas' {ViewMessageDlg},
  SmartPro99.View.MessagePopUp in 'View\SmartPro99.View.MessagePopUp.pas' {ViewMessagePopUp},
  SmartPro99.Controlle.Message in 'Controlle\SmartPro99.Controlle.Message.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TViewPrincipal, ViewPrincipal);
  Application.CreateForm(TViewMessageDlg, ViewMessageDlg);
  Application.CreateForm(TViewMessagePopUp, ViewMessagePopUp);
  Application.Run;
end.
