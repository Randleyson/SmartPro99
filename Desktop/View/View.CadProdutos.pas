unit View.CadProdutos;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  View.Frame.Cabecalho,
  FMX.Objects,
  FMX.Edit,
  View.Frame.Pesquisa,
  FMX.Layouts,
  FMX.ListBox,
  FMX.Controls.Presentation,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Rtti, FMX.Grid.Style, FMX.ScrollBox, FMX.Grid;

type
  TFrameCadProdutos = class(TFrame)
    Layout1: TLayout;
    LytListaProdutos: TLayout;
    Label1: TLabel;
    Layout3: TLayout;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LstBoxProdutos: TListBox;
    LblSemRegistro: TLabel;
    FramePesquisa: TFramePesquisa;
    LytCadProduto: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    LytCodBarra: TLayout;
    Label7: TLabel;
    EdtCodBarra: TEdit;
    LytDescricao: TLayout;
    Label6: TLabel;
    EdtDecricao: TEdit;
    Label10: TLabel;
    LytUnidade: TLayout;
    Label8: TLabel;
    EdtUnidade: TEdit;
    LytVrVenda: TLayout;
    Label9: TLabel;
    EdtVrVenda: TEdit;
    Rectangle1: TRectangle;
    FrameCabecalho1: TFrameCabecalho;
    DS_Produtos: TFDMemTable;
    DS_ProdutosCODBARRA: TStringField;
    DS_ProdutosDESCRICAO: TStringField;
    DS_ProdutosUNIDADE: TStringField;
    DS_ProdutosVRVENDA: TCurrencyField;
    Grid: TStringGrid;
    procedure FrameCabecalho1ImgFecharClick(Sender: TObject);
    procedure LstBoxProdutosItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure GridCellClick(const Column: TColumn; const Row: Integer);
    procedure FramePesquisaEdtPesquisaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private
    FCodbarra: String;
    FDescricao: String;
    FVrVenda: Currency;
    FUnidade: String;
    procedure CarregaProdutosDataSet;
    procedure ListarProdutos;
    procedure ListarGrid;
    procedure DetalharCadProduto;
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure CloseCadProduto;
  end;
var
  FrameCadProdutos: TFrameCadProdutos;

implementation

uses
  uDm,
  uUtilis;

{$R *.fmx}

{ TFrameCadProdutos }

constructor TFrameCadProdutos.Create(AOwner: TComponent);
begin
  inherited;
  FrameCabecalho1.LblNomeDaTela.Text := 'Cadastro de Produtos';
  CarregaProdutosDataSet;
end;

procedure TFrameCadProdutos.CarregaProdutosDataSet;
begin
  DS_Produtos.Close;
  DS_Produtos.Open;
  DS_Produtos.EmptyDataSet;
  TFDMemTable(DS_Produtos).CopyDataSet(Dm.DataSetProdutos);
  DS_Produtos.Filtered := False;

  FramePesquisa.CBoxFiltro.Items.Clear;
  FramePesquisa.CBoxFiltro.Items.Add('CODIGO BARRA');
  FramePesquisa.CBoxFiltro.Items.Add('DESCRIÇÃO');
  FramePesquisa.CBoxFiltro.Items.Add('UNIDADE');
  FramePesquisa.CBoxFiltro.Items.Add('VALOR VENDA');
  FramePesquisa.CBoxFiltro.ItemIndex := 1;
  ListarGrid;
  //ListarProdutos;
end;

procedure TFrameCadProdutos.CloseCadProduto;
begin
  if Assigned(FrameCadProdutos) then
  begin
    FrameCadProdutos.Visible := False;
    FrameCadProdutos.DisposeOf;
    FrameCadProdutos := Nil;
  end;
end;

procedure TFrameCadProdutos.ListarGrid;
var
  vColumn: TColumn;
  vlin,vCol: Integer;
begin
  Grid.ClearColumns;
  Grid.RowCount := DS_Produtos.RecordCount;
  vColumn := TColumn.Create(Nil);
  vColumn.Header := 'CodBarra';
  vColumn.Parent := Grid;

  vColumn := TColumn.Create(Nil);
  vColumn.Header := 'Descricao';
  vColumn.Parent := Grid;

  vColumn := TColumn.Create(Nil);
  vColumn.Header := 'Unidade';
  vColumn.Parent := Grid;

  vColumn := TColumn.Create(Nil);
  vColumn.Header := 'Valor';
  vColumn.Parent := Grid;

  DS_Produtos.First;
  while not DS_Produtos.Eof do
  begin
    Grid.Cells[0,DS_Produtos.RecNo-1] := DS_Produtos.FieldByName('CodBarra').AsString;
    Grid.Cells[1,DS_Produtos.RecNo-1] := DS_Produtos.FieldByName('Descricao').AsString;
    Grid.Cells[2,DS_Produtos.RecNo-1] := DS_Produtos.FieldByName('Unidade').AsString;
    Grid.Cells[3,DS_Produtos.RecNo-1] := DS_Produtos.FieldByName('VrVenda').AsString;
    DS_Produtos.Next;
  end;

