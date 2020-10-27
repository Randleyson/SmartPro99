unit uframe_Configuracao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.ListBox,
  FMX.Effects, FMX.Filter.Effects;

type
  TFrameConfig = class(TFrame)
    rectFundo: TRectangle;
    Label1: TLabel;
    lytTitulo: TLayout;
    Rectangle1: TRectangle;
    lytClient: TLayout;
    lytConfiguacaoTv: TLayout;
    lytConfigWs: TLayout;
    lytDetalheTv: TLayout;
    lytBtnTv: TLayout;
    btnEditarTv: TCornerButton;
    BtnGravarTv: TCornerButton;
    BtnCancelarTv: TCornerButton;
    rectDetalheTv: TRectangle;
    Label3: TLabel;
    edtCodTv: TEdit;
    Label4: TLabel;
    edtDescricao: TEdit;
    Label5: TLabel;
    edtIP: TEdit;
    lytETv: TLayout;
    lytDTv: TLayout;
    lytListaTv: TLayout;
    lstBoxTvs: TListBox;
    Label6: TLabel;
    Line2: TLine;
    Rectangle3: TRectangle;
    lytBotaoWs: TLayout;
    btnEditarWs: TCornerButton;
    btnGravarWs: TCornerButton;
    btnCancelarWs: TCornerButton;
    lytDetalheWs: TLayout;
    Layout3: TLayout;
    Label7: TLabel;
    edtHostWs: TEdit;
    Label8: TLabel;
    edtPortaWs: TEdit;
    lytTvAtiva: TLayout;
    Label2: TLabel;
    Line1: TLine;
    Label9: TLabel;
    Line3: TLine;
    btnFechar: TSpeedButton;
    FillRGBEffect1: TFillRGBEffect;
    lblDimencao: TLabel;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    cboxResolucao: TComboBox;
    Label10: TLabel;
    lblSemRegistro: TLabel;
    procedure btnEditarTvClick(Sender: TObject);
    procedure BtnGravarTvClick(Sender: TObject);
    procedure BtnCancelarTvClick(Sender: TObject);
    procedure btnEditarWsClick(Sender: TObject);
    procedure btnGravarWsClick(Sender: TObject);
    procedure btnCancelarWsClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure edtHostWsClick(Sender: TObject);
    procedure edtPortaWsClick(Sender: TObject);
    procedure lstBoxTvsItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
  private
    { Private declarations }
    procedure IniciaFrame;
    procedure ListarTvDisponivel;
    procedure AddItemsListBoxTv(pIdTv,pDescricao: String);
    procedure DetalharTvAtual;
    procedure DetalharConfgWs;
    procedure ListarResolucao(pResolucao:Integer);
    function ResolucaoSelecionada: string;
    procedure ControleBtnTv(pBtnAlter,pBtnGravar,pBtnCancelar: Boolean);
    procedure ControleBtnWs(pBtnEditar,pBtnGravar,pBtnCancelar: Boolean);

    procedure ClickBtnAlterTv;
    procedure ClickBtnSalvarTv;
    procedure ClickBtnCancelarTv;
    procedure ClickBtnEditarWs;
    procedure ClickBtnGravarWs;
    procedure ClickBtnCancelarWs;
    procedure ClickListTv(pIdTv: string);


  public
    { Public declarations }
    procedure CreateFrameConfig;
    procedure FechaFrameConfig;
  end;

var
  FrameConfig: TFrameConfig;

implementation

{$R *.fmx}

uses ufrm_Principal, udm_Principal, uframe_TabelaPreco, Loading,
  uframe_MensagemInfor, uframa_Edit, udm_conectSQLlite;

{ TFrameConfiguracao }

 

procedure TFrameConfig.AddItemsListBoxTv(pIdTv, pDescricao: String);
var
  vLstBoxItems : TListBoxItem;
