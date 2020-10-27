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
    Layout5: TLayout;
    Label8: TLabel;
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
    procedure AddItemListBox(pCodbarra,pDescricao,pVrVenda: String;
              pLenght: integer; pListBox: TListBox; pLableSemGerg: TLabel);
    procedure DetalharProduto;
    procedure ClickBtnSalvar;
    procedure ClickBtnPesqProd;
    procedure CriaimgPendencia(pListBoxItem:TListBoxItem);


  public
    { Public declarations }
    procedure CreateFrameCadProduto;
    procedure FechaFrameCadProduto;
  end;

var
  FrameCadProduto:TFrameCadProduto;

implementation

{$R *.fmx}

uses ufrm_Principal, udm_Conexao, udm_Principal, ufrm_MensagemInfor,
  udm_CadProduto, uframe_Home;

{ TFrameCadProduto }

procedure TFrameCadProduto.AddItemListBox(pCodbarra, pDescricao,
          pVrVenda: String; pLenght: integer; pListBox: TListBox; pLableSemGerg: TLabel);
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

    if pLenght > 20 then
    CriaimgPendencia(vItem); 
    
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

  FechaFrameCadProduto;

end;

procedure TFrameCadProduto.BtnGravaClick(Sender: TObject);
begin

  try

    ClickBtnSalvar;

  except
  on E: exception do
    FrameMsgInfor.CreateFrameMsgInfor(frmPrincipal.fMensagemErro+E.message);

  end;

end;

procedure TFrameCadProduto.btnPesqProdNaoTvClick(Sender: TObject);
begin

  ClickBtnPesqProd;

end;

procedure TFrameCadProduto.DetalharProduto;
begin

  try

    fCodProd := lstBoxProd.ListItems[lstBoxProd.ItemIndex].TagString;

    dmCadProduto.FMentProduto.Filter   := 'Codbarra = ' + fCodProd;
    dmCadProduto.FMentProduto.Filtered := True;

    edtDetCod.Text           := dmCadProduto.FMentProdutoCODBARRA.AsString;
    lblDescricaoCadstro.Text := dmCadProduto.FMentProdutoDESCRICAO.AsString;
    edtDetVrVenda.Text       := dmCadProduto.FMentProdutoVRVENDA.AsString;

    if dmCadProduto.FMentProdutoDESCRICAOALTERADA.AsString = '' then
    edtDescriAlterada.Text     := copy(dmCadProduto.FMentProdutoDESCRICAO.AsString,0,20)
    else
    edtDescriAlterada.Text     := copy(dmCadProduto.FMentProdutoDESCRICAOALTERADA.AsString,0,20);



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
    FrameMsgInfor.CreateFrameMsgInfor('Descrição maior que o permtido (20)');
    KeyChar := #0;
  end;

end;

procedure TFrameCadProduto.FechaFrameCadProduto;
begin

  FrameHome.CreateFremeHome;
  FrameCadProduto.Visible := False;
  FrameCadProduto := nil;

end;

procedure TFrameCadProduto.CriaimgPendencia(pListBoxItem: TListBoxItem);
var 
  vImg : TImage; 
begin

  try
  
    vImg := TImage.Create(pListBoxItem);
    vImg.Parent := pListBoxItem;
    vImg.Align := TAlignLayout(3);
    vImg.Margins.Top := 12;
    vImg.Margins.Bottom := 12;
    vImg.Bitmap := imgPendencia.Bitmap;
  
  except
   raise

  end;

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

  try
  
    dmCadProduto.BdToFMentProduto;
    ListarProdutos;
    DetalharProduto;

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
        dmCadProduto.FMentProduto.FieldByName('LENGHT').AsString;
        AddItemListBox(dmCadProduto.FMentProdutoCODBARRA.AsString,
                       dmCadProduto.FMentProdutoDESCRICAO.AsString,
                       dmCadProduto.FMentProdutoVRVENDA.AsString,
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
      BringToFront;

    end;
  except
    FrameMsgInfor.CreateFrameMsgInfor(frmPrincipal.FMensagemErro);

  end;

end;

end.
