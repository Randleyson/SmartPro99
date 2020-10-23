unit uframe_CadTvs;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.Edit, FMX.ListBox,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMX.Ani, FMX.Effects, FMX.Filter.Effects, FMX.TabControl,
  System.Rtti, FMX.Grid.Style, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, FMX.ScrollBox,
  FMX.Grid;

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
    lstBoxProdNaoTv: TListBox;
    btnRemoverProdDaTv: TSpeedButton;
    btnInseriProdNaTv: TSpeedButton;
    lytProdTv: TLayout;
    btnInserirTodoNaTv: TCornerButton;
    btnRemoverTodosDaTv: TCornerButton;
    lytProdNaoTV: TLayout;
    lytProdNaTv: TLayout;
    lytBtnCentral: TLayout;
    lytPesqProdNaoTV: TLayout;
    edtCodbarraNaoTv: TEdit;
    edtDescricaoNaoTv: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    lytPesqProdNaTv: TLayout;
    edtCodbarraProdNaTv: TEdit;
    edtDescricaoProdNaTv: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    lblSemRegistroTv: TLabel;
    lblSemRegistroProdNaotv: TLabel;
    btnPesqProdNaoTv: TButton;
    btnPesqProdNaTv: TButton;
    Rectangle2: TRectangle;
    FillRGBEffect1: TFillRGBEffect;
    Line2: TLine;
    Rectangle3: TRectangle;
    lblTituloDetalhesTv: TLabel;
    Line3: TLine;
    rectDetalheTv: TRectangle;
    lytDadosDetalheTv: TLayout;
    rectEdtiDescricao: TRectangle;
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
    lblSemRegistroProdNaTv: TLabel;
    lstBoxProdNaTv: TListBox;
    rectEdtCod: TRectangle;
    procedure btnFecharClick(Sender: TObject);
    procedure btnAdicionarTvClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarCadTvClick(Sender: TObject);
    procedure btnCancelarCadTvClick(Sender: TObject);
    procedure btnInseriProdNaTvClick(Sender: TObject);
    procedure btnRemoverProdDaTvClick(Sender: TObject);
    procedure btnRemoverTodosDaTvClick(Sender: TObject);
    procedure btnInserirTodoNaTvClick(Sender: TObject);
    procedure btnPesqProdNaoTvClick(Sender: TObject);
    procedure btnPesqProdNaTvClick(Sender: TObject);


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
    procedure AdicionaTv;
    procedure EditaTv;

    procedure ClickBtnGravaTv;
    procedure ClickCancelarCadTv;
    procedure ClickBtnAdicionarProdTv;
    procedure ClickBtnRemoverProdTv;
    procedure ClickBtnExcluirTodosProdDaTv;
    procedure ClickBtnInserTodosProdNaTv;
    procedure ClickBtnPesqProdNaoTv;
    procedure ClickBtnPesqProdNaTv;

    {GERAL}
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

uses ufrm_Principal, Loading, udm_CadTv, ufrm_MensagemInfor, udm_Principal;

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

procedure TFrameCadTv.AdicionaTv;
begin

  try

    fidtv                 := dmCadTv.InsertTv(edtDescricaoTv.Text);
    edtCodigoTv.Text      := IntToStr(fidtv);
    fStatusTela           := 'Editar';

  except
    frmPrincipal.fMensagemErro := 'Erro ao executar AdicionaTv';
    raise

  end;  

end;

procedure TFrameCadTv.btnAdicionarTvClick(Sender: TObject);
begin

  try

    ClickBtnAdicionarTv;

  except
    FrameMsgInfor.CreateFrameMsgInfor(frmPrincipal.fMensagemErro);

  end;


end;

procedure TFrameCadTv.btnCancelarCadTvClick(Sender: TObject);
begin

  try

    ClickCancelarCadTv;

  except
    FrameMsgInfor.CreateFrameMsgInfor(frmPrincipal.fMensagemErro);

  end;

end;

procedure TFrameCadTv.btnEditarClick(Sender: TObject);
begin

  try

    ClickBtnEditarTv;

  except
    FrameMsgInfor.CreateFrameMsgInfor(frmPrincipal.fMensagemErro);

  end;


end;