begin

  try
    vLstBoxItems                := TListBoxItem.Create(lstBoxTvs);
    vLstBoxItems.Height         := 30;
    vLstBoxItems.Font.Size      := 11;
    vLstBoxItems.StyledSettings :=[TStyledSetting.Family,
                                   TStyledSetting.Style,
                                   TStyledSetting.FontColor,
                                   TStyledSetting.Other];
    vLstBoxItems.TagString      := pIdTv;
    vLstBoxItems.Text           := pIdTv +' - '+ pDescricao;
    vLstBoxItems.Parent         := lstBoxTvs;

    if pIdTv = FrmPrincipal.fIdTvAtual then
    vLstBoxItems.IsSelected := True;

  except
    FrmPrincipal.fMensagemErro := 'Erro ao executar AddItemsListBoxTv';
    raise
  end;

end;

procedure  TFrameConfig.ClickBtnCancelarTv;
begin
  try

    lstBoxTvs.Enabled       := False;
    rectDetalheTv.Enabled   := False;
    DetalharTvAtual;
    ControleBtnTv(True,False,False);

  except
    FrmPrincipal.fMensagemErro := 'Erro ao ClickBtnCancelar';
    raise

  end;
end;

procedure TFrameConfig.ClickBtnCancelarWs;
begin

  try

    DetalharConfgWs;
    lytDetalheWs.Enabled := False;
    ControleBtnWs(True,False,False);

  except
    raise

  end;

end;

procedure TFrameConfig.ClickBtnEditarWs;
begin

  try

    lytDetalheWs.Enabled  := True;
    ControleBtnWs(False,True,True);

  except
    raise
  end;

end;

procedure TFrameConfig.ClickBtnGravarWs;
begin

  try

    DmPrincipal.GravarConfigWs(edtHostWs.Text,edtPortaWs.Text);
    lytDetalheWs.Enabled := False;
    ControleBtnWs(True,False,False);

  except
    raise

  end;


end;

procedure TFrameConfig.BtnCancelarTvClick(Sender: TObject);
begin

  try

    ClickBtnCancelarTv;

  except
    raise

  end;

end;

procedure TFrameConfig.btnCancelarWsClick(Sender: TObject);
begin

  try

    ClickBtnCancelarWs;

  except
    ShowMessage(FrmPrincipal.fMensagemErro);

  end;
end;

procedure TFrameConfig.btnEditarTvClick(Sender: TObject);
begin

  try

    ClickBtnAlterTv;

  except
    ShowMessage(FrmPrincipal.fMensagemErro);

  end;

end;

procedure TFrameConfig.btnEditarWsClick(Sender: TObject);
begin

  try

    ClickBtnEditarWs;

  except
    ShowMessage(FrmPrincipal.fMensagemErro);

  end;


end;

procedure TFrameConfig.BtnGravarTvClick(Sender: TObject);
begin

  try

    ClickBtnSalvarTv;

  except
    ShowMessage(FrmPrincipal.fMensagemErro);

  end;
end;

procedure TFrameConfig.btnGravarWsClick(Sender: TObject);
begin

  try

    ClickBtnGravarWs;

  except
    FrameMsgInfor.CreateFrameMsgInfor(FrmPrincipal.fMensagemErro);

  end;

end;

procedure TFrameConfig.ClickBtnAlterTv;
begin

  try

    lstBoxTvs.Enabled     := True;
    rectDetalheTv.Enabled := True;
    ControleBtnTv(False,True,True);

  except
    FrmPrincipal.fMensagemErro := 'Erro ao ClickBtnAlter';
    raise

  end;
end;

procedure TFrameConfig.ClickBtnSalvarTv;
begin

  try

    if lstBoxTvs.ItemIndex = -1 then
    begin
      FrameMsgInfor.CreateFrameMsgInfor('Selcione um a TV na lista');
      exit;
    end;
    
    FrmPrincipal.fIdTvAtual := lstBoxTvs.ListItems[lstBoxTvs.ItemIndex].TagString;
    DmPrincipal.AlteraConfiguracaoTv(FrmPrincipal.fIdTvAtual,ResolucaoSelecionada);
    lstBoxTvs.Enabled       := False;
    rectDetalheTv.Enabled   := False;
    DmPrincipal.CarregaParamentros;
    DetalharTvAtual;
    ControleBtnTv(True,False,False);
    FrameMsgInfor.CreateFrameMsgInfor('Alterção salva com exito');

  except
    raise

  end;

end;

