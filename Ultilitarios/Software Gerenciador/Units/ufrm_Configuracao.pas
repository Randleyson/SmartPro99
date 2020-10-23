unit ufrm_Configuracao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls;

type
  TFrmConfiguracao = class(TForm)
    lblTituloDaTela: TLabel;
    Label2: TLabel;
    edtCaminhoTxt: TEdit;
    btnSalvar: TButton;
    btnSair: TButton;
    FDQConfiguracao: TFDQuery;
    pnPrincipal: TPanel;
    gboxDadosConversao: TGroupBox;
    pnBotao: TPanel;
    pnDadoTxt: TPanel;
    gRadioTipoDados: TRadioGroup;
    Panel1: TPanel;
    btnPastaTxt: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnPastaTxtClick(Sender: TObject);
  private
    procedure SalvaConfiguracao;
    procedure CarregaParamentros;
    procedure LimpaParamentros;
    { Private declarations }

  public
    { Public declarations }
  end;

var
  FrmConfiguracao: TFrmConfiguracao;

implementation

{$R *.dfm}

uses Dm_Principal, ufrm_Principal, Dm_Configuracao;

procedure TFrmConfiguracao.SalvaConfiguracao;
begin

  dmConfiguracao.PostArquivoTxt(edtCaminhoTxt.Text);


end;

procedure TFrmConfiguracao.btnSalvarClick(Sender: TObject);
begin

  try
    SalvaConfiguracao;
  except
    ShowMessage(FrmPrincipal.fMensagemErro);
   end;

end;

procedure TFrmConfiguracao.btnPastaTxtClick(Sender: TObject);
begin

  edtCaminhoTxt.Text := FrmPrincipal.DialogDir;

end;

procedure TFrmConfiguracao.btnSairClick(Sender: TObject);
begin

  FrmConfiguracao.Close;
  FreeAndNil(FrmConfiguracao);

end;

procedure TFrmConfiguracao.CarregaParamentros;
begin

  with FDQConfiguracao do
  begin
    Active := False;
    Active := True;

    edtCaminhoTxt.Text := FieldByName('caminhoarquivotxt').AsString;
    Active := False;
  end;
end;

procedure TFrmConfiguracao.LimpaParamentros;
begin

  edtCaminhoTxt.Text := '';

end;

procedure TFrmConfiguracao.FormShow(Sender: TObject);
begin

  LimpaParamentros;
  CarregaParamentros;

end;













end.