procedure TFrameCadTv.btnExcluirClick(Sender: TObject);
begin

  try

     ClickBtnExcluirTv;

   except
      FrameMsgInfor.CreateFrameMsgInfor(frmPrincipal.fMensagemErro);

  end;

end;

procedure TFrameCadTv.btnFecharClick(Sender: TObject);
begin

  DestroyFrameCadTv;

end;

procedure TFrameCadTv.btnGravarCadTvClick(Sender: TObject);
begin

  if edtDescricaoTv.Text = '' then
  begin

    FrameMsgInfor.CreateFrameMsgInfor('É nesecario informar o no da TV');
    edtDescricaoTv.SetFocus;
    exit

  end;

  try

    ClickBtnGravaTv;

  except
    FrameMsgInfor.CreateFrameMsgInfor(frmPrincipal.fMensagemErro);

  end;

end;

procedure TFrameCadTv.btnInseriProdNaTvClick(Sender: TObject);
begin

  try

    ClickBtnAdicionarProdTv;

  except
    FrameMsgInfor.CreateFrameMsgInfor(frmPrincipal.fMensagemErro);

  end;

end;


procedure TFrameCadTv.btnInserirTodoNaTvClick(Sender: TObject);
begin

  try

    ClickBtnInserTodosProdNaTv;

  except
    FrameMsgInfor.CreateFrameMsgInfor(frmPrincipal.fMensagemErro);

  end;

end;

procedure TFrameCadTv.btnPesqProdNaoTvClick(Sender: TObject);
begin


  try

    ClickBtnPesqProdNaoTv;

  except
    FrameMsgInfor.CreateFrameMsgInfor(frmPrincipal.fMensagemErro);

  end;

end;

procedure TFrameCadTv.btnPesqProdNaTvClick(Sender: TObject);
begin

  try

    ClickBtnPesqProdNaTv;

  except
    FrameMsgInfor.CreateFrameMsgInfor(frmPrincipal.fMensagemErro);

  end;

end;

procedure TFrameCadTv.btnRemoverProdDaTvClick(Sender: TObject);
begin

  try

    ClickBtnRemoverProdTv;

  except
    FrameMsgInfor.CreateFrameMsgInfor(frmPrincipal.fMensagemErro);

  end;

end;

procedure TFrameCadTv.btnRemoverTodosDaTvClick(Sender: TObject);
begin

  try

    ClickBtnExcluirTodosProdDaTv;

  except
    FrameMsgInfor.CreateFrameMsgInfor(frmPrincipal.fMensagemErro);

  end;

end;

procedure TFrameCadTv.ClickBtnAdicionarProdTv;
var
  vCodBarra: String;
begin

  try

    if edtDescricaoTv.Text = '' then
    begin
    
      FrameMsgInfor.CreateFrameMsgInfor('Informe o nome da TV');
      exit
      
    end;

    if lstBoxProdNaoTV.ItemIndex = -1 then
    begin

      FrameMsgInfor.CreateFrameMsgInfor('Selecione o produto a ser adicionado na Tv');
      exit;

    end;

    if fStatusTela = 'Adicionar' then
    AdicionaTv;  
    
    vCodBarra := lstBoxProdNaoTV.ListItems[lstBoxProdNaoTV.ItemIndex].TagString;

    {Adiciona produto no FmentProdNaTv}
    dmCadTv.FMentProdNaoTv.Filter := 'codbarra = '+ vCodBarra;
    dmCadTv.FMentProdNaoTv.First;
    dmCadTv.FMentProdNaTv.Insert;
    dmCadTv.FMentProdNaTvCODBARRA.Value          := dmCadTv.FMentProdNaoTvCODBARRA.AsString;
    dmCadTv.FMentProdNaTvDESCRICAO.Value         := dmCadTv.FMentProdNaoTvDESCRICAO.AsString;
    dmCadTv.FMentProdNaTvVRVENDA.Value           := dmCadTv.FMentProdNaoTvVRVENDA.AsString;
    dmCadTv.FMentProdNaTvDESCRICAOALTERADA.Value := dmCadTv.FMentProdNaoTvDESCRICAOALTERADA.AsString;
    dmCadTv.FMentProdNaTvEXISTENOARQ.Value       := dmCadTv.FMentProdNaoTvEXISTENOARQ.AsString;
    dmCadTv.FMentProdNaTv.Post;
    dmCadTv.FMentProdNaTv.Filtered := False;
    ListarProdNaTv;

    {Remove Produto do FmentProdNaoTv}
    dmCadTv.FMentProdNaoTv.Delete;
    ListarProdNaoTv;

    {Adiciona produto na FmentTabProdTv}
    dmCadTv.FMentTabProdTv.Insert;
    dmCadTv.FMentTabProdTvCODBARRA.Value := vCodBarra;
    dmCadTv.FMentTabProdTvIDTV.Value := fidtv;
    dmCadTv.FMentTabProdTv.post;

  except
    frmPrincipal.FMensagemErro := 'Erro ao executar o ClickBtnAdicionarProdTv';
    raise

  end;

