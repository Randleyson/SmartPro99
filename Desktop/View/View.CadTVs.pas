unit View.CadTVs;

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
  FMX.Edit,
  View.Frame.Pesquisa,
  FMX.Layouts,
  FMX.ListBox,
  FMX.Controls.Presentation,
  FMX.Objects,
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
  TFrameCadTVs = class(TFrame)
    Rectangle1: TRectangle;
    LytCadTv: TLayout;
    LytProdTv: TLayout;
    Label5: TLabel;
    LytCadProd: TLayout;
    LstBoxProdNaoTv: TListBox;
    LblSemRegistroProdNaoTv: TLabel;
    FramePesquisaProdutos: TFramePesquisa;
    LytProdTvs: TLayout;
    LstBoxProdTv: TListBox;
    LblSemRegistroProdTv: TLabel;
    FramePesquisaProdTv: TFramePesquisa;
    LytBotao: TLayout;
    BtnAdicionarProdTv: TRectangle;
    Label6: TLabel;
    BtnRemoverProdTv: TRectangle;
    Label7: TLabel;
    BtnRemoverTodos: TRectangle;
    Label8: TLabel;
    BtnAdicionarTodos: TRectangle;
    Label9: TLabel;
    LytDetalhesTv: TLayout;
    Label2: TLabel;
    Layout5: TLayout;
    Layout6: TLayout;
    Label3: TLabel;
    EdtIdTv: TEdit;
    Layout7: TLayout;
    Label4: TLabel;
    EdtDescricaoTv: TEdit;
    LytListaTv: TLayout;
    Label1: TLabel;
    LstBoxTvs: TListBox;
    LblSemRegistroLstBoxTv: TLabel;
    FramePesquisaTvs: TFramePesquisa;
    FrameCabecalho1: TFrameCabecalho;
    FMemTableTvs: TFDMemTable;
    FMemTableTvsIDTV: TIntegerField;
    FMemTableTvsDESCRICAO: TStringField;
    FMemTableProdNaoTv: TFDMemTable;
    FMemTableProdNaoTvCODBARRA: TStringField;
    FMemTableProdNaoTvDESCRICAO: TStringField;
    FMemTableProdNaoTvCODTV: TIntegerField;
    FMemTableProdTv: TFDMemTable;
    FMemTableProdTvCODBARRA: TStringField;
    FMemTableProdTvDESCRICAO: TStringField;
    FMemTableProdTvCODTV: TIntegerField;
    ToolBarBotao: TToolBar;
    BtnAdicionar: TRectangle;
    Label10: TLabel;
    BtnCancelar: TRectangle;
    Label11: TLabel;
    BtnExcluir: TRectangle;
    Label12: TLabel;
    BtnGravar: TRectangle;
    Label14: TLabel;
    BtnEditar: TRectangle;
    Label13: TLabel;
    procedure LstBoxTvsItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure BtnAdicionarProdTvClick(Sender: TObject);
    procedure BtnAdicionarTodosClick(Sender: TObject);
    procedure BtnRemoverProdTvClick(Sender: TObject);
    procedure BtnRemoverTodosClick(Sender: TObject);
    procedure BtnAdicionarClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure FramePesquisaTvsEdtPesquisaKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure FramePesquisaProdutosEdtPesquisaKeyDown(Sender: TObject;
      var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure FramePesquisaProdTvEdtPesquisaKeyDown(Sender: TObject;
      var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure FrameCabecalho1ImgFecharClick(Sender: TObject);
  private
    FStatusTela: String;
    FIdTv: Integer;
    FDescricaoTv: String;
    procedure CarregaTvs;
    procedure DetalharTv;
    procedure EnabledBtn(pBtnAdicionar, pEdita, pGravar, pExcluir, pCancelar: Boolean);
    procedure ListarTVs;
    procedure ListarProdNaoTv;
    procedure ListarProdutoTv;
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure CloseCadTVs;
  end;
var
  FrameCadTVs: TFrameCadTVs;

implementation

uses
  uDm, uMsgDialog;

{$R *.fmx}

{ TFrameCadTVs }

procedure TFrameCadTVs.BtnAdicionarClick(Sender: TObject);
begin
  FStatusTela         := 'ADICIONAR';
  EdtIdTv.Text        := '';
  EdtDescricaoTv.Text := '';
  FIdTv               := 0;
  LytCadTv.Enabled    := True;
  LytListaTv.Enabled  := False;

  ListarProdNaoTv;
  ListarProdutoTv;
  EnabledBtn(False,False,True,False,True);
end;

procedure TFrameCadTVs.BtnAdicionarProdTvClick(Sender: TObject);
begin
  FMemTableProdNaoTv.Filtered     := False;
  FMemTableProdNaoTv.Filter       := 'CodBarra = ' + LstBoxProdNaoTv.ListItems[LstBoxProdNaoTv.ItemIndex].TagString;
  FMemTableProdNaoTv.Filtered     := True;
  FMemTableProdTv.Insert;
  FMemTableProdTv.Fields[0].Value := FMemTableProdNaoTv.Fields[0].AsString;
  FMemTableProdTv.Fields[1].Value := FMemTableProdNaoTv.Fields[1].AsString;
  FMemTableProdTv.Post;
  FMemTableProdNaoTv.Delete;
  FMemTableProdNaoTv.Filtered     := False;

  ListarProdutoTv;
  ListarProdNaoTv;
end;

procedure TFrameCadTVs.BtnAdicionarTodosClick(Sender: TObject);
begin
  FMemTableProdNaoTv.Filtered     := False;
  FMemTableProdTv.Insert;
  FMemTableProdTv.Fields[0].Value := FMemTableProdNaoTv.Fields[0].AsString;
  FMemTableProdTv.Fields[1].Value := FMemTableProdNaoTv.Fields[1].AsString;
  FMemTableProdTv.Post;
  FMemTableProdNaoTv.Delete;

  ListarProdutoTv;
  ListarProdNaoTv;
end;

procedure TFrameCadTVs.BtnCancelarClick(Sender: TObject);
begin
  LytCadTv.Enabled    := False;
  LytListaTv.Enabled  := True;
  CarregaTvs;
  EnabledBtn(True,True,False,True,False);
end;


procedure TFrameCadTVs.BtnEditarClick(Sender: TObject);
begin
  FStatusTela         := 'EDITAR';
  LytCadTv.Enabled    := True;
  LytListaTv.Enabled  := False;
  EnabledBtn(False,False,True,False,True);
end;

procedure TFrameCadTVs.BtnExcluirClick(Sender: TObject);
begin
  if TuMessage.MensagemConfirmacao('Deseja realmente excluir a Tv?') then
  begin
    Dm.ExcluirTv(FIdTv);
    ListarTVs;
    LytCadTv.Enabled := False;
    LytListaTv.Enabled := True;
    EnabledBtn(True,True,False,True,False);
  end;
end;

procedure TFrameCadTVs.FrameCabecalho1ImgFecharClick(Sender: TObject);
begin
  CloseCadTVs;
end;

procedure TFrameCadTVs.FramePesquisaProdTvEdtPesquisaKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  vFilter: String;
  vParant: String;
begin
  vFilter := UpperCase('%' + FramePesquisaTvs.EdtPesquisa.Text + '%');
  case FramePesquisaProdTv.CBoxFiltro.ItemIndex of
    0:
      vParant := 'CODBARRA';
    1:
      vParant := 'DESCRICAO';
  end;

  FMemTableProdTv.Filtered  := False;
  FMemTableProdTv.Filter    := vParant + ' Like ' + QuotedStr(vFilter);
  FMemTableProdTv.Filtered  := True;
  ListarProdutoTv;
end;


procedure TFrameCadTVs.FramePesquisaProdutosEdtPesquisaKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  vFilter: String;
  vParant: String;
begin
  vFilter := UpperCase('%' + FramePesquisaProdutos.EdtPesquisa.Text + '%');
  case FramePesquisaProdutos.CBoxFiltro.ItemIndex of
    0:
      vParant := 'CODBARRA';
    1:
      vParant := 'DESCRICAO';
  end;
  FMemTableProdNaoTv.Filtered := False;
  FMemTableProdNaoTv.Filter   := vParant + ' Like ' + QuotedStr(vFilter);
  FMemTableProdNaoTv.Filtered := True;
  ListarProdNaoTv;
end;

procedure TFrameCadTVs.FramePesquisaTvsEdtPesquisaKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  vFilter: String;
  vParant: String;
begin
  vFilter := UpperCase('%' + FramePesquisaTvs.EdtPesquisa.Text + '%');
  case FramePesquisaTvs.CBoxFiltro.ItemIndex of
    0:
      vParant := 'IDTV';
    1:
      vParant := 'DESCRICAO';
  end;
  FMemTableTvs.Filtered := False;
  FMemTableTvs.Filter   := vParant + ' Like ' + QuotedStr(vFilter);
  FMemTableTvs.Filtered := True;
  ListarTVs;
end;

procedure TFrameCadTVs.BtnGravarClick(Sender: TObject);
begin
  if EdtDescricaoTv.Text = '' then
  begin
    ShowMessage('O nome da Tv deve ser infromado');
    exit;
  end;
  FDescricaoTv := EdtDescricaoTv.Text;
  if FStatusTela = 'ADICIONAR' then
    Dm.InsertTv(FDescricaoTv)
      .InsertProdutos(FMemTableProdTv);

  if FStatusTela = 'EDITAR' then
    Dm.UpdateTv(FDescricaoTv)
      .InsertProdutos(FMemTableProdTv);

  ListarTVs;
  DetalharTv;
  LytCadTv.Enabled := False;
  LytListaTv.Enabled := True;
  ShowMessage('Registro gravado com exito');
  EnabledBtn(True,True,False,True,False);
end;


procedure TFrameCadTVs.CarregaTvs;
begin
  ListarTVs;
  DetalharTv;
end;

procedure TFrameCadTVs.CloseCadTVs;
begin
  if Assigned(FrameCadTVs) then
  begin
    FrameCadTVs.Visible := False;
    FrameCadTVs.DisposeOf;
    FrameCadTVs := Nil;
  end;
end;

procedure TFrameCadTVs.BtnRemoverProdTvClick(Sender: TObject);
var
  vFilter: String;
begin
  if LstBoxProdTv.count > 0 then
  begin
    vFilter := LstBoxProdTv.ListItems[LstBoxProdTv.ItemIndex].TagString;
    FMemTableProdTv.Filtered  := False;
    FMemTableProdTv.Filter    := 'CodBarra = ' + vFilter;
    FMemTableProdTv.Filtered  := True;

    FMemTableProdTv.First;
    while not FMemTableProdTv.Eof do
    begin
      FMemTableProdNaoTv.Insert;
      FMemTableProdNaoTv.Fields[0].Value := FMemTableProdTv.Fields[0].AsString;
      FMemTableProdNaoTv.Fields[1].Value := FMemTableProdTv.Fields[1].AsString;
      FMemTableProdNaoTv.Post;
      FMemTableProdTv.Delete;
      FMemTableProdTv.Next;
    end;
    FMemTableProdTv.Filtered := False;
    ListarProdutoTv;
    ListarProdNaoTv;
  end
  else
    ShowMessage('Não a produto para ser removido da Tv');
end;

procedure TFrameCadTVs.BtnRemoverTodosClick(Sender: TObject);
begin
  if LstBoxProdTv.count > 0 then
  begin
    FMemTableProdTv.Filtered  := False;
    FMemTableProdTv.First;
    while not FMemTableProdTv.Eof do
    begin
      FMemTableProdNaoTv.Insert;
      FMemTableProdNaoTv.Fields[0].Value := FMemTableProdTv.Fields[0].AsString;
      FMemTableProdNaoTv.Fields[1].Value := FMemTableProdTv.Fields[1].AsString;
      FMemTableProdNaoTv.Post;
      FMemTableProdTv.Delete;
      FMemTableProdTv.Next;
    end;
    ListarProdutoTv;
    ListarProdNaoTv;
  end
  else
    ShowMessage('Não a produto para ser removido da Tv');

end;

constructor TFrameCadTVs.Create(AOwner: TComponent);
begin
  inherited;
  FrameCabecalho1.LblNomeDaTela.Text  := 'TVs';
  LytCadTv.Enabled                    := False;
  EdtIdTv.Enabled                     := False;
  ListarTVs;
end;

procedure TFrameCadTVs.DetalharTv;
begin
  FMemTableTvs.Filtered := False;
  FMemTableTvs.Filter   := 'IDTv = '+ IntToStr(FIdTv);
  FMemTableTvs.Filtered := True;

  EdtIdTv.Text := IntToStr(FIdTv);
  EdtIdTv.Text := FMemTableTvs.FieldByName('descricao').AsString;
  FMemTableTvs.Filtered := False;

  ListarProdNaoTv;
  ListarProdutoTv;
end;

procedure TFrameCadTVs.EnabledBtn(pBtnAdicionar, pEdita, pGravar, pExcluir,
  pCancelar: Boolean);
begin
  BtnAdicionar.Enabled  := pBtnAdicionar;
  BtnEditar.Enabled     := pEdita;
  BtnGravar.Enabled     := pGravar;
  BtnExcluir.Enabled    := pExcluir;
  BtnCancelar.Enabled   := pCancelar;
end;

procedure TFrameCadTVs.ListarTVs;
var
  vListBoxItem: TListBoxItem;
begin
  LblSemRegistroLstBoxTv.Visible := True;
  EnabledBtn(True,False,False,False,False);

  //Atualiza o DataSet;
  FMemTableTvs.Close;
  FMemTableTvs.Open;
  FMemTableTvs.EmptyDataSet;
  TFDMemTable(FMemTableTvs).CopyDataSet(Dm.DataSetTv);
  FMemTableTvs.Filtered := False;

  //Combox de pesquisa;
  FramePesquisaTvs.CBoxFiltro.Clear;
  FramePesquisaTvs.CBoxFiltro.Items.Add('Codigo Tv');
  FramePesquisaTvs.CBoxFiltro.Items.Add('Descrição');
  FramePesquisaTvs.CBoxFiltro.ItemIndex := 0;

  //Lista Tv ListaView;
  LstBoxTvs.Items.Clear;
  LstBoxTvs.BeginUpdate;
  try
    if FMemTableTvs.RecordCount > 0 then
    begin
      LblSemRegistroLstBoxTv.Visible := False;
      EnabledBtn(True,True,False,True,False);

      FMemTableTvs.First;
      while not FMemTableTvs.Eof do
      begin
        vListBoxItem                := TListBoxItem.Create(LstBoxTvs);
        vListBoxItem.Text           := '';
        vListBoxItem.align          := TAlignLayout.Client;
        vListBoxItem.StyleLookup    := 'listboxitembottomdetail';
        vListBoxItem.Height         := 40;
        vListBoxItem.TagString      := FMemTableTvsIDTV.AsString;
        vListBoxItem.ItemData.Text  := FMemTableTvsIDTV.AsString + ' - ' + FMemTableTvsDESCRICAO.AsString;
        LstBoxTvs.AddObject(vListBoxItem);

        if LstBoxTvs.count = 1 then
          vListBoxItem.IsSelected := True;
        FMemTableTvs.Next;
      end;

      FIdTv := StrToInt(LstBoxTvs.ListItems[LstBoxTvs.ItemIndex].TagString);
      FMemTableTvs.Filter := 'IdTv = ' + IntToStr(FIdTv);
      FMemTableTvs.Filtered := True;
      EdtIdTv.Text := FMemTableTvsIDTV.AsString;
      EdtDescricaoTv.Text := FMemTableTvsDESCRICAO.AsString;

      ListarProdNaoTv;
      ListarProdutoTv;
    end;

  finally
    LstBoxTvs.EndUpdate;
  end;

end;

procedure TFrameCadTVs.LstBoxTvsItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  FIdTv := StrToInt(Item.TagString);
  DetalharTv;
end;

procedure TFrameCadTVs.ListarProdutoTv;
var
  vListBoxItem: TListBoxItem;
begin
  LblSemRegistroProdTv.Visible  := True;
  BtnRemoverProdTv.Enabled      := False;
  BtnRemoverTodos.Enabled       := False;

  //Atualiza o DataSet;
  FMemTableProdTv.Close;
  FMemTableProdTv.Open;
  FMemTableProdTv.EmptyDataSet;
  TFDMemTable(FMemTableProdTv).CopyDataSet(Dm.DataSetProduto(FIdTv));
  FMemTableProdNaoTv.Filtered := False;

  //Listar Protudos da Tv;
  LstBoxProdTv.Items.Clear;
  LstBoxProdTv.BeginUpdate;
  try
    if FMemTableProdTv.RecordCount > 0 then
    begin
      LblSemRegistroProdTv.Visible := False;
      BtnRemoverProdTv.Enabled     := True;
      BtnRemoverTodos.Enabled      := True;

      FMemTableProdTv.First;
      while not FMemTableProdTv.Eof do
      begin
        vListBoxItem                := TListBoxItem.Create(LstBoxProdTv);
        vListBoxItem.Text           := '';
        vListBoxItem.align          := TAlignLayout.Client;
        vListBoxItem.StyleLookup    := 'listboxitembottomdetail';
        vListBoxItem.Height         := 40;
        vListBoxItem.TagString      :=  FMemTableProdNaoTvCODBARRA.AsString;;
        vListBoxItem.ItemData.Text  := FMemTableProdNaoTvCODBARRA.AsString + ' - ' + FMemTableProdNaoTvDESCRICAO.AsString;
        LstBoxProdTv.AddObject(vListBoxItem);

        if LstBoxProdTv.count = 1 then
          vListBoxItem.IsSelected   := True;
        FMemTableProdNaoTv.Next;
        FMemTableProdTv.Next;
      end;
    end;
  finally
    LstBoxProdTv.EndUpdate;
  end;
end;

procedure TFrameCadTVs.ListarProdNaoTv;
var
  vListBoxItem: TListBoxItem;
begin
  LblSemRegistroProdNaoTv.Visible := True;
  BtnAdicionarProdTv.Enabled      := False;
  BtnAdicionarTodos.Enabled       := False;

  //Atualiza o DataSet;
  FMemTableProdNaoTv.Close;
  FMemTableProdNaoTv.Open;
  FMemTableProdNaoTv.EmptyDataSet;
  TFDMemTable(FMemTableProdNaoTv).CopyDataSet(Dm.DataSetProdNaoTv(FIdTv));
  FMemTableProdNaoTv.Filtered := False;

  //Adiciona os filtro de pesquisa
  FramePesquisaProdutos.CBoxFiltro.Clear;
  FramePesquisaProdutos.CBoxFiltro.Items.Add('Codigo Barra');
  FramePesquisaProdutos.CBoxFiltro.Items.Add('Descrição');
  FramePesquisaProdutos.CBoxFiltro.ItemIndex := 0;

  //Listar ProdutosNaoTv;
  LstBoxProdNaoTv.Items.Clear;
  LstBoxProdNaoTv.BeginUpdate;
  try
    if FMemTableProdNaoTv.RecordCount > 0 then
    begin
      LblSemRegistroProdNaoTv.Visible := False;
      BtnAdicionarProdTv.Enabled      := True;
      BtnAdicionarTodos.Enabled       := True;

      FMemTableProdNaoTv.First;
      while not FMemTableProdNaoTv.Eof do
      begin
        vListBoxItem := TListBoxItem.Create(LstBoxProdTv);
        vListBoxItem.Text           := '';
        vListBoxItem.align          := TAlignLayout.Client;
        vListBoxItem.StyleLookup    := 'listboxitembottomdetail';
        vListBoxItem.Height         := 40;
        vListBoxItem.TagString      := FMemTableProdNaoTvCODBARRA.AsString;;
        vListBoxItem.ItemData.Text  :=
          FMemTableProdNaoTvCODBARRA.AsString + ' - ' + FMemTableProdNaoTvDESCRICAO.AsString;
        LstBoxProdNaoTv.AddObject(vListBoxItem);

        if LstBoxProdTv.count = 1 then
          vListBoxItem.IsSelected   := True;
        FMemTableProdNaoTv.Next;
      end;
    end;
  finally
    LstBoxProdNaoTv.EndUpdate;
  end;
end;

end.
