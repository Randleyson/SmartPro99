unit uframe_CadProduto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, FMX.ListBox,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMX.Effects, FMX.Filter.Effects;

type
  TFrameCadProduto = class(TFrame)
    Rectangle1: TRectangle;
    lytTitulo: TLayout;
    btnFechar: TSpeedButton;
    Label1: TLabel;
    lytDetalheProd: TLayout;
    lytRodaPe: TLayout;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    edtDetCod: TEdit;
    edtDetVrVenda: TEdit;
    edtDetVrPromo: TEdit;
    edtDetUnidade: TEdit;
    edtDescriAlterada: TEdit;
    Label7: TLabel;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    lytBotao: TLayout;
    lytClient: TLayout;
    lytListaProd: TLayout;
    lstBoxProd: TListBox;
    BtnGrava: TCornerButton;
    lblSemRegestProd: TLabel;
    Layout4: TLayout;
    Label9: TLabel;
    lblDescricaoCadstro: TLabel;
    Rectangle2: TRectangle;
    FillRGBEffect1: TFillRGBEffect;
    Line1: TLine;
    Label10: TLabel;
    Line3: TLine;
    lytPesqProduto: TLayout;
    Rectangle6: TRectangle;
    Label11: TLabel;
    Label12: TLabel;
    edtPesqDescricao: TEdit;
    edtPesqCodBarra: TEdit;
    Rectangle7: TRectangle;
    btnPesqProdNaoTv: TButton;
    FillRGBEffect2: TFillRGBEffect;
    Rectangle3: TRectangle;
    Label5: TLabel;
    Line2: TLine;
    Rectangle4: TRectangle;
    imgPendencia: TImage;
    lytLegenda: TLayout;
    Label8: TLabel;
    Legenda: TLabel;
    lytPendecia: TLayout;
    Layout5: TLayout;
    Label14: TLabel;
    imgPromo: TImage;
    procedure btnFecharClick(Sender: TObject);
    procedure lstBoxProdItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure BtnGravaClick(Sender: TObject);
    procedure btnPesqProdNaoTvClick(Sender: TObject);
    procedure edtDescriAlteradaKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);

  private
    { Private declarations }
    fCodProd: String;
    procedure IniciarFrameCadProduto;
    procedure ListarProdutos;
    procedure AddItemListBox(pCodbarra,pDescricao,pVrVenda,pPromo: String;
              pLenght: integer; pListBox: TListBox; pLableSemGerg: TLabel);
    procedure DetalharProduto;
    procedure LayoutInformativo(pListBoxItem:TListBoxItem;
                                pPendecia : Boolean = False; pPromo: Boolean = False);

    procedure ClickBtnSalvar;
    procedure ClickBtnPesqProd;

  public
    { Public declarations }
    procedure CreateFrameCadProduto;
    procedure FechaFrameCadProduto;
  end;

var
  FrameCadProduto:TFrameCadProduto;

implementation

{$R *.fmx}

uses ufrm_Principal, udm_Conexao, udm_Principal,
  udm_CadProduto, uframe_Home, Loading, u_Message;

{ TFrameCadProduto }

procedure TFrameCadProduto.AddItemListBox(pCodbarra, pDescricao,
          pVrVenda, pPromo: String; pLenght: integer; pListBox: TListBox;
          pLableSemGerg: TLabel);
var
  vItem: TListBoxItem;
  vImg: TImage;

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

    LayoutInformativo(vItem, pLenght > 20 ,pPromo = 'S');

    pListBox.AddObject(vItem);

    if pListBox.Count = -1 then
    pLableSemGerg.Visible := True
    else
    pLableSemGerg.Visible := False;

    if pListBox.Count = 1 then
    vItem.IsSelected := True;

  except
    FrmPrincipal.fMensagemErro := 'Não foi possivel adicionar o frame no lisBox';
    raise
  end;

end;


procedure TFrameCadProduto.ClickBtnPesqProd;
begin

  try

    dmCadProduto.FMentProduto.Filter := 'codbarra like ''%'+ edtPesqCodBarra.Text+'%'''+
                                        ' and descricao like ''%'+ UpperCase(edtPesqDescricao.Text)+'%''';
    dmCadProduto.FMentProduto.Filtered := True;

    ListarProdutos;

  except
    frmPrincipal.FMensagemErro := 'Erro ao executar o ClickBtnPesqProdNaoTv';
    raise

  end;

end;

procedure TFrameCadProduto.btnFecharClick(Sender: TObject);
begin

  try

    FechaFrameCadProduto;

  except
  on e: Exception do
    begin
		TMessage.MessagemPopUp(frmPrincipal,'Erro : '+ frmPrincipal.fMensagemErro + e.Message);
    end;

  end;

end;

procedure TFrameCadProduto.BtnGravaClick(Sender: TObject);
begin

  try

    ClickBtnSalvar;

  except
  on e: Exception do
    begin
		TMessage.MessagemPopUp(frmPrincipal,'Erro : '+ frmPrincipal.fMensagemErro + e.Message);
    end;

  end;

end;

procedure TFrameCadProduto.btnPesqProdNaoTvClick(Sender: TObject);
begin

  try

    ClickBtnPesqProd;

  except
  on e: Exception do
    begin
		TMessage.MessagemPopUp(frmPrincipal,'Erro : '+ frmPrincipal.fMensagemErro + e.Message);
    end;
  end;

end;

