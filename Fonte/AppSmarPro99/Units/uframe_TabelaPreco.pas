unit uframe_TabelaPreco;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.ListBox, FMX.Objects, uframe_FTabelaPreco, System.ImageList,
  FMX.ImgList, FMX.Controls.Presentation, uframe_Oferta;

type
  TFrameTabelaPreco = class(TFrame)
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
  FrameTabelaPreco:TFrameTabelaPreco;


implementation

{$R *.fmx}

uses ufrm_Principal, udm_Principal, uframe_Configuracao, Loading,
  udm_conectSQLlite, uframe_Logs, uframe_MensagemInfor, Resolucao;

{ TFrameTabelaPreco }

procedure TFrameTabelaPreco.AddFrameListBox(pDescricao, pValorVenda: string);
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

procedure TFrameTabelaPreco.FechaFrameTabelaPreco;
begin

  FrameTabelaPreco.Visible := False;
  FrameTabelaPreco := nil;

end;

procedure TFrameTabelaPreco.StatusConexao(pIndex: integer);
begin

  imgConexao.ImageIndex := pIndex;

end;

procedure TFrameTabelaPreco.tmAtualizaProdutosTimer(Sender: TObject);
begin

  try

    FrmPrincipal.RecebeAtualizaWs;

  except
    raise

  end;
end;

procedure TFrameTabelaPreco.tmProxPaginaTimer(Sender: TObject);
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

procedure TFrameTabelaPreco.imgConfiguracaoClick(Sender: TObject);
begin

  TLoading.Show(frmPrincipal,'Aguarde... Conectando ao servidor');

  TThread.CreateAnonymousThread(procedure
  begin
    try

      try

        tmProxPagina.Enabled       := False;
        tmAtualizaProdutos.Enabled := False;

        DmPrincipal.CarregaParamentros;
        if DmPrincipal.TestaConexaoWS then
        DmPrincipal.RecebeTvsWs;

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

procedure TFrameTabelaPreco.imgLogsClick(Sender: TObject);
begin

  try

    FrameLogs.VisualizaLogs;

  except

  end;

end;

procedure TFrameTabelaPreco.IconeConexao;
begin

  imgConexao.ImageIndex := FrmPrincipal.fStatusConexaoWs;

end;

procedure TFrameTabelaPreco.IniciarFrame;
begin

    try

      DmPrincipal.CarregaParamentros;

      if FrmPrincipal.fIdTvAtual = '0' then
      exit;

      DmPrincipal.QryToFMent(DmPrincipal.FQryProdutos,
                             DmPrincipal.FMentProd);

      lstBoxTabelaPreco.Clear;

      if DmPrincipal.FMentProd.RecordCount <> 0 then
      begin
        DmPrincipal.FMentProd.First;
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


procedure TFrameTabelaPreco.ListarProduto;
var
  vI: integer;
begin

  try

    vI := 0;
    IconeConexao;

    if DmPrincipal.FMentProd.Eof then
    DmPrincipal.FMentProd.First;

    while not DmPrincipal.FMentProd.Eof do
    begin

      if vI < TResolucao.fQtdeProdGrid then
      begin

        AddFrameListBox(DmPrincipal.FMentProd.FieldByName('Descricao').AsString,
                        DmPrincipal.FMentProd.FieldByName('vrvenda').AsString);
        DmPrincipal.FMentProd.Next;
        fUltimoRegistro := DmPrincipal.FMentProd.RecNo;
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

procedure TFrameTabelaPreco.ProximaPag;
begin

  try

    lstBoxTabelaPreco.Clear;

    if FrmPrincipal.fNovaCarga then
    begin
      DmPrincipal.QryToFMent(DmPrincipal.FQryProdutos,DmPrincipal.FMentProd);
      DmPrincipal.FMentProd.RecNo := fUltimoRegistro;
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

procedure TFrameTabelaPreco.AjustaResolucao;
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


procedure TFrameTabelaPreco.CreateFrameTabelaPreco;
begin

  try

    if not assigned(FrameTabelaPreco) then
    FrameTabelaPreco := TFrameTabelaPreco.Create(self);

    with FrameTabelaPreco do
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