procedure TFrameConfig.ClickListTv(pIdTv: string);
begin

  try

    DmPrincipal.FMentTv.Filter   := ' idtv = ' + FrmPrincipal.ifVasiu(pIdTv,'0');
    DmPrincipal.FMentTv.Filtered := True;
    DmPrincipal.FMentTv.First;

    edtCodTv.Text     := pIdTv;
    edtDescricao.Text := DmPrincipal.FMentTv.FieldByName('DescricaoTv').AsString;
    edtIP.Text        := DmPrincipal.FMentTv.FieldByName('IpTv').AsString;

  except
    FrmPrincipal.fMensagemErro := 'Erro ao executar ClickListTv';

  end;

end;

procedure TFrameConfig.ControleBtnTv(pBtnAlter, pBtnGravar,
  pBtnCancelar: Boolean);
begin

  btnEditarTv.Enabled   := pBtnAlter;
  BtnGravarTv.Enabled   := pBtnGravar;
  BtnCancelarTv.Enabled := pBtnCancelar;

end;

procedure TFrameConfig.ControleBtnWs(pBtnEditar, pBtnGravar,
  pBtnCancelar: Boolean);
begin

  btnEditarWs.Enabled   := pBtnEditar;
  btnGravarWs.Enabled   := pBtnGravar;
  btnCancelarWs.Enabled := pBtnCancelar;

end;


procedure TFrameConfig.DetalharConfgWs;
begin

   try
     DmPrincipal.QryToFMent(DmPrincipal.FQryTabConfig,DmPrincipal.FMentConfig);

     edtHostWs.Text  := DmPrincipal.FMentConfig.FieldByName('HOSTWS').AsString;
     edtPortaWs.Text := DmPrincipal.FMentConfig.FieldByName('PORTAWS').AsString;

   except
     FrmPrincipal.fMensagemErro := 'Erro ao DetalharConfgWs';
     raise

   end;

end;

procedure TFrameConfig.DetalharTvAtual;
begin

  try

    DmPrincipal.FMentTv.Filter   := ' idtv = ' + FrmPrincipal.ifVasiu(FrmPrincipal.fIdTvAtual,'0');
    DmPrincipal.FMentTv.Filtered := True;
    DmPrincipal.FMentTv.First;

    edtCodTv.Text     := FrmPrincipal.fIdTvAtual;
    edtDescricao.Text := DmPrincipal.FMentTv.FieldByName('DescricaoTv').AsString;
    edtIP.Text        := DmPrincipal.FMentTv.FieldByName('IpTv').AsString;
    ListarResolucao(FrmPrincipal.fResolucaoAtual);

  except
    FrmPrincipal.fMensagemErro := 'Não e possivel detalhar a Tv atual';
    raise

  end;

end;

procedure TFrameConfig.edtHostWsClick(Sender: TObject);
begin

  try

    FrameEdit.CreateFrameTextoEdit(edtHostWs.Text,edtHostWs);

  except
    FrameMsgInfor.CreateFrameMsgInfor(FrmPrincipal.fMensagemErro);

  end;

end;

procedure TFrameConfig.edtPortaWsClick(Sender: TObject);
begin

  try

    FrameEdit.CreateFrameTextoEdit(edtPortaWs.Text,edtPortaWs);

  except
    FrameMsgInfor.CreateFrameMsgInfor(FrmPrincipal.fMensagemErro);

  end;

end;

procedure TFrameConfig.FechaFrameConfig;
begin

  TLoading.Show(frmPrincipal,'Aguarde... Conectando ao servidor');

  TThread.CreateAnonymousThread(procedure
  begin
    try

      try

        FrmPrincipal.RecebeAtualizaWs;;

      except
        raise

      end;

    finally
    
      TThread.Synchronize(nil,procedure
      begin

        FrameTabelaPreco.CreateFrameTabelaPreco;

        if FrmPrincipal.fStatusConexaoWs = 1 then
        FrameMsgInfor.CreateFrameMsgInfor('Não foi possivel conectar ao servidor, verifica as configuração');
        FrameConfig.Visible := False;
        TLoading.Hide;
        FrameConfig         := nil;

      end);
    end;

  end).Start;

end;