end;

procedure TFrameCadTv.ClickBtnAdicionarTv;
begin

  try

    fStatusTela          := 'Adicionar';
    fidtv                := 0;
    ShowTabCadTv;

  except
    raise;

  end;

end;

procedure TFrameCadTv.ClickBtnEditarTv;
begin

  if lstBoxTvs.ItemIndex = -1 then
  begin

    FrameMsgInfor.CreateFrameMsgInfor('Selciona a Tv a ser editar');
    exit

  end;

  try

    fStatusTela := 'Editar';
    fidtv       := StrToInt(lstBoxTvs.ListItems[lstBoxTvs.ItemIndex].TagString);
    ShowTabCadTv;

  except
    raise;

  end;

end;

procedure TFrameCadTv.ClickBtnExcluirTodosProdDaTv;
begin

  try

    if edtDescricaoTv.Text = '' then
    begin
    
      FrameMsgInfor.CreateFrameMsgInfor('Informe o nome da TV');
      exit
      
    end;
    
    if fStatusTela = 'Adicionar' then
    AdicionaTv; 
    
    if lstBoxProdNaTv.Count > 0 then
    begin

      {Adicionar no FMentProdNaoTv}
      dmCadTv.FMentProdNaTv.Filtered := False;
      dmCadTv.FMentProdNaTv.First;
      while not dmCadTv.FMentProdNaTv.eof do
      begin

        dmCadTv.FMentProdNaoTv.Insert;
        dmCadTv.FMentProdNaoTvCODBARRA.Value          := dmCadTv.FMentProdNaTvCODBARRA.AsString;
        dmCadTv.FMentProdNaoTvDESCRICAO.Value         := dmCadTv.FMentProdNaTvDESCRICAO.AsString;
        dmCadTv.FMentProdNaoTvVRVENDA.Value           := dmCadTv.FMentProdNaTvVRVENDA.AsString;
        dmCadTv.FMentProdNaoTvDESCRICAOALTERADA.Value := dmCadTv.FMentProdNaTvDESCRICAOALTERADA.AsString;
        dmCadTv.FMentProdNaoTvEXISTENOARQ.Value       := dmCadTv.FMentProdNaTvEXISTENOARQ.AsString;
        dmCadTv.FMentProdNaoTv.Post;
        dmCadTv.FMentProdNaTv.Next;

      end;

      dmCadTv.FMentProdNaoTv.Filtered := false;
      ListarProdNaoTv;

      {Remover do FMentProdNaTv}
      dmCadTv.FMentProdNaTv.EmptyDataSet;
      dmCadTv.FMentProdNaTv.Filtered := False;
      ListarProdNaTv;

      {Remover do FMentProdTv}
      dmCadTv.FMentTabProdTv.EmptyDataSet;

    end;

  except
    raise

  end;

end;

procedure TFrameCadTv.ClickBtnExcluirTv;
begin

  try

    if lstBoxTvs.Index = -1 then
    begin

      FrameMsgInfor.CreateFrameMsgInfor('Selecione a Tv a ser excluida');
      exit

    end;

    fIdTv := StrToInt(lstBoxTvs.ListItems[lstBoxTvs.ItemIndex].TagString);
    dmCadTv.DeleteTV(fIdTv);
    FrameMsgInfor.CreateFrameMsgInfor('Tv excuida com exito.');
    ShowTabListarTv;

  except
    raise;

  end;

end;

