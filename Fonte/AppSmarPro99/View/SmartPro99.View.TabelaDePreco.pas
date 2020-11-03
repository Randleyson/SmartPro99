unit SmartPro99.View.TabelaDePreco;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.ListBox, FMX.Objects, System.ImageList,
  FMX.ImgList, FMX.Controls.Presentation;

type
  TVeiwTabelaDePreco = class(TFrame)
    Rectangle1: TRectangle;
    lstBoxTabelaPreco: TListBox;
    lytRodaPe: TLayout;
    imgConfiguracao: TImage;
    lstImgConexao: TImageList;
    imgConexao: TGlyph;
    tmProxPagina: TTimer;
    imgLogs: TImage;
    tmAtualizaProdutos: TTimer;
    Image1: TImage;
    Image2: TImage;
    lytOferta: TLayout;
    Label1: TLabel;
    procedure imgConfiguracaoClick(Sender: TObject);
    procedure tmProxPaginaTimer(Sender: TObject);
    procedure imgLogsClick(Sender: TObject);
    procedure tmAtualizaProdutosTimer(Sender: TObject);

  private
    { Private declarations }
    fNroPag: integer;
    fUltimoRegistro: integer;
    procedure IniciarFrame;
    procedure FechaFrameTabelaPreco;
    procedure AddFrameListBox(pDescricao,pValorVenda: string);
    procedure StatusConexao(pIndex: integer);
    procedure ProximaPag;
    procedure IconeConexao;
    procedure AjustaResolucao;

  public
    { Public declarations }
    procedure ListarProduto;
    procedure CreateFrameTabelaPreco;

  end;

var
  VeiwTabelaDePreco: TVeiwTabelaDePreco;


implementation

uses
  SmartPro99.View.Frames.Produto, SmartPro99.Classe.Resolucao,
  SmartPro99.View.FrmPrincipal, SmartPro99.View.Message,
  SmartPro99.Classe.Loading, SmarPro99.Model.Dados,
  SmartPro99.View.Configuracao, SmartPro99.View.Logs,
  SmartPro99.View.Frames.Oferta;

{$R *.fmx}


{ TFrameTabelaPreco }

procedure TVeiwTabelaDePreco.AddFrameListBox(pDescricao, pValorVenda: string);
var
  vFrame : TFrameFPreco;
  vItem : TListBoxItem;

begin

  try

    vItem                             := TListBoxItem.Create(lstBoxTabelaPreco);
    vItem.Text                        := '';
    vItem.Selectable                  := False;
    vItem.Height                      := 50;

    vFrame                            := TFrameFPreco.Create(vItem);
    vFrame.Parent                     := vItem;
    vFrame.Align                      := TAlignLayout.Client;
    vFrame.lblDescricaoProd.text      := pDescricao;
    vFrame.lblDescricaoProd.Font.Size := TResolucao.fSizeFonteGrid;
    vFrame.lblValorVenda.text         := formatfloat('R$ ##,###,##0.00',StrToFloat(pValorVenda));
    vFrame.lblValorVenda.Font.Size    := TResolucao.fSizeFonteGrid;
    vFrame.Margins.Bottom             := 8;

    lstBoxTabelaPreco.AddObject(vItem);

  except
    FrmPrincipal.fMensagemErro := 'Não foi possivel adicionar o frame no lisBox';

  end;

end;

procedure TVeiwTabelaDePreco.FechaFrameTabelaPreco;
begin

  VeiwTabelaDePreco.Visible := False;
  VeiwTabelaDePreco := nil;

end;

procedure TVeiwTabelaDePreco.StatusConexao(pIndex: integer);
begin

  imgConexao.ImageIndex := pIndex;

end;

procedure TVeiwTabelaDePreco.tmAtualizaProdutosTimer(Sender: TObject);
begin

  try

    FrmPrincipal.RecebeAtualizaWs;

  except
    raise

  end;
end;

procedure TVeiwTabelaDePreco.tmProxPaginaTimer(Sender: TObject);
begin

  try
    ProximaPag;
  except
    on e: exception do
    begin
      FrameMsgInfor.CreateFrameMsgInfor(e.message);
    end;
  end;

end;