end;

procedure TFrameCadProdutos.ListarProdutos;
var
  vLstBoxItems: TListBoxItem;
begin

  LblSemRegistro.Visible := True;
  if DS_Produtos.RecordCount <> 0 then
  begin
    LblSemRegistro.Visible := False;
    LstBoxProdutos.Items.Clear;
    DS_Produtos.First;

    LstBoxProdutos.BeginUpdate;
    try

      while not DS_Produtos.Eof do
      begin
        FCodbarra   := DS_ProdutosCODBARRA.AsString;
        FDescricao  := DS_ProdutosDESCRICAO.AsString;
        FUnidade    := DS_ProdutosUNIDADE.AsString;
        FVrVenda    := DS_ProdutosVRVENDA.AsCurrency;
        vLstBoxItems := TListBoxItem.Create(LstBoxProdutos);
        vLstBoxItems.Text := '';
        vLstBoxItems.align := TAlignLayout.Client;
        vLstBoxItems.StyleLookup := 'listboxitembottomdetail';
        vLstBoxItems.Height := 40;
        vLstBoxItems.TagString := FCodbarra;
        vLstBoxItems.ItemData.Text := FDescricao;
        vLstBoxItems.ItemData.Detail := 'Cod: ' + FCodbarra +
                                        '      R$: ' + TUtilis.FormatReal(FVrVenda) +
                                        '      Unidade: ' + FUnidade;
        LstBoxProdutos.AddObject(vLstBoxItems);
        if LstBoxProdutos.Count = 1 then
          vLstBoxItems.IsSelected := True;
        DS_Produtos.Next;
      end;
      DetalharCadProduto;
    finally
      LstBoxProdutos.EndUpdate;
    end;
  end;

end;

procedure TFrameCadProdutos.LstBoxProdutosItemClick(
  const Sender: TCustomListBox; const Item: TListBoxItem);
begin
  DetalharCadProduto;
end;

procedure TFrameCadProdutos.DetalharCadProduto;
begin
  FCodbarra := LstBoxProdutos.ListItems[LstBoxProdutos.ItemIndex].TagString;
  DS_Produtos.Filter    := 'Codbarra = ' + QuotedStr(FCodbarra);
  DS_Produtos.Filtered  := True;
  EdtCodBarra.Text      := DS_ProdutosCODBARRA.AsString;
  EdtDecricao.Text      := DS_ProdutosDESCRICAO.AsString;
  EdtUnidade.Text       := DS_ProdutosUNIDADE.AsString;
  EdtVrVenda.Text       := DS_ProdutosVRVENDA.AsString;
  DS_Produtos.Filtered  := False;
end;

procedure TFrameCadProdutos.FrameCabecalho1ImgFecharClick(Sender: TObject);
begin
  CloseCadProduto;
end;

procedure TFrameCadProdutos.GridCellClick(const Column: TColumn;
  const Row: Integer);
begin
  EdtCodBarra.Text := Grid.Cells[0,Row];
  EdtDecricao.Text := Grid.Cells[1,Row];
  EdtUnidade.Text := Grid.Cells[2,Row];
  EdtVrVenda.Text := Grid.Cells[3,Row];
end;

procedure TFrameCadProdutos.FramePesquisaEdtPesquisaKeyUp(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  vFilter: String;
  vParant: String;
begin

  if Key = 120 then Exit;
  vFilter := UpperCase('%' + FramePesquisa.EdtPesquisa.Text + '%');
  case FramePesquisa.CBoxFiltro.ItemIndex of
    0:
      vParant := 'CODBARRA';
    1:
      vParant := 'DESCRICAO';
    2:
      vParant := 'UNIDADE';
    3:
      vParant := 'VRVENDA';
  end;
  DS_Produtos.Filtered  := False;
  DS_Produtos.Filter    := vParant + ' Like ' + QuotedStr(vFilter);
  DS_Produtos.Filtered  := True;
  ListarGrid;
  exit;
  //ListarProdutos;
end;

end.