procedure TFrameCadTv.ClickBtnGravaTv;
begin

  try

    if fStatusTela = 'Editar' then
    begin

      dmCadTv.UpdateTv(edtDescricaoTv.Text,fidtv);
      dmCadTv.MarcaProdTvExcluir(fidtv);
      DmPrincipal.CopyDataSet(dmCadTv.FMentTabProdTv,dmCadTv.FQryTabProdTv);
      dmCadTv.RemoverProdTvExcluido;

      ShowTabListarTv;

    end;

    if fStatusTela = 'Adicionar' then
    begin
      AdicionaTv;
    end;

    FrameMsgInfor.CreateFrameMsgInfor('Alteracao salvada com exito.');

  except
    raise;

  end;
end;

procedure TFrameCadTv.ClickBtnInserTodosProdNaTv;
begin

  try

    if edtDescricaoTv.Text = '' then
    begin
    
      FrameMsgInfor.CreateFrameMsgInfor('Informe o nome da TV');
      exit
      
    end;

    if fStatusTela = 'Adicionar' then
    AdicionaTv; 

    if lstBoxProdNaoTv.Count > 0 then
    begin

      {Adicionar todos produtos na FMentProdNaTv}
      dmCadTv.FMentProdNaoTv.Filtered := False;
      dmCadTv.FMentProdNaoTv.First;
      while not dmCadTv.FMentProdNaoTv.Eof do
      begin

        dmCadTv.FMentProdNaTv.Insert;
        dmCadTv.FMentProdNaTvCODBARRA.Value          := dmCadTv.FMentProdNaoTvCODBARRA.AsString;
        dmCadTv.FMentProdNaTvDESCRICAO.Value         := dmCadTv.FMentProdNaoTvDESCRICAO.AsString;
        dmCadTv.FMentProdNaTvVRVENDA.Value           := dmCadTv.FMentProdNaoTvVRVENDA.AsString;
        dmCadTv.FMentProdNaTvDESCRICAOALTERADA.Value := dmCadTv.FMentProdNaoTvEXISTENOARQ.AsString;
        dmCadTv.FMentProdNaTvEXISTENOARQ.Value       := dmCadTv.FMentProdNaTvEXISTENOARQ.AsString;
        dmCadTv.FMentProdNaTv.Post;
        dmCadTv.FMentProdNaoTv.Next;
      end;
      dmCadTv.FMentProdNaTv.Filtered := False;
      ListarProdNaTv;

      {Remover todos os produtos da FMentProdNaoTv}
      dmCadTv.FMentProdNaoTv.EmptyDataSet;
      dmCadTv.FMentProdNaoTv.Filtered := false;
      ListarProdNaoTv;

      {Adicionar todos os produtos na FMentProdTv}
      dmCadTv.FMentProdNaTv.Filtered := False;
      dmCadTv.FMentProdNaTv.First;
      while not dmCadTv.FMentProdNaTv.Eof do
      begin

        dmCadTv.FMentTabProdTv.Insert;
        dmCadTv.FMentTabProdTvCODBARRA.Value := dmCadTv.FMentProdNaTvCODBARRA.AsString;
        dmCadTv.FMentTabProdTvIDTV.Value := fidtv;
        dmCadTv.FMentTabProdTv.post;
        dmCadTv.FMentProdNaTv.Next;

      end;

    end;

  except
    frmPrincipal.FMensagemErro := 'Erro ao executar o ClickBtnInserTodosProdNaTv';
    raise

  end;

end;

procedure TFrameCadTv.ClickBtnPesqProdNaoTv;
begin

  try

    dmCadTv.FMentProdNaoTv.Filter := 'codbarra like ''%'+edtCodbarraNaoTv.Text+'%'''+
                                     ' and descricao like ''%'+ UpperCase(edtDescricaoNaoTv.Text)+'%''';
    dmCadTv.FMentProdNaoTv.Filtered := True;

    ListarProdNaoTv;

  except
    frmPrincipal.FMensagemErro := 'Erro ao executar o ClickBtnPesqProdNaoTv';
    raise

  end;

end;

