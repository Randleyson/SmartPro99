unit uframe_Config;

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
  TFrameConfiguracao = class(TFrame)
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
    procedure ShowFrameConfig;
    procedure FechaFrameConfig;
  end;

var
  FrameConfiguracao:TFrameConfiguracao;
implementation

{$R *.fmx}

uses ufrm_Principal, udm_Conexao, udm_Principal;

{ TFrameConfiguracao }

procedure TFrameConfiguracao.FechaFrameConfig;
begin

  FrameConfiguracao.Visible := False;
  FrameConfiguracao := nil;
end;

procedure TFrameConfiguracao.RefreshConfiguracao;
begin

  CarregaParamentros;

  {Tipo de Arquivo}
  case fTipoArquivo of
    1: rdTipoTxtItens.IsChecked := True;
  end;

  edtArquivoTxt.Text := fCaminhoArquivo;
  imgPastaInexistente.Visible := not ValidaCaminho(edtArquivoTxt.Text);

end;

procedure TFrameConfiguracao.SalvarAltercao;
begin

  if imgPastaInexistente.Visible then
  begin
   ShowMessage('Caminho do arquivo txt esta invalido');
   exit
  end;

  DmPrincipal.GravarConfiguracao(IntToStr(TipoArquivoSelcionado),edtArquivoTxt.Text);

end;

procedure TFrameConfiguracao.ShowFrameConfig;
begin
  try

    if not assigned(FrameConfiguracao) then
    FrameConfiguracao := TFrameConfiguracao.Create(self);

    with FrameConfiguracao do
    begin

      Name      := 'FrameConfiguracao';
      Parent    := frmPrincipal;

      RefreshConfiguracao;
      BringToFront;
    end;

  except
    FechaFrameConfig;
    ShowMessage('Erro : '+ frmPrincipal.fMensagemErro);

  end;

end;

function TFrameConfiguracao.TipoArquivoSelcionado: integer;
begin

  if rdTipoTxtItens.IsChecked then
  Result := 1;

end;

function TFrameConfiguracao.ValidaCaminho(pCaminho: String): Boolean;
begin

  Result := False;
  
  if DirectoryExists(pCaminho)then 
  Result := True;
      
end;

procedure TFrameConfiguracao.btnBuscarPastaClick(Sender: TObject);
begin

    if not (frmPrincipal.OpenDialogDir = '') then
    edtArquivoTxt.Text := frmPrincipal.OpenDialogDir;

end;

procedure TFrameConfiguracao.btnFecharClick(Sender: TObject);
begin

   FechaFrameConfig;

end;

procedure TFrameConfiguracao.btnSairClick(Sender: TObject);
begin

  FechaFrameConfig;

end;

procedure TFrameConfiguracao.btnSalvarClick(Sender: TObject);
begin

  try

    SalvarAltercao;
    FechaFrameConfig;

  except
    ShowMessage('Erro : '+ frmPrincipal.fMensagemErro);

  end;

end;

procedure TFrameConfiguracao.CarregaParamentros;
begin

  try

    try

      DmConexao.AbreConexaoDb;

      DmPrincipal.FQryConfig.Active := False;
      DmPrincipal.FQryConfig.Active := True;

      if DmPrincipal.FQryConfig.RecordCount = 0 then
      DmPrincipal.InseriPrimeiroConfig;

      fTipoArquivo := DmPrincipal.FQryConfig.FieldByName('TIPOARQUIVOTXT').AsInteger;
      fCaminhoArquivo := DmPrincipal.FQryConfig.FieldByName('LOCALARQUIVOTXT').AsString;

    except
      raise

    end;

  finally
    DmConexao.AbreConexaoDb;

  end;

end;

procedure TFrameConfiguracao.edtArquivoTxtKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin

   imgPastaInexistente.Visible := not ValidaCaminho(edtArquivoTxt.Text);
   
end;

end.