procedure TFrameCadProduto.DetalharProduto;
begin

  try

    if lstBoxProd.ItemIndex = -1 then
    exit;

    fCodProd := lstBoxProd.ListItems[lstBoxProd.ItemIndex].TagString;

    dmCadProduto.FMentProduto.Filter   := 'Codbarra = ' + fCodProd;
    dmCadProduto.FMentProduto.Filtered := True;

    edtDetCod.Text           := dmCadProduto.FMentProdutoCODBARRA.AsString;
    lblDescricaoCadstro.Text := dmCadProduto.FMentProdutoDESCRICAO.AsString;
    edtDetVrVenda.Text       := dmCadProduto.FMentProdutoVRVENDA.AsString;

    if dmCadProduto.FMentProdutoDESCRICAOALTERADA.AsString = '' then
    edtDescriAlterada.Text   := copy(dmCadProduto.FMentProdutoDESCRICAO.AsString,0,20)
    else
    edtDescriAlterada.Text   := copy(dmCadProduto.FMentProdutoDESCRICAOALTERADA.AsString,0,20);

    edtDetUnidade.Text       := dmCadProduto.FMentProdutoUNIDADE.AsString;

  except
    frmPrincipal.FMensagemErro := 'Erro ao executar DetalharProduto';
    raise;

  end;

end;

procedure TFrameCadProduto.edtDescriAlteradaKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin

  if Key = 8 then
  exit;
  
  if Length(edtDescriAlterada.Text) > 20 then
  begin
    TMessage.MessagemPopUp(frmPrincipal,'Descrição maior que o permtido (20)');
    KeyChar := #0;
  end;

end;

procedure TFrameCadProduto.FechaFrameCadProduto;
begin

  FrameHome.CreateFremeHome;
  FrameCadProduto.Visible := False;
  FrameCadProduto := nil;

end;

procedure TFrameCadProduto.ClickBtnSalvar;
begin

  try

    dmCadProduto.UpdateProduto(fCodProd,edtDescriAlterada.Text);
    dmCadProduto.BdToFMentProduto;
    ListarProdutos;
    DetalharProduto;

  except
    raise;

  end;

end;

procedure TFrameCadProduto.IniciarFrameCadProduto;
begin

    frmPrincipal.FMensagemAguarde := 'Aguarde... Carregando a Tela';
    TLoading.Show(frmPrincipal,frmPrincipal.FMensagemAguarde);

    TThread.CreateAnonymousThread(procedure
    begin
    try

      try

        sleep(1000);
        dmCadProduto.BdToFMentProduto;
        ListarProdutos;
        DetalharProduto;

      except
        raise
      end;

    finally



      TThread.Synchronize(nil,procedure
      begin
        TLoading.Hide;
        BringToFront;
      end);
    end;

  end).Start;

end;

procedure TFrameCadProduto.LayoutInformativo(pListBoxItem:TListBoxItem;
          pPendecia : Boolean = False; pPromo: Boolean = False);
var
  vLayout : TLayout;
  vImgPend,vImgPromo : TImage;
begin

  try

    vLayout                 := TLayout.Create(pListBoxItem);
    vLayout.Parent          := pListBoxItem;
    vLayout.Align           := TAlignLayout(3);
    vLayout.Width           := 50;
    vLayout.Margins.Top     := 12;
    vLayout.Margins.Bottom  := 12;

    if pPromo then
    begin
      vImgPromo                := TImage.Create(vLayout);
      vImgPromo.Parent         := pListBoxItem;
      vImgPromo.Align          := TAlignLayout(3);
      vImgPromo.Width          := 25;
      vImgPromo.Margins.Top    := 12;
      vImgPromo.Margins.Bottom := 12;
      vImgPromo.Bitmap         := imgPromo.Bitmap;
    end;

    if pPendecia then
    begin
      vImgPend                := TImage.Create(vLayout);
      vImgPend.Parent         := pListBoxItem;
      vImgPend.Align          := TAlignLayout(3);
      vImgPend.Width          := 25;
      vImgPend.Margins.Top    := 12;
      vImgPend.Margins.Bottom := 12;
      vImgPend.Bitmap         := imgPendencia.Bitmap;
    end;

  except
    raise

  end;

end;

procedure TFrameCadProduto.ListarProdutos;
var
  vLstBoxItems: TListBoxItem;
  vPriRegestro: Boolean;
begin

  try

    lblSemRegestProd.Visible  := True;
    lstBoxProd.Items.Clear;
    if dmCadProduto.FMentProduto.RecordCount <> 0 then
    begin
      dmCadProduto.FMentProduto.First;
      lstBoxProd.BeginUpdate;
      vPriRegestro := True;

      while not dmCadProduto.FMentProduto.Eof do
      begin

        AddItemListBox(dmCadProduto.FMentProdutoCODBARRA.AsString,
                       dmCadProduto.FMentProdutoDESCRICAO.AsString,
                       dmCadProduto.FMentProdutoVRVENDA.AsString,
                       dmCadProduto.FMentProdutoPROMOCAO.AsString,
                       dmCadProduto.FMentProdutoLENGHT.AsInteger,
                       lstBoxProd,
                       lblSemRegestProd);

        dmCadProduto.FMentProduto.Next;
      end;

      lstBoxProd.EndUpdate;
    end;

  except
    raise;

  end;
end;


procedure TFrameCadProduto.lstBoxProdItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin

  DetalharProduto;

end;

procedure TFrameCadProduto.CreateFrameCadProduto;
begin

  try

    if not assigned(FrameCadProduto) then
    FrameCadProduto := TFrameCadProduto.Create(self);

    with FrameCadProduto do
    begin

      Name         := 'FrameCadProd';
      Parent       := frmPrincipal;

      if not assigned(dmCadProduto) then
      dmCadProduto := TdmCadProduto.Create(self);

      IniciarFrameCadProduto;


    end;

  except
  on e: Exception do
    begin
		TMessage.MessagemPopUp(frmPrincipal,'Erro : '+ frmPrincipal.fMensagemErro + e.Message);
    end;

  end;

end;

end.
