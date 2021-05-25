unit View.TabelaPreco;

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
  FMX.Objects,
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
  FireDAC.Comp.Client,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView,
  Units.Dm,
  View.Frames.TabelaCores,
  View.Configuracao,
  System.ImageList,
  FMX.ImgList;

type
  TViewTabelaPreco = class(TFrame)
    RectClient: TRectangle;
    RectTitulo: TRectangle;
    RectRodaPe: TRectangle;
    ImgConfiguracoes: TImage;
    ImgConexao: TImage;
    FrameTabelaCores1: TFrameTabelaCores;
    Label1: TLabel;
    Label2: TLabel;
    LstProdutos: TListBox;
    LblSemRegistro: TLabel;
    Image1: TImage;
    Layout1: TLayout;
    TmProxino: TTimer;
    ImageList1: TImageList;
    procedure ImgConfiguracoesClick(Sender: TObject);
    procedure TmProxinoTimer(Sender: TObject);
  private
    { Private declarations }
    procedure ListarProdutos;
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;
    procedure ShowView(aParent: TFmxObject);
  end;
var
  FrameTabelaPreco: TViewTabelaPreco;

implementation

uses
  View.Frames.ItemLista;

{$R *.fmx}
{ TViewTabelaPreco }

constructor TViewTabelaPreco.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TViewTabelaPreco.Destroy;
begin
  inherited;
end;

procedure TViewTabelaPreco.ImgConfiguracoesClick(Sender: TObject);
begin
  FrameConfiguracao := Nil;
  FrameConfiguracao := TViewConfiguracoes.Create(Nil);
  FrameConfiguracao.ShowView(FParent);
end;

procedure TViewTabelaPreco.ListarProdutos;
var
  vFrame: TFrameItemList;
  vListBoxItem: TListBoxItem;
  i: Integer;
  x: TSizeF;
begin
  i := 0;
  LblSemRegistro.Visible  := True;
  LstProdutos.BeginUpdate;
  try
    LstProdutos.Items.Clear;
    while not dm.DS_Produtos.Eof do
    begin
      LblSemRegistro.Visible  := False;
      vListBoxItem            := TListBoxItem.Create(LstProdutos);
      vListBoxItem.Height     := 50;
      vListBoxItem.TagString  := dm.FMenProduto.FieldByName('codbarra').AsString;

      vFrame        := TFrameItemList.Create(Nil);
      vFrame.Parent := vListBoxItem;
      vFrame.Align  := Align.alClient;
      vFrame.LblDescricao.Text  := dm.DS_Produtos.FieldByName('descricao').AsString;
      vFrame.LblValor.Text      := Formatfloat('##,###,##0.00', dm.DS_Produtos.FieldByName('vrvenda').AsCurrency);
      vFrame.LblUnd.Text        := dm.DS_Produtos.FieldByName('unidade').AsString;

      i := i + 1;
      vFrame.CorFundo(i mod 2);
      LstProdutos.AddObject(vListBoxItem);
      if i = 5 then
        Exit;
      Dm.DS_Produtos.Next;

      if dm.DS_Produtos.Eof then
      begin
        Dm.ReloandProdutos;
        Dm.DS_Produtos.First;
      end;
    end;
  finally
    LstProdutos.EndUpdate;
  end;
end;

procedure TViewTabelaPreco.ShowView(aParent: TFmxObject);
begin
  Parent                    := aParent;
  FrameTabelaCores1.Visible := False;
  TmProxino.Interval        := 3000;
  TmProxino.Enabled         := True;
  Dm.ReloandProdutos;
  Dm.DS_Produtos.First;
  ListarProdutos;
  BringToFront;
end;

procedure TViewTabelaPreco.TmProxinoTimer(Sender: TObject);
begin
  if not Assigned(FrameConfiguracao) then
    ListarProdutos;
end;

end.
