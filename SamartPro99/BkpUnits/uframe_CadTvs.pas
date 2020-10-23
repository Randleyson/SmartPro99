unit uframe_CadTvs;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.Edit, FMX.ListBox,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMX.Ani, FMX.Effects, FMX.Filter.Effects, FMX.TabControl;

type
  TFrameCadTv = class(TFrame)
    Rectangle1: TRectangle;
    lytTitulo: TLayout;
    btnFechar: TSpeedButton;
    Label1: TLabel;
    lytListaTv: TLayout;
    lstBoxTvs: TListBox;
    Label2: TLabel;
    Line1: TLine;
    btnAdicionarTv: TCornerButton;
    btnEditar: TCornerButton;
    btnExcluir: TCornerButton;
    lytBotao1: TLayout;
    lytCadTv: TLayout;
    Label3: TLabel;
    edtCodigoTv: TEdit;
    lblDescricaoTv: TLabel;
    edtDescricaoTv: TEdit;
    lstBoxProdNaoTV: TListBox;
    lstBoxProdNaTv: TListBox;
    btnRemoverProdDaTv: TSpeedButton;
    btnInseriProdNaTv: TSpeedButton;
    lytProdTv: TLayout;
    btnInserirTodoNaTv: TCornerButton;
    btnRemoverTodosDaTv: TCornerButton;
    lytProdNaoTV: TLayout;
    lytProdNaTv: TLayout;
    lytBtnCentral: TLayout;
    lytPesqProdNaoTV: TLayout;
    edtPesqCodProdNaoTv: TEdit;
    edtPesqDescrProdNaoTv: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    lytPesqProdNaTv: TLayout;
    edtPesqCodProdNaTv: TEdit;
    edtPesqDescProdNaTv: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    lblSemRegistroTv: TLabel;
    lblSemRegistroProdNaotv: TLabel;
    btnPesqProdNaoTv: TButton;
    btnPesqProdNaTv: TButton;
    lblSemRegistroProdNaTv: TLabel;
    Rectangle2: TRectangle;
    FillRGBEffect1: TFillRGBEffect;
    Line2: TLine;
    Rectangle3: TRectangle;
    lblTituloDetalhesTv: TLabel;
    Line3: TLine;
    rectDetalheTv: TRectangle;
    lytDadosDetalheTv: TLayout;
    rectEdtiDescricao: TRectangle;
    lytCodtv: TLayout;
    Label6: TLabel;
    Rectangle6: TRectangle;
    FillRGBEffect2: TFillRGBEffect;
    Rectangle7: TRectangle;
    Rectangle8: TRectangle;
    Label11: TLabel;
    Rectangle9: TRectangle;
    Label12: TLabel;
    Rectangle10: TRectangle;
    Rectangle11: TRectangle;
    FillRGBEffect3: TFillRGBEffect;
    Rectangle12: TRectangle;
    Rectangle13: TRectangle;
    Label13: TLabel;
    Rectangle14: TRectangle;
    Rectangle15: TRectangle;
    Rectangle16: TRectangle;
    Rectangle17: TRectangle;
    FillRGBEffect4: TFillRGBEffect;
    FillRGBEffect5: TFillRGBEffect;
    lytBtnCadTv: TLayout;
    btnGravarCadTv: TCornerButton;
    Layout1: TLayout;
    TabControl: TTabControl;
    tabListaTv: TTabItem;
    tabCadTv: TTabItem;
    lytBotao0: TLayout;
    lytBotaoCadTv1: TLayout;
    btnCancelarCadTv: TCornerButton;
    procedure btnFecharClick(Sender: TObject);
    procedure btnAdicionarTvClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarCadTvClick(Sender: TObject);
    procedure btnCancelarCadTvClick(Sender: TObject);
    procedure btnInseriProdNaTvClick(Sender: TObject);

  private
    { Private declarations }
    fidtv: Integer;
    fStatusTela: String;

    {TAB LISTAR TV}
    procedure ShowTabListarTv;
    procedure ListarTvCadastrada;

    procedure ClickBtnAdicionarTv;
    procedure ClickBtnEditarTv;
    procedure ClickBtnExcluirTv;

    {TAB CADASTAR TV}
    procedure ShowTabCadTv;
    procedure DetalhesDaTv;
    procedure ListarProdNaoTv;
    procedure ListarProdNaTv;
    procedure AddItemListBox(pCodbarra,pDescricao,pVrVenda: String;
              pListBox: TListBox; pLableSemGerg: TLabel);

    procedure ControlarLayoutCadTv;
    procedure ClickBtnGravaTv;
    procedure ClickCancelarCadTv;
    procedure ClickBtnAdicionarProd;

    procedure ControlarBotao(pBtnAdicionar, pBtnEdtitar, pExcluir: Boolean);


  public
    { Public declarations }
    procedure CreateFrameCadTv;
    procedure DestroyFrameCadTv;

  end;