procedure TFrameCadTv.ClickBtnPesqProdNaTv;
begin

  try

    dmCadTv.FMentProdNaTv.Filter := 'codbarra like ''%'+edtCodbarraProdNaTv.Text+'%'''+
                                    ' and descricao like ''%'+ UpperCase(edtDescricaoProdNaTv.Text)+'%''';
    dmCadTv.FMentProdNaTv.Filtered := True;

    ListarProdNaTv;

  except
    frmPrincipal.FMensagemErro := 'Erro ao executar o ClickBtnPesqProdNaTv';
    raise

  end;

end;

procedure TFrameCadTv.ClickBtnRemoverProdTv;
var
  vCodBarra: String;
begin

  try

    if edtDescricaoTv.Text = '' then
    begin
    
      FrameMsgInfor.CreateFrameMsgInfor('Informe o nome da TV');
      exit
      
    end;

    if lstBoxProdNaTv.ItemIndex = -1 then
    begin

      FrameMsgInfor.CreateFrameMsgInfor('Selecione o produto a ser removido da Tv');
      exit

    end;

    if fStatusTela = 'Adicionar' then
    AdicionaTv;  

    vCodBarra := lstBoxProdNaTv.ListItems[lstBoxProdNaTv.ItemIndex].TagString;

    {Adiciona FMentProdNaoTv}
    dmCadTv.FMentProdNaTv.Filter   := 'codbarra = '+ vCodBarra;
    dmCadTv.FMentProdNaTv.Filtered := True;
    dmCadTv.FMentProdNaTv.First;
    dmCadTv.FMentProdNaoTv.Insert;
    dmCadTv.FMentProdNaoTvCODBARRA.Value          := dmCadTv.FMentProdNaTvCODBARRA.AsString;
    dmCadTv.FMentProdNaoTvDESCRICAO.Value         := dmCadTv.FMentProdNaTvDESCRICAO.AsString;
    dmCadTv.FMentProdNaoTvVRVENDA.Value           := dmCadTv.FMentProdNaTvVRVENDA.AsString;
    dmCadTv.FMentProdNaoTvDESCRICAOALTERADA.Value := dmCadTv.FMentProdNaTvDESCRICAOALTERADA.AsString;
    dmCadTv.FMentProdNaoTvEXISTENOARQ.Value       := dmCadTv.FMentProdNaTvEXISTENOARQ.AsString;
    dmCadTv.FMentProdNaoTv.Post;
    ListarProdNaoTv;

    {Remove do FMentProdNaTv}
    dmCadTv.FMentProdNaTv.Delete;
    dmCadTv.FMentProdNaTv.Filtered := False;
    ListarProdNaTv;

    {Remove da FMentProdTv}
    dmCadTv.FMentTabProdTv.RecordCount;
    dmCadTv.FMentTabProdTv.Filter   := 'codbarra = '+ vCodBarra;
    dmCadTv.FMentTabProdTv.Filtered := True;
    dmCadTv.FMentTabProdTv.First;
    dmCadTv.FMentTabProdTv.Delete;
    dmCadTv.FMentTabProdTv.Filtered := False;
    dmCadTv.FMentTabProdTv.RecordCount;

  except
    raise

  end;

end;

procedure TFrameCadTv.ClickCancelarCadTv;
begin

  try

    dmCadTv.FQryProdutos.Close;
    dmCadTv.FQryTabProdTv.Close;
    dmCadTv.FMentProdNaoTv.Close;
    dmCadTv.FMentProdNaTv.Close;
    dmCadTv.FMentTabProdTv.Close;

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

procedure TFrameCadTv.CreateFrameCadTv;
begin

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
    FrameMsgInfor.CreateFrameMsgInfor(frmPrincipal.fMensagemErro);

  end;

end;

procedure TFrameCadTv.DestroyFrameCadTv;
begin

  dmCadTv.Destroy;
  FrameCadTv.Visible := False;
  FrameCadTv         := nil;

end;

procedure TFrameCadTv.DetalhesDaTv;
begin

  try

    dmCadTv.FMenTv.Filter   := 'Idtv = ' + IntToStr(fIdTv);
    dmCadTv.FMenTv.Filtered := True;
    dmCadTv.FMenTv.First;
    edtCodigoTv.Text        := dmCadTv.FMenTv.FieldByName('IDTV').AsString;
    edtDescricaoTv.Text     := dmCadTv.FMenTv.FieldByName('DESCRICAOTV').AsString;

  except
    raise;

  end;
end;

procedure TFrameCadTv.EditaTv;
begin

