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
  View.Configuracao;

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
    procedure ImgConfiguracoesClick(Sender: TObject);
    procedure TmProxinoTimer(Sender: TObject);
  private
    { Private declarations }
    FParent: TFmxObject;
    FFrameConfiguracao: TViewConfiguracoes;
    procedure ListarProdutos;
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;
    procedure ShowView(aParent: TFmxObject);
  end;

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
  FFrameConfiguracao := Nil;
  FFrameConfiguracao := TViewConfiguracoes.Create(Nil);
  FFrameConfiguracao.ShowView(FParent);
end;

procedure TViewTabelaPreco.ListarProdutos;
var
  vFrame: TFrameItemList;
  vListBoxItem: TListBoxItem;
  i: Integer;

begin
  i := 0;
  LstProdutos.Items.Clear;
  LstProdutos.BeginUpdate;
  try

    LblSemRegistro.Visible := True;
    if dm.FMenProduto.RecordCount <> 0 then
    begin
      LblSemRegistro.Visible := False;

      while not dm.FMenProduto.Eof do
      begin
        vListBoxItem := TListBoxItem.Create(LstProdutos);
        vListBoxItem.Height := 50;
        vListBoxItem.TagString := dm.FMenProduto.FieldByName('codbarra').AsString;

        vFrame := TFrameItemList.Create(Nil);
        vFrame.Parent := vListBoxItem;
        vFrame.Align := Align.alClient;
        vFrame.LblDescricao.Text := dm.FMenProduto.FieldByName('descricao').AsString;
        vFrame.LblValor.Text := dm.FMenProduto.FieldByName('vrvenda').AsString;
        vFrame.LblUnd.Text := dm.FMenProduto.FieldByName('unidade').AsString;

        i := i + 1;
        vFrame.CorFundo(i mod 2);
        LstProdutos.AddObject(vListBoxItem);

        if i = 5 then
          Exit;

        Dm.FMenProduto.Next;
        if dm.FMenProduto.Eof then
        begin
          Dm.ReloandProdutos;
          Dm.FMenProduto.First;
        end;
      end;

    end;
  finally
    LstProdutos.EndUpdate;
  end;

end;

procedure TViewTabelaPreco.ShowView(aParent: TFmxObject);
begin
  FParent := aParent;
  Self.Parent := FParent;
  FrameTabelaCores1.Visible := False;
  Dm.ReloandProdutos;
  Dm.FMenProduto.First;
  ListarProdutos;
  TmProxino.Interval := 3000;
  TmProxino.Enabled := True;
  FrameTabelaCores1.Visible := False;
  Self.BringToFront;
end;

procedure TViewTabelaPreco.TmProxinoTimer(Sender: TObject);
begin
  ListarProdutos;
end;

end.