var
  FrameCadTv : TFrameCadTv;

implementation

{$R *.fmx}

uses ufrm_Principal, Loading, udm_CadTv, ufrm_MensagemInfor;

{ TFrame1 }


{ TFrameCadTv }

procedure TFrameCadTv.AddItemListBox(pCodbarra, pDescricao, pVrVenda: String;
  pListBox: TListBox; pLableSemGerg: TLabel);
var
  vItem: TListBoxItem;
begin

  try

    vItem                 := TListBoxItem.Create(pListBox);
    vItem.Text            := '';
    vItem.align           := TAlignLayout.Client;
    vItem.StyleLookup     := 'listboxitembottomdetail';
    vItem.Height          := 40;
    vItem.TagString       := pCodBarra;
    vItem.ItemData.Text   := pDescricao;
    vItem.ItemData.Detail := 'Cod '+pCodBarra + ' ........... R$ '+ pVrVenda;
    pListBox.AddObject(vItem);

    if pListBox.Count = -1 then
    pLableSemGerg.Visible := True
    else
    pLableSemGerg.Visible := False;

  except
    FrmPrincipal.fMensagemErro := 'Não foi possivel adicionar o frame no lisBox';
    raise
  end;

end;

procedure TFrameCadTv.btnAdicionarTvClick(Sender: TObject);
begin

  frmPrincipal.FMensagemAguarde := 'Aguarde... Carregando a Tela';
  TLoading.Show(frmPrincipal,frmPrincipal.FMensagemAguarde);

  TThread.CreateAnonymousThread(procedure
  begin
    try

      try

        ClickBtnAdicionarTv;

      except
        ShowMessage(frmPrincipal.fMensagemErro);

      end;

    finally

      TThread.Synchronize(nil,procedure
      begin
        TLoading.Hide;
      end);
    end;

  end).Start;

end;

procedure TFrameCadTv.btnCancelarCadTvClick(Sender: TObject);
begin

  frmPrincipal.FMensagemAguarde := 'Aguarde... Carregando a Tela';
  TLoading.Show(frmPrincipal,frmPrincipal.FMensagemAguarde);

  TThread.CreateAnonymousThread(procedure
  begin
    try

      try

        ClickCancelarCadTv;

      except
        ShowMessage(frmPrincipal.fMensagemErro);

      end;

    finally

      TThread.Synchronize(nil,procedure
      begin
        TLoading.Hide;
      end);
    end;

  end).Start;


end;

procedure TFrameCadTv.btnEditarClick(Sender: TObject);
begin

  frmPrincipal.FMensagemAguarde := 'Aguarde... Carregando a Tela';
  TLoading.Show(frmPrincipal,frmPrincipal.FMensagemAguarde);

  TThread.CreateAnonymousThread(procedure
  begin
    try

      try


        ClickBtnEditarTv;

      except
        ShowMessage(frmPrincipal.fMensagemErro);

      end;

    finally

      TThread.Synchronize(nil,procedure
      begin
        TLoading.Hide;
      end);
    end;

  end).Start;

end;

