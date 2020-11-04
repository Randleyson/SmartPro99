unit SmartPro99.View.CadTv;

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
  TViewCadTvs = class(TFrame)
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
  ViewCadTvs : TViewCadTvs;

implementation

{$R *.fmx}

uses
  SmartPro99.View.Principal, SmartPro99.Model.Tvs,
  SmartPro99.Controlle.Message,SmartPro99.Controlle.Loading,
  SmartPro99.Model.Principal ;

{ TFrame1 }


{ TFrameCadTv }

procedure TViewCadTvs.AddItemListBox(pCodbarra, pDescricao, pVrVenda: String;
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
    ViewPrincipal.fMensagemErro := 'Não foi possivel adicionar o frame no lisBox';
    raise
  end;

end;

procedure TViewCadTvs.AdicionaTv;
begin

  try

    fidtv                 := ModelTvs.InsertTv(edtDescricaoTv.Text);
    edtCodigoTv.Text      := IntToStr(fidtv);
    fStatusTela           := 'Editar';

  except
    ViewPrincipal.fMensagemErro := 'Erro ao executar AdicionaTv';
    raise

  end;  

end;

procedure TViewCadTvs.btnAdicionarTvClick(Sender: TObject);
begin

  try

    ClickBtnAdicionarTv;

  except
  on e: Exception do
    begin
		TMessage.MessagemPopUp(ViewPrincipal,'Erro : '+ ViewPrincipal.fMensagemErro + e.Message);
    end;
  end;


end;

procedure TViewCadTvs.btnCancelarCadTvClick(Sender: TObject);
begin

  try

    ClickCancelarCadTv;

  except
  on e: Exception do
    begin
		TMessage.MessagemPopUp(ViewPrincipal,'Erro : '+ ViewPrincipal.fMensagemErro + e.Message);
    end;

  end;

end;

procedure TViewCadTvs.btnEditarClick(Sender: TObject);
begin

  if lstBoxTvs.ItemIndex = -1 then
  begin
    TMessage.MessagemPopUp(ViewPrincipal,'Selciona a Tv a ser editar');
    exit
  end;

  try

    ClickBtnEditarTv;

  except
  on e: Exception do
    begin
		TMessage.MessagemPopUp(ViewPrincipal,'Erro : '+ ViewPrincipal.fMensagemErro + e.Message);
    end;
  end;

end;

procedure TViewCadTvs.btnExcluirClick(Sender: TObject);
begin

  try

    if lstBoxTvs.Index = -1 then
    begin

      TMessage.MessagemPopUp(ViewPrincipal,'Selecione a Tv a ser excluida');
      exit
    end;

    if TMessage.MessagemDlg(ViewPrincipal,'Deseja excluir a TV ?') then
    ClickBtnExcluirTv;

  except
  on e: Exception do
    begin
		  TMessage.MessagemPopUp(ViewPrincipal,'Erro : '+ ViewPrincipal.fMensagemErro + e.Message);
    end;
  end;

end;

procedure TViewCadTvs.btnFecharClick(Sender: TObject);
begin

  try

    DestroyFrameCadTv;

  except
  on e: Exception do
    begin
		TMessage.MessagemPopUp(ViewPrincipal,'Erro : '+ ViewPrincipal.fMensagemErro + e.Message);
    end;
  end;


end;

procedure TViewCadTvs.btnGravarCadTvClick(Sender: TObject);
begin

  if edtDescricaoTv.Text = '' then
  begin
    TMessage.MessagemPopUp(ViewPrincipal,'É nesecario informar o no da TV');
    edtDescricaoTv.SetFocus;
    exit
  end;

  try

    ClickBtnGravaTv;

  except
  on e: Exception do
    begin
		TMessage.MessagemPopUp(ViewPrincipal,'Erro : '+ ViewPrincipal.fMensagemErro + e.Message);
    end;

  end;

end;

procedure TViewCadTvs.btnInseriProdNaTvClick(Sender: TObject);
begin

  try

    if edtDescricaoTv.Text = '' then
    begin
      TMessage.MessagemPopUp(ViewPrincipal,'Informe o nome da TV');
      exit
    end;

    if lstBoxProdNaoTV.ItemIndex = -1 then
    begin
      TMessage.MessagemPopUp(ViewPrincipal,'Selecione o produto a ser adicionado na Tv');
      exit;
    end;

    ClickBtnAdicionarProdTv;

  except
  on e: Exception do
    begin
		TMessage.MessagemPopUp(ViewPrincipal,'Erro : '+ ViewPrincipal.fMensagemErro + e.Message);
    end;

  end;

end;


procedure TViewCadTvs.btnInserirTodoNaTvClick(Sender: TObject);
begin

  try
    if edtDescricaoTv.Text = '' then
    begin
      TMessage.MessagemPopUp(ViewPrincipal,'Informe o nome da TV');
      exit
    end;

    ClickBtnInserTodosProdNaTv;

  except
  on e: Exception do
    begin
		TMessage.MessagemPopUp(ViewPrincipal,'Erro : '+ ViewPrincipal.fMensagemErro + e.Message);
    end;

  end;

end;

procedure TViewCadTvs.btnPesqProdNaoTvClick(Sender: TObject);
begin


  try

    ClickBtnPesqProdNaoTv;

  except
  on e: Exception do
    begin
		  TMessage.MessagemPopUp(ViewPrincipal,'Erro : '+ ViewPrincipal.fMensagemErro + e.Message);
    end;
  end;

end;

procedure TViewCadTvs.btnPesqProdNaTvClick(Sender: TObject);
begin

  try

    ClickBtnPesqProdNaTv;

  except
  on e: Exception do
    begin
		  TMessage.MessagemPopUp(ViewPrincipal,'Erro : '+ ViewPrincipal.fMensagemErro + e.Message);
    end;


  end;

end;

procedure TViewCadTvs.btnRemoverProdDaTvClick(Sender: TObject);
begin

  try

    if edtDescricaoTv.Text = '' then
    begin
      TMessage.MessagemPopUp(ViewPrincipal,'Informe o nome da TV');
      exit
    end;

    if lstBoxProdNaTv.ItemIndex = -1 then
    begin
      TMessage.MessagemPopUp(ViewPrincipal,'Selecione o produto a ser removido da Tv');
      exit
    end;

    ClickBtnRemoverProdTv;

  except
  on e: Exception do
    begin
		TMessage.MessagemPopUp(ViewPrincipal,'Erro : '+ ViewPrincipal.fMensagemErro + e.Message);
    end;

  end;

end;

procedure TViewCadTvs.btnRemoverTodosDaTvClick(Sender: TObject);
begin

  try

    if edtDescricaoTv.Text = '' then
    begin
      TMessage.MessagemPopUp(ViewPrincipal,'Informe o nome da TV');
      exit
    end;

    ClickBtnExcluirTodosProdDaTv;

  except
  on e: Exception do
    begin
		TMessage.MessagemPopUp(ViewPrincipal,'Erro : '+ ViewPrincipal.fMensagemErro + e.Message);
    end;

  end;

end;

procedure TViewCadTvs.ClickBtnAdicionarProdTv;
var
  vCodBarra: String;
begin

  try

    if fStatusTela = 'Adicionar' then
    AdicionaTv;
    
    vCodBarra := lstBoxProdNaoTV.ListItems[lstBoxProdNaoTV.ItemIndex].TagString;

    {Adiciona produto no FmentProdNaTv}
    ModelTvs.FMentProdNaoTv.Filter := 'codbarra = '+ vCodBarra;
    ModelTvs.FMentProdNaoTv.First;
    ModelTvs.FMentProdNaTv.Insert;
    ModelTvs.FMentProdNaTvCODBARRA.Value          := ModelTvs.FMentProdNaoTvCODBARRA.AsString;
    ModelTvs.FMentProdNaTvDESCRICAO.Value         := ModelTvs.FMentProdNaoTvDESCRICAO.AsString;
    ModelTvs.FMentProdNaTvVRVENDA.Value           := ModelTvs.FMentProdNaoTvVRVENDA.AsString;
    ModelTvs.FMentProdNaTvDESCRICAOALTERADA.Value := ModelTvs.FMentProdNaoTvDESCRICAOALTERADA.AsString;
    ModelTvs.FMentProdNaTvEXISTENOARQ.Value       := ModelTvs.FMentProdNaoTvEXISTENOARQ.AsString;
    ModelTvs.FMentProdNaTv.Post;
    ModelTvs.FMentProdNaTv.Filtered := False;
    ListarProdNaTv;

    {Remove Produto do FmentProdNaoTv}
    ModelTvs.FMentProdNaoTv.Delete;
    ListarProdNaoTv;

    {Adiciona produto na FmentTabProdTv}
    ModelTvs.FMentTabProdTv.Insert;
    ModelTvs.FMentTabProdTvCODBARRA.Value := vCodBarra;
    ModelTvs.FMentTabProdTvIDTV.Value := fidtv;
    ModelTvs.FMentTabProdTv.post;

  except
    ViewPrincipal.FMensagemErro := 'Erro ao executar o ClickBtnAdicionarProdTv';
    raise

  end;

end;

procedure TViewCadTvs.ClickBtnAdicionarTv;
begin

  try

    fStatusTela          := 'Adicionar';
    fidtv                := 0;
    ShowTabCadTv;

  except
    raise;

  end;

end;

procedure TViewCadTvs.ClickBtnEditarTv;
begin

  try

    fStatusTela := 'Editar';
    fidtv       := StrToInt(lstBoxTvs.ListItems[lstBoxTvs.ItemIndex].TagString);
    ShowTabCadTv;

  except
    raise;

  end;

end;

procedure TViewCadTvs.ClickBtnExcluirTodosProdDaTv;
begin

  try

    if fStatusTela = 'Adicionar' then
    AdicionaTv; 
    
    if lstBoxProdNaTv.Count > 0 then
    begin

      {Adicionar no FMentProdNaoTv}
      ModelTvs.FMentProdNaTv.Filtered := False;
      ModelTvs.FMentProdNaTv.First;
      while not ModelTvs.FMentProdNaTv.eof do
      begin

        ModelTvs.FMentProdNaoTv.Insert;
        ModelTvs.FMentProdNaoTvCODBARRA.Value          := ModelTvs.FMentProdNaTvCODBARRA.AsString;
        ModelTvs.FMentProdNaoTvDESCRICAO.Value         := ModelTvs.FMentProdNaTvDESCRICAO.AsString;
        ModelTvs.FMentProdNaoTvVRVENDA.Value           := ModelTvs.FMentProdNaTvVRVENDA.AsString;
        ModelTvs.FMentProdNaoTvDESCRICAOALTERADA.Value := ModelTvs.FMentProdNaTvDESCRICAOALTERADA.AsString;
        ModelTvs.FMentProdNaoTvEXISTENOARQ.Value       := ModelTvs.FMentProdNaTvEXISTENOARQ.AsString;
        ModelTvs.FMentProdNaoTv.Post;
        ModelTvs.FMentProdNaTv.Next;

      end;

      ModelTvs.FMentProdNaoTv.Filtered := false;
      ListarProdNaoTv;

      {Remover do FMentProdNaTv}
      ModelTvs.FMentProdNaTv.EmptyDataSet;
      ModelTvs.FMentProdNaTv.Filtered := False;
      ListarProdNaTv;

      {Remover do FMentProdTv}
      ModelTvs.FMentTabProdTv.EmptyDataSet;

    end;

  except
    raise

  end;

end;

procedure TViewCadTvs.ClickBtnExcluirTv;
begin

    ViewPrincipal.FMensagemAguarde := 'Aguarde... Carregando a Tela';
    TLoading.Show(ViewPrincipal,ViewPrincipal.FMensagemAguarde);

    TThread.CreateAnonymousThread(procedure
    begin
      try
        try

          fIdTv := StrToInt(lstBoxTvs.ListItems[lstBoxTvs.ItemIndex].TagString);
          ModelTvs.DeleteTV(fIdTv);
          ShowTabListarTv;

        except
          raise
        end;

      finally
      TThread.Synchronize(nil,procedure
        begin
          TLoading.Hide;
          TMessage.MessagemPopUp(ViewPrincipal,'Tv excuida com Exito');
        end);
      end;

    end).Start;

end;

procedure TViewCadTvs.ClickBtnGravaTv;
begin

  try

    if fStatusTela = 'Editar' then
    begin

      ModelTvs.UpdateTv(edtDescricaoTv.Text,fidtv);
      ModelTvs.MarcaProdTvExcluir(fidtv);
      ModelPrincipal.CopyDataSet(ModelTvs.FMentTabProdTv,ModelTvs.FQryTabProdTv);
      ModelTvs.RemoverProdTvExcluido;

      ShowTabListarTv;

    end;

    if fStatusTela = 'Adicionar' then
    begin
      AdicionaTv;
    end;

    TMessage.MessagemPopUp(ViewPrincipal,'Alteração salva com Exito');

  except
    raise;

  end;
end;

procedure TViewCadTvs.ClickBtnInserTodosProdNaTv;
begin

  try

    if fStatusTela = 'Adicionar' then
    AdicionaTv; 

    if lstBoxProdNaoTv.Count > 0 then
    begin

      {Adicionar todos produtos na FMentProdNaTv}
      ModelTvs.FMentProdNaoTv.Filtered := False;
      ModelTvs.FMentProdNaoTv.First;
      while not ModelTvs.FMentProdNaoTv.Eof do
      begin

        ModelTvs.FMentProdNaTv.Insert;
        ModelTvs.FMentProdNaTvCODBARRA.Value          := ModelTvs.FMentProdNaoTvCODBARRA.AsString;
        ModelTvs.FMentProdNaTvDESCRICAO.Value         := ModelTvs.FMentProdNaoTvDESCRICAO.AsString;
        ModelTvs.FMentProdNaTvVRVENDA.Value           := ModelTvs.FMentProdNaoTvVRVENDA.AsString;
        ModelTvs.FMentProdNaTvDESCRICAOALTERADA.Value := ModelTvs.FMentProdNaoTvEXISTENOARQ.AsString;
        ModelTvs.FMentProdNaTvEXISTENOARQ.Value       := ModelTvs.FMentProdNaTvEXISTENOARQ.AsString;
        ModelTvs.FMentProdNaTv.Post;
        ModelTvs.FMentProdNaoTv.Next;
      end;
      ModelTvs.FMentProdNaTv.Filtered := False;
      ListarProdNaTv;

      {Remover todos os produtos da FMentProdNaoTv}
      ModelTvs.FMentProdNaoTv.EmptyDataSet;
      ModelTvs.FMentProdNaoTv.Filtered := false;
      ListarProdNaoTv;

      {Adicionar todos os produtos na FMentProdTv}
      ModelTvs.FMentProdNaTv.Filtered := False;
      ModelTvs.FMentProdNaTv.First;
      while not ModelTvs.FMentProdNaTv.Eof do
      begin

        ModelTvs.FMentTabProdTv.Insert;
        ModelTvs.FMentTabProdTvCODBARRA.Value := ModelTvs.FMentProdNaTvCODBARRA.AsString;
        ModelTvs.FMentTabProdTvIDTV.Value := fidtv;
        ModelTvs.FMentTabProdTv.post;
        ModelTvs.FMentProdNaTv.Next;

      end;

    end;

  except
    ViewPrincipal.FMensagemErro := 'Erro ao executar o ClickBtnInserTodosProdNaTv';
    raise

  end;

end;

procedure TViewCadTvs.ClickBtnPesqProdNaoTv;
begin

  try

    ModelTvs.FMentProdNaoTv.Filter := 'codbarra like ''%'+edtCodbarraNaoTv.Text+'%'''+
                                     ' and descricao like ''%'+ UpperCase(edtDescricaoNaoTv.Text)+'%''';
    ModelTvs.FMentProdNaoTv.Filtered := True;

    ListarProdNaoTv;

  except
    ViewPrincipal.FMensagemErro := 'Erro ao executar o ClickBtnPesqProdNaoTv';
    raise

  end;

end;

procedure TViewCadTvs.ClickBtnPesqProdNaTv;
begin

  try

    ModelTvs.FMentProdNaTv.Filter := 'codbarra like ''%'+edtCodbarraProdNaTv.Text+'%'''+
                                    ' and descricao like ''%'+ UpperCase(edtDescricaoProdNaTv.Text)+'%''';
    ModelTvs.FMentProdNaTv.Filtered := True;

    ListarProdNaTv;

  except
    ViewPrincipal.FMensagemErro := 'Erro ao executar o ClickBtnPesqProdNaTv';
    raise

  end;

end;

procedure TViewCadTvs.ClickBtnRemoverProdTv;
var
  vCodBarra: String;
begin

  try

    if fStatusTela = 'Adicionar' then
    AdicionaTv;  

    vCodBarra := lstBoxProdNaTv.ListItems[lstBoxProdNaTv.ItemIndex].TagString;

    {Adiciona FMentProdNaoTv}
    ModelTvs.FMentProdNaTv.Filter   := 'codbarra = '+ vCodBarra;
    ModelTvs.FMentProdNaTv.Filtered := True;
    ModelTvs.FMentProdNaTv.First;
    ModelTvs.FMentProdNaoTv.Insert;
    ModelTvs.FMentProdNaoTvCODBARRA.Value          := ModelTvs.FMentProdNaTvCODBARRA.AsString;
    ModelTvs.FMentProdNaoTvDESCRICAO.Value         := ModelTvs.FMentProdNaTvDESCRICAO.AsString;
    ModelTvs.FMentProdNaoTvVRVENDA.Value           := ModelTvs.FMentProdNaTvVRVENDA.AsString;
    ModelTvs.FMentProdNaoTvDESCRICAOALTERADA.Value := ModelTvs.FMentProdNaTvDESCRICAOALTERADA.AsString;
    ModelTvs.FMentProdNaoTvEXISTENOARQ.Value       := ModelTvs.FMentProdNaTvEXISTENOARQ.AsString;
    ModelTvs.FMentProdNaoTv.Post;
    ListarProdNaoTv;

    {Remove do FMentProdNaTv}
    ModelTvs.FMentProdNaTv.Delete;
    ModelTvs.FMentProdNaTv.Filtered := False;
    ListarProdNaTv;

    {Remove da FMentProdTv}
    ModelTvs.FMentTabProdTv.RecordCount;
    ModelTvs.FMentTabProdTv.Filter   := 'codbarra = '+ vCodBarra;
    ModelTvs.FMentTabProdTv.Filtered := True;
    ModelTvs.FMentTabProdTv.First;
    ModelTvs.FMentTabProdTv.Delete;
    ModelTvs.FMentTabProdTv.Filtered := False;
    ModelTvs.FMentTabProdTv.RecordCount;

  except
    raise

  end;

end;

procedure TViewCadTvs.ClickCancelarCadTv;
begin

  try

    ModelTvs.FQryProdutos.Close;
    ModelTvs.FQryTabProdTv.Close;
    ModelTvs.FMentProdNaoTv.Close;
    ModelTvs.FMentProdNaTv.Close;
    ModelTvs.FMentTabProdTv.Close;

    ShowTabListarTv;

  except
    raise;

  end;

end;

procedure TViewCadTvs.ControlarBotao(pBtnAdicionar, pBtnEdtitar, pExcluir: Boolean);
begin

  btnAdicionarTv.Enabled := pBtnAdicionar;
  btnEditar.Enabled      := pBtnEdtitar;
  btnExcluir.Enabled     := pExcluir;

end;

procedure TViewCadTvs.CreateFrameCadTv;
begin

  try

    if not assigned(ViewCadTvs) then
    ViewCadTvs := TViewCadTvs.Create(self);

    with ViewCadTvs do
    begin

      Name      := 'FrameCadTv';
      Parent    := ViewPrincipal;

      ModelTvs := TModelTvs.Create(self);

      ShowTabListarTv;
    end;

  except
  on e: Exception do
    begin

      DestroyFrameCadTv;
      TMessage.MessagemPopUp(ViewPrincipal,'Erro : '+ ViewPrincipal.fMensagemErro + e.Message);

    end;

  end;

end;

procedure TViewCadTvs.DestroyFrameCadTv;
begin

  ModelTvs.Destroy;
  ViewCadTvs.Visible := False;
  ViewCadTvs         := nil;

end;

procedure TViewCadTvs.DetalhesDaTv;
begin

  try

    ModelTvs.FMenTv.Filter   := 'Idtv = ' + IntToStr(fIdTv);
    ModelTvs.FMenTv.Filtered := True;
    ModelTvs.FMenTv.First;
    edtCodigoTv.Text        := ModelTvs.FMenTv.FieldByName('IDTV').AsString;
    edtDescricaoTv.Text     := ModelTvs.FMenTv.FieldByName('DESCRICAOTV').AsString;

  except
    raise;

  end;
end;

procedure TViewCadTvs.EditaTv;
begin

end;

procedure TViewCadTvs.ListarProdNaoTv;
begin

  try

    lblSemRegistroProdNaotv.Visible := True;
    lstBoxProdNaoTV.Items.Clear;
    if ModelTvs.FMentProdNaoTv.RecordCount <> 0 then
    begin

      lstBoxProdNaoTV.BeginUpdate;
      ModelTvs.FMentProdNaoTv.First;
      while not ModelTvs.FMentProdNaoTv.eof do
      begin
        AddItemListBox(ModelTvs.FMentProdNaoTv.FieldByName('CODBARRA').AsString,
                       ModelTvs.FMentProdNaoTv.FieldByName('DESCRICAO').AsString,
                       ModelTvs.FMentProdNaoTv.FieldByName('VRVENDA').AsString,
                       lstBoxProdNaoTV,lblSemRegistroProdNaotv);

        ModelTvs.FMentProdNaoTv.Next;
      end;

      lstBoxProdNaoTV.EndUpdate;
    end;

  except
    ViewPrincipal.fMensagemErro := 'Não foi possivel listar produtos que não estao na TV';
    raise;

  end;

end;

procedure TViewCadTvs.ListarProdNaTv;
begin

  try

    lblSemRegistroProdNaTv.Visible := True;
    lstBoxProdNaTv.Items.Clear;
    if ModelTvs.FMentProdNaTv.RecordCount <> 0 then
    begin

      ModelTvs.FMentProdNaTv.First;
      lstBoxProdNaTv.BeginUpdate;
      while not ModelTvs.FMentProdNaTv.eof do
      begin

        AddItemListBox(ModelTvs.FMentProdNaTv.FieldByName('CODBARRA').AsString,
                       ModelTvs.FMentProdNaTv.FieldByName('DESCRICAO').AsString,
                       ModelTvs.FMentProdNaTv.FieldByName('VRVENDA').AsString,
                       lstBoxProdNaTv,lblSemRegistroProdNaTv);

        ModelTvs.FMentProdNaTv.Next;

      end;

      lstBoxProdNaTv.EndUpdate;
    end;

  except
    ViewPrincipal.fMensagemErro := 'Não foi possivel listar produtos que não estao na TV';
    raise;

  end;

end;

procedure TViewCadTvs.ListarTvCadastrada;
var
  vLstBoxItems : TListBoxItem;
  vPriRegestro : Boolean;

begin

  try

    ModelTvs.RecebeTv;

    lstBoxTvs.Items.Clear;
    if ModelTvs.FMenTv.RecordCount <> 0  then
    begin
      ModelTvs.FMenTv.First;
      lstBoxTvs.BeginUpdate;
      vPriRegestro := True;
      while not ModelTvs.FMenTv.Eof do
      begin

        vLstBoxItems              := TListBoxItem.Create(lstBoxTvs);
        vLstBoxItems.Text         := '';
        vLstBoxItems.Height       := 30;

        vLstBoxItems.TagString    := ModelTvs.FMenTv.FieldByName('IDTV').AsString;
        vLstBoxItems.Text         := ModelTvs.FMenTv.FieldByName('IDTV').AsString+
                                     ' - '+ ModelTvs.FMenTv.FieldByName('DESCRICAOTV').AsString;
        vLstBoxItems.Parent       := lstBoxTvs;

        if vPriRegestro then
        begin

          vLstBoxItems.IsSelected := True;
          vPriRegestro            := False;

        end;

        ModelTvs.FMenTv.Next;
      end;

      lstBoxTvs.EndUpdate;

      lblSemRegistroTv.Visible := False;
      if lstBoxTvs.Count = 0 then
      lblSemRegistroTv.Visible := True;


    end;

  except
    ViewPrincipal.fMensagemErro := 'Não foi possivel listar Tv cadastrada';
    raise

  end;
end;

procedure TViewCadTvs.ShowTabCadTv;
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

    ModelTvs.RecebeProdNaoTv(fidtv);
    ModelTvs.FMentProdNaoTv.Filtered := false;
    ListarProdNaoTv;

    ModelTvs.RecebeProdNaTv(fidtv);
    ModelTvs.FMentProdNaTv.Filtered := False;
    ListarProdNaTv;

    ModelTvs.RecebeTabProdTv(fidtv);

    edtDescricaoTv.SetFocus;
    TabControl.ActiveTab := tabCadTv;

  except
    raise
  end;

end;

procedure TViewCadTvs.ShowTabListarTv;
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
