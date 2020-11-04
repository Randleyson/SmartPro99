unit SmartPro99.View.Configuracao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.Edit,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMX.Effects, FMX.Filter.Effects;

type
  TViewConfiguracao = class(TFrame)
    Rectangle1: TRectangle;
    lytTitulo: TLayout;
    Label1: TLabel;
    btnFechar: TSpeedButton;
    lytPrincipal: TLayout;
    lytRodaPe: TLayout;
    gboxTipoArquivo: TGroupBox;
    rdTipoTxtItens: TRadioButton;
    edtArquivoTxt: TEdit;
    Layout3: TLayout;
    imgPastaInexistente: TImage;
    btnSair: TCornerButton;
    btnSalvar: TCornerButton;
    RadioButton2: TRadioButton;
    gboxLocalArquivo: TGroupBox;
    Line1: TLine;
    Rectangle2: TRectangle;
    FillRGBEffect1: TFillRGBEffect;
    lytConversaoDados: TLayout;
    Label2: TLabel;
    Line2: TLine;
    Rectangle3: TRectangle;
    btnBuscarPasta: TCornerButton;
    Layout1: TLayout;
    procedure btnFecharClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure edtArquivoTxtKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure btnBuscarPastaClick(Sender: TObject);
  private
    { Private declarations }
    fTipoArquivo: Integer;
    fCaminhoArquivo: String;

    procedure CarregaParamentros;
    procedure SalvarAltercao;
    procedure RefreshConfiguracao;
    function ValidaCaminho(pCaminho: String): Boolean;
    function TipoArquivoSelcionado: Integer;
  public
    { Public declarations }
    procedure CreateFrameConfig;
    procedure FechaFrameConfig;
  end;

var
  ViewConfiguracao:TViewConfiguracao;
implementation

uses
  SmartPro99.Controlle.Message, SmartPro99.Model.Principal,
  SmartPro99.View.Principal, SmartPro99.Model.Conexao;

{$R *.fmx}


{ TFrameConfiguracao }

procedure TViewConfiguracao.FechaFrameConfig;
begin

  try

    ViewConfiguracao.Visible := False;
    ViewConfiguracao         := nil;

  except
  on e: Exception do
    begin
      TMessage.MessagemPopUp(ViewPrincipal,'Erro : '+ ViewPrincipal.fMensagemErro + e.Message);
    end;

  end;

end;

procedure TViewConfiguracao.RefreshConfiguracao;
begin

  try

    CarregaParamentros;

    {Tipo de Arquivo}
    case fTipoArquivo of
      1: rdTipoTxtItens.IsChecked := True;
    end;

    {Caminho do arquivo de integração}
    edtArquivoTxt.Text          := fCaminhoArquivo;
    imgPastaInexistente.Visible := not ValidaCaminho(edtArquivoTxt.Text);

  except
    raise

  end;

end;

procedure TViewConfiguracao.SalvarAltercao;
begin

  try
  
    ModelPrincipal.GravarConfiguracao(IntToStr(TipoArquivoSelcionado),edtArquivoTxt.Text);
    TMessage.MessagemPopUp(ViewPrincipal,'Configuração salva com exito');
    FechaFrameConfig;

  except
    raise
  end;

end;

procedure TViewConfiguracao.CreateFrameConfig;
begin

  try

    if not assigned(ViewConfiguracao) then
    ViewConfiguracao := TViewConfiguracao.Create(self);

    with ViewConfiguracao do
    begin

      Name      := 'FrameConfiguracao';
      Parent    := ViewPrincipal;

      RefreshConfiguracao;
      BringToFront;
    end;

  except
  on e: exception do
    begin

      FechaFrameConfig;
      TMessage.MessagemPopUp(ViewPrincipal,'Erro : '+ ViewPrincipal.fMensagemErro +
        e.Message);
    end;

  end;

end;

function TViewConfiguracao.TipoArquivoSelcionado: integer;
begin

  if rdTipoTxtItens.IsChecked then
  Result := 1;

end;

function TViewConfiguracao.ValidaCaminho(pCaminho: String): Boolean;
begin

  Result := False;
  if FileExists(pCaminho)then
  Result := True;
      
end;

procedure TViewConfiguracao.btnBuscarPastaClick(Sender: TObject);
begin

  try

    if not (ViewPrincipal.OpenDialogDir = '') then
    edtArquivoTxt.Text          := ViewPrincipal.OpenDialogDir;
    imgPastaInexistente.Visible := not ValidaCaminho(edtArquivoTxt.Text);


  except
  on e: exception do
    begin
      TMessage.MessagemPopUp(ViewPrincipal,'Erro : '+ ViewPrincipal.fMensagemErro + e.Message);
    end;

  end;

end;

procedure TViewConfiguracao.btnFecharClick(Sender: TObject);
begin

   FechaFrameConfig;

end;

procedure TViewConfiguracao.btnSairClick(Sender: TObject);
begin

  try
  
    FechaFrameConfig;
    
  except
  on e: Exception do
    begin 
      TMessage.MessagemPopUp(ViewPrincipal,'Erro : '+ ViewPrincipal.fMensagemErro + e.Message);
    end;

  end;

end;

procedure TViewConfiguracao.btnSalvarClick(Sender: TObject);
begin

  try

    if imgPastaInexistente.Visible then
    begin
      TMessage.MessagemPopUp(ViewPrincipal,'Caminho do arquivo de integração não e valido');
      exit
    end;

    SalvarAltercao;

  except
    on e: exception do
    begin
      TMessage.MessagemPopUp(ViewPrincipal,'Erro : '+ ViewPrincipal.fMensagemErro + e.Message);
    end;

  end;

end;

procedure TViewConfiguracao.CarregaParamentros;
begin

  try

    try

      ModelConexao.AbreConexaoDb;

      ModelPrincipal.FQryConfig.Close;
      ModelPrincipal.FQryConfig.Open;

      if ModelPrincipal.FQryConfig.RecordCount = 0 then
      ModelPrincipal.InseriPrimeiroConfig;

      fTipoArquivo := ModelPrincipal.FQryConfig.FieldByName('TIPOARQUIVOTXT').AsInteger;
      fCaminhoArquivo := ModelPrincipal.FQryConfig.FieldByName('LOCALARQUIVOTXT').AsString;

    except
      raise

    end;

  finally
    ModelConexao.AbreConexaoDb;

  end;

end;

procedure TViewConfiguracao.edtArquivoTxtKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin

   imgPastaInexistente.Visible := not ValidaCaminho(edtArquivoTxt.Text);
   
end;

end.