procedure TFrameConfig.IniciaFrame;
begin

  try
  
    lblDimencao.Text      := 'Dimenção da Tela '+ IntToStr(Screen.Height) +
                             ' X '+ IntToStr(Screen.Width);
    lstBoxTvs.Enabled     := False;
    rectDetalheTv.Enabled := False;
    lytDetalheWs.Enabled  := False;
    ListarTvDisponivel;
    DetalharTvAtual;

    DetalharConfgWs;
    ControleBtnTv(True,False,False);
    ControleBtnWs(True,False,False);

  except
    raise;
  end;
end;

procedure TFrameConfig.ListarResolucao(pResolucao: Integer);
var
  vPosicao: Integer;
begin

  try

    try

      vPosicao := -1;
      cboxResolucao.Clear;
      dmConectSQLlite.AbreConexaoSQLlite;
      DmPrincipal.FQryResolucao.Close;
      DmPrincipal.FQryResolucao.Open;
      DmPrincipal.FQryResolucao.First;
      cboxResolucao.BeginUpdate;
      while not DmPrincipal.FQryResolucao.Eof do
      begin

        cboxResolucao.Items.Add(DmPrincipal.FQryResolucao.FieldByName('idresolucao').AsString + ' - '+
                                DmPrincipal.FQryResolucao.FieldByName('NOME').AsString);

        vPosicao := vPosicao + 1;
        if DmPrincipal.FQryResolucao.FieldByName('idresolucao').AsInteger = FrmPrincipal.fResolucaoAtual then
        cboxResolucao.ItemIndex := vPosicao;

        DmPrincipal.FQryResolucao.Next;

      end;

      cboxResolucao.EndUpdate;

    except
      raise
    end;

  finally
    DmPrincipal.FQryResolucao.Close;
    dmConectSQLlite.FechaSQLlite;

  end;


end;


procedure TFrameConfig.ListarTvDisponivel;
begin

  try

    DmPrincipal.QryToFMent(DmPrincipal.FQryTv,DmPrincipal.FMentTv);
    DmPrincipal.FMentTv.Filtered := False;

    lblSemRegistro.Visible := True;
    if DmPrincipal.FMentTv.RecordCount > 0 then
    begin

      lblSemRegistro.Visible := False;
      DmPrincipal.FMentTv.First;
      lstBoxTvs.Items.Clear;
      lstBoxTvs.BeginUpdate;
      while not DmPrincipal.FMentTv.Eof do
      begin

        AddItemsListBoxTv(DmPrincipal.FMentTv.FieldByName('IDTV').AsString,
                          DmPrincipal.FMentTv.FieldByName('DESCRICAOTV').AsString);

        DmPrincipal.FMentTv.Next;

      end;

      lstBoxTvs.EndUpdate;
    end;

  except
    FrmPrincipal.fMensagemErro := 'Não foi possivel Listar as TV';
    raise

  end;

end;


procedure TFrameConfig.lstBoxTvsItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin

  try

    ClickListTv(lstBoxTvs.ListItems[lstBoxTvs.ItemIndex].TagString);

  except
    FrameMsgInfor.CreateFrameMsgInfor(FrmPrincipal.fMensagemErro);

  end;

end;

function TFrameConfig.ResolucaoSelecionada: string;
var
  vTex: string;
begin

  try

    vTex := cboxResolucao.Items[cboxResolucao.ItemIndex];
    result := copy(vTex,0,Pos(' ',vTex))

  except
    FrmPrincipal.fMensagemErro := 'Erro ao executar ResolucaoSelecionada' ;
    raise
  end;

end;

procedure TFrameConfig.btnFecharClick(Sender: TObject);
begin

  try
  
    FechaFrameConfig;  
    
  except
    FrameMsgInfor.CreateFrameMsgInfor('Erro ao fechar a tela de config');
  end;
  
end;

procedure TFrameConfig.CreateFrameConfig;
begin

  try

    if not assigned(FrameConfig) then
    FrameConfig := TFrameConfig.Create(self);

    with FrameConfig do
    begin

      Name      := 'FrameConfig';
      Parent    := frmPrincipal;

      Width     := Screen.Width;
      Height    := Screen.Height;
      IniciaFrame;
      BringToFront;


    end;

  except
    FechaFrameConfig;
    ShowMessage('Erro : '+ FrmPrincipal.fMensagemErro);

  end;

end;

end.