procedure TVeiwTabelaDePreco.imgConfiguracaoClick(Sender: TObject);
begin

  TLoading.Show(frmPrincipal,'Aguarde... Conectando ao servidor');

  TThread.CreateAnonymousThread(procedure
  begin
    try

      try

        tmProxPagina.Enabled       := False;
        tmAtualizaProdutos.Enabled := False;

        ModelDados.CarregaParamentros;
        if ModelDados.TestaConexaoWS then
        ModelDados.RecebeTvsWs;

        FrameConfig.CreateFrameConfig;

      except
        raise

      end;

    finally

      TThread.Synchronize(nil,procedure
      begin
        TLoading.Hide;
      end);
    end;

  end).Start;

end;

procedure TVeiwTabelaDePreco.imgLogsClick(Sender: TObject);
begin

  try

    FrameLogs.VisualizaLogs;

  except
    raise

  end;

end;

procedure TVeiwTabelaDePreco.IconeConexao;
begin

  imgConexao.ImageIndex := FrmPrincipal.fStatusConexaoWs;

end;

procedure TVeiwTabelaDePreco.IniciarFrame;
begin

    try

      ModelDados.CarregaParamentros;

      if FrmPrincipal.fIdTvAtual = '0' then
      exit;

      ModelDados.QryToFMent(ModelDados.FQryProdutos,
                             ModelDados.FMentProd);

      lstBoxTabelaPreco.Clear;

      if ModelDados.FMentProd.RecordCount <> 0 then
      begin
        ModelDados.FMentProd.First;
        ListarProduto;
      end;

      FrameOferta.CreateFrameOferta;
      tmProxPagina.Enabled              := True;
      tmAtualizaProdutos.Enabled        := True;
      AjustaResolucao;

    except
      raise;

    end;

end;


procedure TVeiwTabelaDePreco.ListarProduto;
var
  vI: integer;
begin

  try

    vI := 0;
    IconeConexao;

    if ModelDados.FMentProd.Eof then
    ModelDados.FMentProd.First;

    while not ModelDados.FMentProd.Eof do
    begin

      if vI < TResolucao.fQtdeProdGrid then
      begin

        AddFrameListBox(ModelDados.FMentProd.FieldByName('Descricao').AsString,
                        ModelDados.FMentProd.FieldByName('vrvenda').AsString);
        ModelDados.FMentProd.Next;
        fUltimoRegistro := ModelDados.FMentProd.RecNo;
        vI := vI + 1;

      end
      else
      exit

    end;

  except
    FrameLogs.AddLogs('Não foi possivel Listar os produto no listBox');
    raise

  end;

end;

procedure TVeiwTabelaDePreco.ProximaPag;
begin

  try

    lstBoxTabelaPreco.Clear;

    if FrmPrincipal.fNovaCarga then
    begin
      ModelDados.QryToFMent(ModelDados.FQryProdutos,ModelDados.FMentProd);
      ModelDados.FMentProd.RecNo := fUltimoRegistro;
      FrmPrincipal.fNovaCarga := False;
    end;
    ListarProduto;

  except
    on e: exception do
    begin
      FrameMsgInfor.CreateFrameMsgInfor('Erro ProximaPag:'+ e.Message);
    end;

  end;

end;

procedure TVeiwTabelaDePreco.AjustaResolucao;
begin

  try

    {GRID TABELA DE PRECO}
    lstBoxTabelaPreco.Width           := TResolucao.fLargGrid;
    lstBoxTabelaPreco.Margins.Top     := TResolucao.fMarTopGrid;

    {LAYOUT OFERTA}
    lytOferta.Width                   := TResolucao.fLargLytOferta;
    lytOferta.Margins.Top             := TResolucao.fMargTopLytOferta;

  except
    raise

  end;

end;


procedure TVeiwTabelaDePreco.CreateFrameTabelaPreco;
begin

  try

    if not assigned(VeiwTabelaDePreco) then
    VeiwTabelaDePreco := TVeiwTabelaDePreco.Create(self);

    with VeiwTabelaDePreco do
    begin

      Name      := 'FrameConfig';
      Parent    := frmPrincipal;

      IniciarFrame;
      BringToFront;


    end;

  except
    FechaFrameTabelaPreco;
    raise

  end;

end;

end.
