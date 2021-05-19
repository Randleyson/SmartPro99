unit View.FrmProdutos;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.Objects,
  FMX.Edit,
  FMX.ListBox,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  View.Frame.Pesquisa,
  View.Frame.Cabecalho,
  View.Frame.PaletaCores;
type
  TViewFrmProdutos = class(TForm)
    LytListaProdutos: TLayout;
    Layout1: TLayout;
    Label1: TLabel;
    Layout3: TLayout;
    LstBoxProdutos: TListBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    FMenTableProdutos: TFDMemTable;
    FMenTableProdutosCODBARRA: TStringField;
    FMenTableProdutosDESCRICAO: TStringField;
    FMenTableProdutosUNIDADE: TStringField;
    FMenTableProdutosVRVENDA: TCurrencyField;
    LblSemRegistro: TLabel;
    LytCadProduto: TLayout;
    Layout4: TLayout;
    Label7: TLabel;
    EdtCodBarra: TEdit;
    Layout5: TLayout;
    LytCodBarra: TLayout;
    LytDescricao: TLayout;
    Label6: TLabel;
    EdtDecricao: TEdit;
    LytUnidade: TLayout;
    Label8: TLabel;
    EdtUnidade: TEdit;
    LytVrVenda: TLayout;
    Label9: TLabel;
    EdtVrVenda: TEdit;
    Label10: TLabel;
    FramePesquisa: TFramePesquisa;
    FrameCabecalho1: TFrameCabecalho;
    FramePaletaCores1: TFramePaletaCores;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure LstBoxProdutosItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure FramePesquisaBtnPesquisaClick(Sender: TObject);
    procedure FramePesquisaEdtPesquisaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private
    { Private declarations }
    procedure AddItemLisBoxProduto;
    procedure CarregaProdutosDataSet;
    procedure CloseViewProdutos;
    procedure DetalharCadProduto;
    procedure InicializaCadProdutos;
    function GetComboxPesquisa: String;
    procedure ListarProdutos;
    procedure SetComboxPesquisa;
    procedure PesquisarProduto;

  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses Controller.uFarctory,
     Controller.oProdutos,
     Controller.uProdutos,
     Controller.uSmartPro99;

{ TViewFrmProdutos }

procedure TViewFrmProdutos.AddItemLisBoxProduto;
var
  vItem: TListBoxItem;
  vImg: TImage;
begin
  vItem := TListBoxItem.Create(LstBoxProdutos);
  vItem.Text := '';
  vItem.align := TAlignLayout.Client;
  vItem.StyleLookup := 'listboxitembottomdetail';
  vItem.Height := 40;
  vItem.TagString := oProdutos.Codbarra;
  vItem.ItemData.Text := oProdutos.Descricao;
  vItem.ItemData.Detail := 'Cod: ' + oProdutos.Codbarra + '      R$: ' +
    TuSmartPro99.FormatReal(oProdutos.VrVenda) + '      Unidade: ' +
    oProdutos.Unidade;

  { if pLenght > 20 then
    CriaimgPendencia(vItem); }
  LstBoxProdutos.AddObject(vItem);
  if LstBoxProdutos.Count = 1 then
    vItem.IsSelected := True;
end;

procedure TViewFrmProdutos.CarregaProdutosDataSet;
begin
  FMenTableProdutos.Close;
  FMenTableProdutos.Open;
  FMenTableProdutos.EmptyDataSet;
  TuProdutos.New.CarregaProdutoDb(FMenTableProdutos);
  FMenTableProdutos.Filtered := False;
  ListarProdutos;
end;

procedure TViewFrmProdutos.CloseViewProdutos;
begin
  FreeAndNil(oProdutos);
  uFarctory.ProdutosDestroyView;
end;