procedure TFrameCadTv.btnExcluirClick(Sender: TObject);
begin

  frmPrincipal.FMensagemAguarde := 'Aguarde... Carregando a Tela';
  TLoading.Show(frmPrincipal,frmPrincipal.FMensagemAguarde);

  TThread.CreateAnonymousThread(procedure
  begin
    try

      try

        ClickBtnExcluirTv;


      except
        ShowMessage(frmPrincipal.fMensagemErro);

      end;

    finally

      TThread.Synchronize(nil,procedure
      begin
        TLoading.Hide;
      end);
    end;

  end).Start;

end;

procedure TFrameCadTv.btnFecharClick(Sender: TObject);
begin

  DestroyFrameCadTv;

end;

procedure TFrameCadTv.btnGravarCadTvClick(Sender: TObject);
begin

  frmPrincipal.FMensagemAguarde := 'Aguarde... Carregando a Tela';
  TLoading.Show(frmPrincipal,frmPrincipal.FMensagemAguarde);

  TThread.CreateAnonymousThread(procedure
  begin
    try

      try

        ClickBtnGravaTv;

      except
        ShowMessage(frmPrincipal.fMensagemErro);

      end;

    finally

      TThread.Synchronize(nil,procedure
      begin
        TLoading.Hide;
      end);
    end;

  end).Start;

end;

procedure TFrameCadTv.btnInseriProdNaTvClick(Sender: TObject);
begin

  frmPrincipal.FMensagemAguarde := 'Aguarde... Carregando a Tela';
  TLoading.Show(frmPrincipal,frmPrincipal.FMensagemAguarde);

  TThread.CreateAnonymousThread(procedure
  begin
    try

      try

        ClickBtnAdicionarProd;

      except
        ShowMessage(frmPrincipal.fMensagemErro);

      end;

    finally

      TThread.Synchronize(nil,procedure
      begin
        TLoading.Hide;
      end);
    end;

  end).Start;
end;

procedure TFrameCadTv.ClickBtnAdicionarProd;
begin

  try

    {Enviar o produto Para o banco}
    {Remover do lista de produto nao tv}
    {Adicionar o produto na TV}

  except
    raise

  end;




end;

procedure TFrameCadTv.ClickBtnAdicionarTv;
begin

  try

    fStatusTela          := 'Adicionar';
    ShowTabCadTv;

  except
    raise;

  end;

end;

procedure TFrameCadTv.ClickBtnEditarTv;
begin

  try

    if lstBoxTvs.ItemIndex = -1 then
    begin
      FrameMsgInfor.ShowFrameMsgInfor('Selciona a Tv a ser editar');
      exit
    end;

    fidtv := StrToInt(lstBoxTvs.ListItems[lstBoxTvs.ItemIndex].TagString);
    fStatusTela := 'Editar';
    ShowTabCadTv;

  except
    raise;

  end;

end;

procedure TFrameCadTv.ClickBtnExcluirTv;
begin

  try

    if lstBoxTvs.Index = -1 then
    begin

      FrameMsgInfor.ShowFrameMsgInfor('Selecione a Tv a ser excluida');
      exit

    end;

    fIdTv := StrToInt(lstBoxTvs.ListItems[lstBoxTvs.ItemIndex].TagString);
    dmCadTv.ExcluTv(fIdTv);
    FrameMsgInfor.ShowFrameMsgInfor('Tv excuida com exito.');
    ShowTabListarTv;

  except
    raise;

  end;

end;

procedure TFrameCadTv.ClickBtnGravaTv;
begin

  try

    if edtDescricaoTv.Text = '' then
    begin

      FrameMsgInfor.ShowFrameMsgInfor('É nesecario informar o no da TV');
      edtDescricaoTv.SetFocus;
      exit

    end;

    if fStatusTela = 'Adicionar' then
    begin

      fidtv := dmCadTv.InseriTv(edtDescricaoTv.Text);
      fStatusTela := 'Editar';
      ShowTabListarTv;
      exit;

    end;

    if fStatusTela = 'Editar' then
    begin
      dmCadTv.AlteraTv(fidtv,edtDescricaoTv.Text);
      ShowTabListarTv;
      exit;
    end;

    FrameMsgInfor.ShowFrameMsgInfor('Alteracao salvada com exito.');
  except
    raise;

  end;

