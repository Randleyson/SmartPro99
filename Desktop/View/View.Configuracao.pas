unit View.Configuracao;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  View.Frame.Cabecalho,
  FMX.Objects,
  FMX.Effects,
  FMX.Filter.Effects,
  FMX.Edit,
  FMX.Controls.Presentation,
  FMX.Layouts, uConfiguracao;



type
  TFrameConfiguracao = class(TFrame)
    Layout4: TLayout;
    GboxPadraoArquivo: TGroupBox;
    Layout2: TLayout;
    RadioArquivoFilizola: TRadioButton;
    RadioArquivoToleto: TRadioButton;
    RadioOutros: TRadioButton;
    GBoxLocalArquivo: TGroupBox;
    Layout1: TLayout;
    EdtLocalArquivo: TEdit;
    imgPasta: TImage;
    FillRGBEffect1: TFillRGBEffect;
    Layout3: TLayout;
    BtnAlter: TRectangle;
    Label1: TLabel;
    BtnCancelar: TRectangle;
    Label2: TLabel;
    BtnGravar: TRectangle;
    Label3: TLabel;
    Rectangle1: TRectangle;
    FrameCabecalho1: TFrameCabecalho;
    procedure FrameCabecalho1Image1Click(Sender: TObject);
    procedure imgPastaClick(Sender: TObject);
    procedure BtnAlterClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
  private
    Configuracao: TConfiguracao;
    function OpenDialogDir: String;
    procedure EnabledBtn(pBtnAlterar, pBtnGrava, pBtnCancelar: Boolean);
    procedure EnabledCampo(pParams: Boolean);
    procedure CarregaConfiguracaoNaTela;
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CloseConfiguracao;
  end;
var
  FrameConfiguracao: TFrameConfiguracao;

implementation

{$R *.fmx}
uses
  Vcl.Dialogs,
  uDm,
  System.StrUtils;

procedure TFrameConfiguracao.BtnAlterClick(Sender: TObject);
begin
  EnabledBtn(False, True, True);
  EnabledCampo(True);
end;

procedure TFrameConfiguracao.BtnCancelarClick(Sender: TObject);
begin
  EnabledBtn(True, False, False);
  EnabledCampo(False);
  CarregaConfiguracaoNaTela;
end;

procedure TFrameConfiguracao.CarregaConfiguracaoNaTela;
begin

  Dm.LerConfiguracao(Configuracao);

  case Configuracao.TipoIntegracao of
  tsToledo:
    RadioArquivoToleto.IsChecked   := True;
  tsFilizola:
    RadioArquivoFilizola.IsChecked := True;
  tsOutros:
    RadioOutros.IsChecked          := True;
  end;

  EdtLocalArquivo.Text := Configuracao.LocalArquivo;
  EnabledCampo(False);
  EnabledBtn(True, False, False);
end;

procedure TFrameConfiguracao.CloseConfiguracao;
begin
  if Assigned(FrameConfiguracao) then
  begin
    FrameConfiguracao.Visible := False;
    FrameConfiguracao.DisposeOf;
    FrameConfiguracao := Nil;
  end;
end;

constructor TFrameConfiguracao.Create(AOwner: TComponent);
begin
  inherited;
  Configuracao := TConfiguracao.New;

  FrameCabecalho1.LblNomeDaTela.Text := 'Configura��es';
  CarregaConfiguracaoNaTela;
end;

destructor TFrameConfiguracao.Destroy;
begin
  Configuracao.DisposeOf;
  inherited;
end;

procedure TFrameConfiguracao.BtnGravarClick(Sender: TObject);
begin
  Configuracao.LocalArquivo := EdtLocalArquivo.Text;

  if RadioArquivoToleto.IsChecked then
    Configuracao.TipoIntegracao(tsToledo);
  if RadioArquivoFilizola.IsChecked then
    Configuracao.TipoIntegracao(tsFilizola);
  if RadioOutros.IsChecked then
    Configuracao.TipoIntegracao(tsOutros);

  Dm.GravarConfiguracao(Configuracao);
  EnabledBtn(True, False, False);
  EnabledCampo(False);

end;

procedure TFrameConfiguracao.EnabledBtn(pBtnAlterar, pBtnGrava,
  pBtnCancelar: Boolean);
begin
  BtnAlter.Enabled := pBtnAlterar;
  BtnGravar.Enabled := pBtnGrava;
  BtnCancelar.Enabled := pBtnCancelar;
end;

procedure TFrameConfiguracao.EnabledCampo(pParams: Boolean);
begin
  RadioArquivoToleto.Enabled := pParams;
  RadioArquivoFilizola.Enabled := pParams;
  RadioOutros.Enabled := pParams;
  EdtLocalArquivo.Enabled := pParams;
  imgPasta.Enabled := pParams;
end;


procedure TFrameConfiguracao.FrameCabecalho1Image1Click(Sender: TObject);
begin
  CloseConfiguracao;
end;

procedure TFrameConfiguracao.imgPastaClick(Sender: TObject);
begin
  EdtLocalArquivo.Text := OpenDialogDir;
end;

function TFrameConfiguracao.OpenDialogDir: String;
begin
 with TOpenDialog.Create(nil) do
    try

      InitialDir := 'C:';
      Options := [ofFileMustExist];
      Filter := '*.txt';
      if Execute then
        Result := FileName;
    finally
      Free;
    end;
end;

end.
