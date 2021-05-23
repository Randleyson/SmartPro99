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
  FireDAC.Comp.Client;

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
    FMenTableProdutos: TFDMemTable;
    FMenTableProdutosCODBARRA: TStringField;
    FMenTableProdutosDESCRICAO: TStringField;
    FMenTableProdutosUNIDADE: TStringField;
    FMenTableProdutosVRVENDA: TCurrencyField;
    procedure FrameCabecalho1ImgFecharClick(Sender: TObject);
    procedure LstBoxProdutosItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure FramePesquisaEdtPesquisaKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
  private
    FCodbarra: String;
    FDescricao: String;
    FVrVenda: Currency;
    FUnidade: String;
    procedure CarregaProdutosDataSet;
    procedure ListarProdutos;
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
  FMenTableProdutos.Close;
  FMenTableProdutos.Open;
  FMenTableProdutos.EmptyDataSet;
  TFDMemTable(FMenTableProdutos).CopyDataSet(Dm.DataSetProdutos);
  FMenTableProdutos.Filtered := False;

  FramePesquisa.CBoxFiltro.Items.Clear;
  FramePesquisa.CBoxFiltro.Items.Add('CODIGO BARRA');
  FramePesquisa.CBoxFiltro.Items.Add('DESCRIÇÃO');
  FramePesquisa.CBoxFiltro.Items.Add('UNIDADE');
  FramePesquisa.CBoxFiltro.Items.Add('VALOR VENDA');
  FramePesquisa.CBoxFiltro.ItemIndex := 0;
  ListarProdutos;
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

procedure TFrameCadProdutos.ListarProdutos;
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
        FCodbarra   := FMenTableProdutosCODBARRA.AsString;
        FDescricao  := FMenTableProdutosDESCRICAO.AsString;
        FUnidade    := FMenTableProdutosUNIDADE.AsString;
        FVrVenda    := FMenTableProdutosVRVENDA.AsCurrency;
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
        FMenTableProdutos.Next;
      end;
      DetalharCadProduto;
    end;

  finally
    LstBoxProdutos.EndUpdate;
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
  FMenTableProdutos.Filter    := 'Codbarra = ' + FCodbarra;
  FMenTableProdutos.Filtered  := True;
  EdtCodBarra.Text            := FMenTableProdutosCODBARRA.AsString;
  EdtDecricao.Text            := FMenTableProdutosDESCRICAO.AsString;
  EdtUnidade.Text             := FMenTableProdutosUNIDADE.AsString;
  EdtVrVenda.Text             := FMenTableProdutosVRVENDA.AsString;
  FMenTableProdutos.Filtered  := False;
end;

procedure TFrameCadProdutos.FrameCabecalho1ImgFecharClick(Sender: TObject);
begin
  CloseCadProduto;
end;

procedure TFrameCadProdutos.FramePesquisaEdtPesquisaKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  vFilter: String;
  vParant: String;
begin
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
  FMenTableProdutos.Filtered  := False;
  FMenTableProdutos.Filter    := vParant + ' Like ' + QuotedStr(vFilter);
  FMenTableProdutos.Filtered  := True;
  ListarProdutos;
end;

end.