end;

procedure TFrameCadTv.ListarProdNaoTv;
begin

  try

    lblSemRegistroProdNaotv.Visible := True;
    lstBoxProdNaoTV.Items.Clear;
    if dmCadTv.FMentProdNaoTv.RecordCount <> 0 then
    begin

      lstBoxProdNaoTV.BeginUpdate;
      dmCadTv.FMentProdNaoTv.First;
      while not dmCadTv.FMentProdNaoTv.eof do
      begin
        AddItemListBox(dmCadTv.FMentProdNaoTv.FieldByName('CODBARRA').AsString,
                       dmCadTv.FMentProdNaoTv.FieldByName('DESCRICAO').AsString,
                       dmCadTv.FMentProdNaoTv.FieldByName('VRVENDA').AsString,
                       lstBoxProdNaoTV,lblSemRegistroProdNaotv);

        dmCadTv.FMentProdNaoTv.Next;
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

    lblSemRegistroProdNaTv.Visible := True;
    lstBoxProdNaTv.Items.Clear;
    if dmCadTv.FMentProdNaTv.RecordCount <> 0 then
    begin

      dmCadTv.FMentProdNaTv.First;
      lstBoxProdNaTv.BeginUpdate;
      while not dmCadTv.FMentProdNaTv.eof do
      begin

        AddItemListBox(dmCadTv.FMentProdNaTv.FieldByName('CODBARRA').AsString,
                       dmCadTv.FMentProdNaTv.FieldByName('DESCRICAO').AsString,
                       dmCadTv.FMentProdNaTv.FieldByName('VRVENDA').AsString,
                       lstBoxProdNaTv,lblSemRegistroProdNaTv);

        dmCadTv.FMentProdNaTv.Next;

      end;

      lstBoxProdNaTv.EndUpdate;
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

    dmCadTv.RecebeTv;

    lstBoxTvs.Items.Clear;
    if dmCadTv.FMenTv.RecordCount <> 0  then
    begin
      dmCadTv.FMenTv.First;
      lstBoxTvs.BeginUpdate;
      vPriRegestro := True;
      while not dmCadTv.FMenTv.Eof do
      begin

        vLstBoxItems              := TListBoxItem.Create(lstBoxTvs);
        vLstBoxItems.Text         := '';
        vLstBoxItems.Height       := 30;

        vLstBoxItems.TagString    := dmCadTv.FMenTv.FieldByName('IDTV').AsString;
        vLstBoxItems.Text         := dmCadTv.FMenTv.FieldByName('IDTV').AsString+
                                     ' - '+ dmCadTv.FMenTv.FieldByName('DESCRICAOTV').AsString;
        vLstBoxItems.Parent       := lstBoxTvs;

        if vPriRegestro then
        begin

          vLstBoxItems.IsSelected := True;
          vPriRegestro            := False;

        end;

        dmCadTv.FMenTv.Next;
      end;

      lstBoxTvs.EndUpdate;

      lblSemRegistroTv.Visible := False;
      if lstBoxTvs.Count = 0 then
      lblSemRegistroTv.Visible := True;


    end;

  except
    frmPrincipal.fMensagemErro := 'Não foi possivel listar Tv cadastrada';
    raise

  end;
end;

procedure TFrameCadTv.ShowTabCadTv;
begin

  try

    if fStatusTela = 'Adicionar' then
    begin

      edtCodigoTv.Text      := '';
      edtDescricaoTv.Text   := '';


    end;

    if fStatusTela = 'Editar' then
    begin

      DetalhesDaTv;

    end;

    dmCadTv.RecebeProdNaoTv(fidtv);
    dmCadTv.FMentProdNaoTv.Filtered := false;
    ListarProdNaoTv;

    dmCadTv.RecebeProdNaTv(fidtv);
    dmCadTv.FMentProdNaTv.Filtered := False;
    ListarProdNaTv;

    dmCadTv.RecebeTabProdTv(fidtv);

    edtDescricaoTv.SetFocus;
    TabControl.ActiveTab := tabCadTv;

  except
    raise
  end;

end;

procedure TFrameCadTv.ShowTabListarTv;
begin

  try

    ListarTvCadastrada;

    if lstBoxTvs.Count = 0 then
    begin

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
