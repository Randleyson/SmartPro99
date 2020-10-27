unit uframe_TabelaPreco;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.ListBox, FMX.Objects, uframe_FTabelaPreco, System.ImageList,
  FMX.ImgList, FMX.Controls.Presentation;

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
    imgLogo: TImage;
    tmAtualizaProdutos: TTimer;
    procedure imgConfiguracaoClick(Sender: TObject);
    procedure tmProxPaginaTimer(Sender: TObject);
    procedure imgLogsClick(Sender: TObject);
    procedure tmAtualizaProdutosTimer(Sender: TObject);

  private
    { Private declarations }
    fNroPag: integer;
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
  udm_conectSQLlite, uframe_Logs, Resolucao;

{ TFrameTabelaPreco }

procedure TFrameTabelaPreco.AddFrameListBox(pDescricao, pValorVenda: string);
var
  vFrame : TFrameFPreco;
  vItem : TListBoxItem;

begin

  try

    vItem                         := TListBoxItem.Create(lstBoxTabelaPreco);
    vItem.Text                    := '';
    vItem.Selectable              := False;
    vItem.Height                  := TResolucao.AlstTabPreco;

    vFrame                            := TFrameFPreco.Create(vItem);
    vFrame.Parent                     := vItem;
    vFrame.Align                      := TAlignLayout.Client;
    vFrame.lblDescricaoProd.text      := pDescricao;
    vFrame.lblDescricaoProd.Font.Size := TResolucao.TlstTabPreco;
    vFrame.lblValorVenda.text         := formatfloat('R$ ##,###,##0.00',StrToFloat(pValorVenda));
    vFrame.lblValorVenda.Font.Size    := TResolucao.TlstTabPreco;
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
    FrameLogs.AddLogs('Carga de produto realizada com exito ');

  except
    FrameLogs.AddLogs('Erro :'+ FrmPrincipal.fMensagemErro);
    raise

  end;
end;

procedure TFrameTabelaPreco.tmProxPaginaTimer(Sender: TObject);
begin

  ProximaPag;

end;

procedure TFrameTabelaPreco.imgConfiguracaoClick(Sender: TObject);
begin

  TLoading.Show(frmPrincipal,'Aguarde... Conectando ao servidor');

  TThread.CreateAnonymousThread(procedure
  begin
    try

      try

        DmPrincipal.CarregaParamentros;
        if DmPrincipal.TestaConexaoWS then
        DmPrincipal.RecebeTvsWs;

        FrameConfig.CreateFrameConfig;
        tmProxPagina.Enabled                    := False;
        tmAtualizaProdutos.Enabled := False;

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

      DmPrincipal.QryToFMent(DmPrincipal.FQryProdutos,DmPrincipal.FMentProd);
      lstBoxTabelaPreco.Clear;

      if DmPrincipal.FMentProd.RecordCount <> 0 then
      begin
        DmPrincipal.FMentProd.First;
        lstBoxTabelaPreco.BeginUpdate;
        ListarProduto;
        lstBoxTabelaPreco.EndUpdate;
      end;

      tmProxPagina.Enabled       := True;
      tmAtualizaProdutos.Enabled := True;
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

      if vI < TResolucao.QProdutoListado then
      begin

        AddFrameListBox(DmPrincipal.FMentProd.FieldByName('Descricao').AsString,
                        DmPrincipal.FMentProd.FieldByName('vrvenda').AsString);
        DmPrincipal.FMentProd.Next;
        vI := vI + 1;

      end
      else
      begin

        exit;

      end;

    end;

  except
    FrameLogs.AddLogs('Não foi possivel Listar os produto no listBox');
    raise

  end;

end;

procedure TFrameTabelaPreco.ProximaPag;
begin



  lstBoxTabelaPreco.Clear;
  lstBoxTabelaPreco.BeginUpdate;

  TThread.CreateAnonymousThread(procedure
  begin
    try

      try

        if FrmPrincipal.fNovaCarga then
        begin
          DmPrincipal.QryToFMent(DmPrincipal.FQryProdutos,DmPrincipal.FMentProd);
          DmPrincipal.FMentProd.First;
          FrmPrincipal.fNovaCarga := False;
        end;
        ListarProduto;

      except

      end;

    finally

      TThread.Synchronize(nil,procedure
      begin

        lstBoxTabelaPreco.EndUpdate;

      end);
    end;

  end).Start;

end;

procedure TFrameTabelaPreco.AjustaResolucao;
begin

  try

    lstBoxTabelaPreco.Width       := TResolucao.LlstTabPreco;
    lstBoxTabelaPreco.Margins.Top := TResolucao.MarTopLstTabPreco;
    imgLogo.Width                 := TResolucao.LimgLogo;

  except

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