procedure TViewFrmProdutos.DetalharCadProduto;
begin
  oProdutos.Codbarra := LstBoxProdutos.ListItems[LstBoxProdutos.ItemIndex].TagString;
  FMenTableProdutos.Filter := 'Codbarra = ' + oProdutos.Codbarra;
  FMenTableProdutos.Filtered := True;
  EdtCodBarra.Text := FMenTableProdutosCODBARRA.AsString;
  EdtDecricao.Text := FMenTableProdutosDESCRICAO.AsString;
  EdtUnidade.Text := FMenTableProdutosUNIDADE.AsString;
  EdtVrVenda.Text := FMenTableProdutosVRVENDA.AsString;
end;

procedure TViewFrmProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseViewProdutos;
end;

procedure TViewFrmProdutos.FormShow(Sender: TObject);
begin
  InicializaCadProdutos;
end;

procedure TViewFrmProdutos.FramePesquisaBtnPesquisaClick(Sender: TObject);
begin
  PesquisarProduto;
end;

procedure TViewFrmProdutos.FramePesquisaEdtPesquisaKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if KeyChar = #0 then
    PesquisarProduto;
end;

function TViewFrmProdutos.GetComboxPesquisa: String;
begin

  case FramePesquisa.CBoxFiltro.ItemIndex of
    0:
      Result := 'CODBARRA';
    1:
      Result := 'DESCRICAO';
    2:
      Result := 'UNIDADE';
    3:
      Result := 'VRVENDA';
  end;

end;

procedure TViewFrmProdutos.InicializaCadProdutos;
begin

  oProdutos := ToProdutos.Create;
  try
    FrameCabecalho1.LblNomeDaTela.Text := 'Cadastro de Produtos';
    CarregaProdutosDataSet;
    SetComboxPesquisa;
    FramePaletaCores1.Visible := False;

  except
    on E: Exception do
    begin
      ShowMessage('Erro: ' + E.Message);
      exit;
    end;
  end;

end;

procedure TViewFrmProdutos.ListarProdutos;
var
  vLstBoxItems: TListBoxItem;
begin

  LstBoxProdutos.BeginUpdate;
  try
    LstBoxProdutos.Items.Clear;
    LblSemRegistro.Visible := True;
    if FMenTableProdutos.RecordCount <> 0 then
    begin
      LblSemRegistro.Visible := False;

      FMenTableProdutos.First;
      while not FMenTableProdutos.Eof do
      begin
        oProdutos.Codbarra := FMenTableProdutosCODBARRA.AsString;
        oProdutos.Descricao := FMenTableProdutosDESCRICAO.AsString;
        oProdutos.Unidade := FMenTableProdutosUNIDADE.AsString;
        oProdutos.VrVenda := FMenTableProdutosVRVENDA.AsCurrency;
        AddItemLisBoxProduto;
        FMenTableProdutos.Next;
      end;
      DetalharCadProduto;
    end;

  finally
    LstBoxProdutos.EndUpdate;
  end;

end;

procedure TViewFrmProdutos.LstBoxProdutosItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  DetalharCadProduto;
end;

procedure TViewFrmProdutos.PesquisarProduto;
var
  vFiltro: String;
begin

  vFiltro := UpperCase('%' + FramePesquisa.EdtPesquisa.Text + '%');

  FMenTableProdutos.Filtered := False;
  FMenTableProdutos.Filter := GetComboxPesquisa + ' Like ' + QuotedStr(vFiltro);
  FMenTableProdutos.Filtered := True;
  ListarProdutos;

end;

procedure TViewFrmProdutos.SetComboxPesquisa;
begin

  FramePesquisa.CBoxFiltro.Items.Clear;
  FramePesquisa.CBoxFiltro.Items.Add('CODIGO BARRA');
  FramePesquisa.CBoxFiltro.Items.Add('DESCRIÇÃO');
  FramePesquisa.CBoxFiltro.Items.Add('UNIDADE');
  FramePesquisa.CBoxFiltro.Items.Add('VALOR VENDA');

  FramePesquisa.CBoxFiltro.ItemIndex := 0;

end;

end.
