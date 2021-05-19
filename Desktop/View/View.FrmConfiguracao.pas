unit View.FrmConfiguracao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Edit,
  FMX.Layouts, Controller.oConfiguracao, View.Frame.PaletaCores,
  View.Frame.Cabecalho, FMX.Effects, FMX.Filter.Effects;

type
  TViewFrmConfiguracao = class(TForm)
    ToolBarBotao: TToolBar;
    EdtLocalArquivo: TEdit;
    BtnAlter: TRectangle;
    BtnGravar: TRectangle;
    BtnCancelar: TRectangle;
    GboxPadraoArquivo: TGroupBox;
    RadioArquivoToleto: TRadioButton;
    RadioArquivoFilizola: TRadioButton;
    RadioOutros: TRadioButton;
    GBoxLocalArquivo: TGroupBox;
    Layout1: TLayout;
    Layout2: TLayout;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Layout3: TLayout;
    FrameCabecalho1: TFrameCabecalho;
    Layout4: TLayout;
    FramePaletaCores1: TFramePaletaCores;
    imgPasta: TImage;
    FillRGBEffect1: TFillRGBEffect;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnAlterClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure imgPastaClick(Sender: TObject);
  private
    { Private declarations }
    procedure Alterar;
    procedure BloqueiaBotao(pBtnAlterar, pBtnGrava, pBtnCancelar: Boolean);
    procedure CloseViewConfiguracao;
    procedure Cancelar;
    procedure EnabledCampo(pParams: Boolean);
    procedure InicializaFrmConfiguracao;
    procedure Gravar;
    procedure PesquisarLocalArquivo;
    procedure PadraoDoArquivoToRadio(pPadraoDoArquivo: String);
    procedure RecharConfiguracao;
    function  RadioToPadraoDoArquivo: String;
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses Controller.uFarctory,
     StrUtils,
     Controller.uConfiguracao;

procedure TViewFrmConfiguracao.Alterar;
begin
  BloqueiaBotao(False, True, True);
  EnabledCampo(True);
end;

procedure TViewFrmConfiguracao.BloqueiaBotao(pBtnAlterar, pBtnGrava,
  pBtnCancelar: Boolean);
begin
  BtnAlter.Enabled := pBtnAlterar;
  BtnGravar.Enabled := pBtnGrava;
  BtnCancelar.Enabled := pBtnCancelar;
end;

procedure TViewFrmConfiguracao.BtnAlterClick(Sender: TObject);
begin
  Alterar;
end;


procedure TViewFrmConfiguracao.BtnCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TViewFrmConfiguracao.BtnGravarClick(Sender: TObject);
begin
  Gravar;
end;

procedure TViewFrmConfiguracao.Button1Click(Sender: TObject);
begin
  CloseViewConfiguracao;

end;

procedure TViewFrmConfiguracao.Cancelar;
begin
  BloqueiaBotao(True, False, False);
  EnabledCampo(False);
  RecharConfiguracao;

end;

procedure TViewFrmConfiguracao.CloseViewConfiguracao;
begin
  FreeAndNil(oConfiguracao);
  uFarctory.ConfiguracaoDestroyView;

end;

procedure TViewFrmConfiguracao.EnabledCampo(pParams: Boolean);
begin
  RadioArquivoToleto.Enabled := pParams;
  RadioArquivoFilizola.Enabled := pParams;
  RadioOutros.Enabled := pParams;
  EdtLocalArquivo.Enabled := pParams;
  imgPasta.Enabled := pParams;
end;

procedure TViewFrmConfiguracao.FormShow(Sender: TObject);
begin
  InicializaFrmConfiguracao;

end;

procedure TViewFrmConfiguracao.Gravar;
begin

  oConfiguracao.NewPadraoArquivo := RadioToPadraoDoArquivo;
  oConfiguracao.NewLocalArquivo := EdtLocalArquivo.Text;

  try
    if not FileExists(EdtLocalArquivo.Text) then
    begin
      ShowMessage('Arquivo Não Localizado.');
      exit;
    end;

    if TuConfiguracao.New.GravaAlteracaoDb(oConfiguracao) then
      ShowMessage('Configurção salva com exito');

  except
    on E: Exception do
    begin
      ShowMessage('Erro: ' + E.Message);
      exit;

    end;

  end;

  BloqueiaBotao(True, False, False);
  EnabledCampo(False);

end;

procedure TViewFrmConfiguracao.imgPastaClick(Sender: TObject);
begin
  PesquisarLocalArquivo;
end;

procedure TViewFrmConfiguracao.InicializaFrmConfiguracao;
begin

  try
    oConfiguracao := ToConfiguracao.Create;
    RecharConfiguracao;
    FrameCabecalho1.LblNomeDaTela.Text := 'Configurações';
    FramePaletaCores1.Visible := False;
    EnabledCampo(False);
    BloqueiaBotao(True, False, False);
  except
    on E: Exception do ShowMessage('Erro: ' + E.Message);
  end;

end;

procedure TViewFrmConfiguracao.PadraoDoArquivoToRadio(pPadraoDoArquivo: String);
begin

  case AnsiIndexStr(UpperCase(pPadraoDoArquivo), ['T', 'F', 'O']) of
    0:
      RadioArquivoToleto.IsChecked := True;
    1:
      RadioArquivoFilizola.IsChecked := True;
    3:
      RadioOutros.IsChecked := True;

  end;

end;

procedure TViewFrmConfiguracao.PesquisarLocalArquivo;
begin
  EdtLocalArquivo.Text := TuConfiguracao.New.OpenDialogDir;

end;

function TViewFrmConfiguracao.RadioToPadraoDoArquivo: String;
begin

  if RadioArquivoToleto.IsChecked then
    Result := 'T';
  if RadioArquivoFilizola.IsChecked then
    Result := 'F';
  if RadioOutros.IsChecked then
    Result := 'O';

end;

procedure TViewFrmConfiguracao.RecharConfiguracao;
begin

  oConfiguracao.CarregaConfiguracaoDb;
  PadraoDoArquivoToRadio(oConfiguracao.PadraoArquivo);
  EdtLocalArquivo.Text := oConfiguracao.LocalArquivo;

end;

end.
