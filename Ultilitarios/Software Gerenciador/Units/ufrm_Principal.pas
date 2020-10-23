unit ufrm_Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids;

type
  TFrmPrincipal = class(TForm)
    lblTituloDaTela: TLabel;
    ToolBar: TPanel;
    Button1: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    DS_ListaProduto: TDataSource;
    pnPrincipal: TPanel;
    Button3: TButton;
    Panel1: TPanel;
    lblVerificandoArqui: TLabel;
    tmCarregaArquivo: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure AbreFrmLogin;
    procedure DescaregaArquivoTxtNoBD;
    procedure ListaProdutoNaGrid;
    { Private declarations }
  public
    { Public declarations }
    fMensagemErro: string;
    function DialogDir: String;
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses uFrm_login, Dm_Principal, ufrm_Configuracao, Dm_Produtos;

procedure TFrmPrincipal.Button1Click(Sender: TObject);
begin

  FrmConfiguracao := TFrmConfiguracao.Create(self);
  FrmConfiguracao.Show;

end;


procedure TFrmPrincipal.ListaProdutoNaGrid;
begin

  dmProduto.FDQProdutos.Active := False;
  dmProduto.FDQProdutos.Active := True;

end;

procedure TFrmPrincipal.Button2Click(Sender: TObject);

begin

  DescaregaArquivoTxtNoBD;
  ListaProdutoNaGrid;


end;

procedure TFrmPrincipal.AbreFrmLogin;
begin

   try
    DmPrincipal := TDmPrincipal.Create(self);

    FrmLogin := TFrmLogin.Create(self);
    FrmLogin.ShowModal;

  except on E:Exception do
    begin
      ShowMessage('Erro: ' + E.Message);
      Application.Terminate;
    end;
  end;

end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  ShowMessage(ExtractFileDir(Application.ExeName));
  AbreFrmLogin;

end;

procedure TFrmPrincipal.DescaregaArquivoTxtNoBD;
var
  vArquivo : TextFile;
  vlinha,vCod,vDescri,vVrVenda : string;
begin

  FrmConfiguracao.FDQConfiguracao.Active := False;
  FrmConfiguracao.FDQConfiguracao.Active := True;

  AssignFile(vArquivo, FrmConfiguracao.FDQConfiguracao.FieldByName('caminhoarquivotxt').AsString);
  reset(vArquivo);

  dmProduto.DeleteFromProduto;

  while (not eof(vArquivo)) do
  begin
    Readln(vArquivo,vlinha);
    vCod     := copy(vLinha,0,pos('/',vlinha)-1);
    vDescri  := Copy( vLinha, pos('/',vlinha) + 1, pos('/', Copy( vLinha, pos('/',vlinha)+1,
                      Length(vlinha)))-1);
    vVrVenda := Copy( Copy(vlinha, pos('/',vlinha)+1,Length(vlinha)),pos('/',Copy( vlinha,
                      pos('/',vlinha)+1,Length(vlinha)))+1,Length(vlinha));

    dmProduto.InsertProduto(vCod,vDescri,vVrVenda);
  end;

  CloseFile(vArquivo);

end;

function TFrmPrincipal.DialogDir: String;
begin

  with TFileOpenDialog.Create(nil) do
  try
    Options := [fdoPickFolders];
    if Execute then
      Result := FileName;
  finally
    Free;
  end;

end;

end.
