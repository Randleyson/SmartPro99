program GerenciadorPro99;

uses
  Vcl.Forms,
  ufrm_Principal in 'Units\ufrm_Principal.pas' {FrmPrincipal},
  uFrm_login in 'Units\uFrm_login.pas' {FrmLogin},
  Dm_Principal in 'DataModule\Dm_Principal.pas' {DmPrincipal: TDataModule},
  ufrm_Configuracao in 'Units\ufrm_Configuracao.pas' {FrmConfiguracao},
  Dm_Produtos in 'DataModule\Dm_Produtos.pas' {dmProduto: TDataModule},
  Dm_Configuracao in 'DataModule\Dm_Configuracao.pas' {dmConfiguracao: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmConfiguracao, FrmConfiguracao);
  Application.CreateForm(TdmProduto, dmProduto);
  Application.CreateForm(TdmConfiguracao, dmConfiguracao);
  Application.Run;
end.