end;

procedure TFrameCadTv.ClickCancelarCadTv;
begin

  try

    ShowTabListarTv;

  except
    raise;

  end;


end;

procedure TFrameCadTv.ControlarBotao(pBtnAdicionar, pBtnEdtitar, pExcluir: Boolean);
begin

  btnAdicionarTv.Enabled := pBtnAdicionar;
  btnEditar.Enabled      := pBtnEdtitar;
  btnExcluir.Enabled     := pExcluir;

end;

procedure TFrameCadTv.ControlarLayoutCadTv;
begin

  if fStatusTela = 'Adicionar' then
  begin
    lytCadTv.Height     := 180;
    lytProdTv.Visible   := False;
    lytBtnCadTv.Visible := True;
  end;

  if fStatusTela = 'Editar' then
  begin
    lytCadTv.Height         := 340;
    lytProdTv.Visible       := True;
  end;

end;

procedure TFrameCadTv.CreateFrameCadTv;
begin

  frmPrincipal.FMensagemAguarde := 'Aguarde... Carregando a Tela';
  TLoading.Show(frmPrincipal,frmPrincipal.FMensagemAguarde);

  TThread.CreateAnonymousThread(procedure
  begin
    try

      try

        if not assigned(FrameCadTv) then
        FrameCadTv := TFrameCadTv.Create(self);

        with FrameCadTv do
        begin

          Name      := 'FrameCadTv';
          Parent    := frmPrincipal;

          dmCadTv := TdmCadTv.Create(self);

          ShowTabListarTv;
        end;

      except
        DestroyFrameCadTv;
        ShowMessage(frmPrincipal.fMensagemErro);

      end;

    finally

      TThread.Synchronize(nil,procedure
      begin
        TLoading.Hide;
      end);
    end;

  end).Start;
end;

procedure TFrameCadTv.DestroyFrameCadTv;
begin

  dmCadTv.Destroy;
  FrameCadTv.Visible := False;
  FrameCadTv := nil;

end;

procedure TFrameCadTv.DetalhesDaTv;
begin

  try

    dmCadTv.CopyDataSet(dmCadTv.FQryTv,dmCadTv.FMenTv);

    dmCadTv.FMenTv.Filter   := 'Idtv = ' + IntToStr(fIdTv);
    dmCadTv.FMenTv.Filtered := True;
    dmCadTv.FMenTv.First;
    edtCodigoTv.Text        := dmCadTv.FMenTv.FieldByName('IDTV').AsString;
    edtDescricaoTv.Text     := dmCadTv.FMenTv.FieldByName('DESCRICAOTV').AsString;

  except
    raise;

  end;
end;

procedure TFrameCadTv.ListarProdNaoTv;
begin

  try

    dmCadTv.CopyDataSet(dmCadTv.FQryProdNaoTv,dmCadTv.FMenProdutos);
    dmCadTv.FMenProdutos.Filter := ' idtv <> ' + IntToStr(fIdTv);
    dmCadTv.FMenProdutos.Filtered := True;

    lstBoxProdNaoTV.Items.Clear;
    if dmCadTv.FMenProdutos.RecordCount <> 0 then
    begin

      lstBoxProdNaoTV.BeginUpdate;
      while not dmCadTv.FMenProdutos.eof do
      begin
        AddItemListBox(dmCadTv.FMenProdutos.FieldByName('CODBARRA').AsString,
                        dmCadTv.FMenProdutos.FieldByName('DESCRICAO').AsString,
                        dmCadTv.FMenProdutos.FieldByName('VRVENDA').AsString,
                        lstBoxProdNaoTV,lblSemRegistroProdNaotv);
                        dmCadTv.FMenProdutos.FieldByName('idtv').AsString;

        dmCadTv.FMenProdutos.Next;
      end;

      lstBoxProdNaoTV.EndUpdate;
    end;

  except
    frmPrincipal.fMensagemErro := 'Não foi possivel listar produtos que não estao na TV';
    raise;

  end;

