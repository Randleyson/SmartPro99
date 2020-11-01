program SamrtPro99;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrm_Principal in 'Units\ufrm_Principal.pas' {frmPrincipal},
  uframe_Config in 'Units\uframe_Config.pas' {FrameConfiguracao: TFrame},
  uframe_Home in 'Units\uframe_Home.pas' {FrameHome: TFrame},
  udm_Conexao in 'DataModule\udm_Conexao.pas' {DmConexao: TDataModule},
  udm_Principal in 'DataModule\udm_Principal.pas' {DmPrincipal: TDataModule},
  uframe_CadTvs in 'Units\uframe_CadTvs.pas' {FrameCadTv: TFrame},
  uframe_CadProduto in 'Units\uframe_CadProduto.pas' {FrameCadProduto: TFrame},
  uframe_FListarProduto in 'Units\uframe_FListarProduto.pas' {FrameFListarProduto: TFrame},
  Loading in 'Units\Loading.pas',
  udm_CadTv in 'DataModule\udm_CadTv.pas' {dmCadTv: TDataModule},
  udm_CadProduto in 'DataModule\udm_CadProduto.pas' {dmCadProduto: TDataModule},
  Frm_MessageDlg in 'Units\Frm_MessageDlg.pas' {frmMessageDlg},
  Frm_MessagePopUp in 'Units\Frm_MessagePopUp.pas' {FrmMessagePopUp},
  u_Message in 'Units\u_Message.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmMessageDlg, frmMessageDlg);
  Application.CreateForm(TFrmMessagePopUp, FrmMessagePopUp);
  Application.Run;
end.