end;

procedure TFrameCadTv.ListarProdNaTv;
begin

  try

    dmCadTv.CopyDataSet(dmCadTv.FQryProdNaoTv,dmCadTv.FMenProdutos);
    dmCadTv.FMenProdutos.Filter := ' idtv = ' + IntToStr(fIdTv);
    dmCadTv.FMenProdutos.Filtered := True;

    lstBoxProdNaoTV.Items.Clear;
    if dmCadTv.FMenProdutos.RecordCount <> 0 then
    begin

      lstBoxProdNaoTV.BeginUpdate;
      while not dmCadTv.FMenProdutos.eof do
      begin
        AddItemListBox(dmCadTv.FMenProdutos.FieldByName('CODBARRA').AsString,
                        dmCadTv.FMenProdutos.FieldByName('DESCRICAO').AsString,
                        dmCadTv.FMenProdutos.FieldByName('VRVENDA').AsString,
                        lstBoxProdNaTv,lblSemRegistroProdNaTv);
                        dmCadTv.FMenProdutos.FieldByName('idtv').AsString;

        dmCadTv.FMenProdutos.Next;
      end;

      lstBoxProdNaoTV.EndUpdate;
    end;

  except
    frmPrincipal.fMensagemErro := 'Não foi possivel listar produtos que não estao na TV';
    raise;

  end;

end;

procedure TFrameCadTv.ListarTvCadastrada;
var
  vLstBoxItems : TListBoxItem;
  vPriRegestro : Boolean;

begin

  try

    dmCadTv.CopyDataSet(dmCadTv.FQryTv,dmCadTv.FMenTv);

    lstBoxTvs.Items.Clear;
    lblSemRegistroTv.Visible := False;
    if dmCadTv.FMenTv.RecordCount <> 0  then
    begin
      lstBoxTvs.Items.Clear;

      lstBoxTvs.BeginUpdate;

      dmCadTv.FMenTv.First;
      vPriRegestro := True;
      while not dmCadTv.FMenTv.Eof do
      begin

        vLstBoxItems                        := TListBoxItem.Create(lstBoxTvs);
        vLstBoxItems.Text                   := '';
        vLstBoxItems.Height                 := 30;

        vLstBoxItems.TagString              := dmCadTv.FMenTv.FieldByName('IDTV').AsString;
        vLstBoxItems.Text                   :=  dmCadTv.FMenTv.FieldByName('IDTV').AsString+
                                                '          .....        '+
                                                dmCadTv.FMenTv.FieldByName('DESCRICAOTV').AsString;
        vLstBoxItems.Parent                 := lstBoxTvs;

        if vPriRegestro then
        begin
          vLstBoxItems.IsSelected := True;
          vPriRegestro := False;
        end;

        dmCadTv.FMenTv.Next;
      end;

      lstBoxTvs.EndUpdate;
    end;



  except
    frmPrincipal.fMensagemErro := 'Não foi possivel listar Tv cadastrada';
    raise

  end;
end;

procedure TFrameCadTv.ShowTabCadTv;
begin

  if fStatusTela = 'Adicionar' then
  begin

    edtCodigoTv.Text     := '';
    edtDescricaoTv.Text  := '';
    edtDescricaoTv.SetFocus;

  end;

  if fStatusTela = 'Editar' then
  begin

    DetalhesDaTv;
    ListarProdNaoTv;
    ListarProdNaTv;

  end;

  TabControl.ActiveTab := tabCadTv;

end;

procedure TFrameCadTv.ShowTabListarTv;
begin

  try
    ListarTvCadastrada;

    if lstBoxTvs.Count = 0 then
    begin
      lblSemRegistroTv.Visible := True;
      ControlarBotao(True,False,False);
    end
    else
      ControlarBotao(True,True,True);

    TabControl.ActiveTab := tabListaTv;
  except
    raise

  end;

end;

end.
