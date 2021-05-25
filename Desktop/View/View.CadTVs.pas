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
    LytProdutoNotTV: TLayout;
    LstProdutosNotTV: TListBox;
    LblSemRegProdutosNotTV: TLabel;
    FramePesqProdutosNotTV: TFramePesquisa;
    LytProdutosCadTv: TLayout;
    LstProdutosCadTV: TListBox;
    LblSemRegProdutosCadTV: TLabel;
    FramePesqProdutosCadTV: TFramePesquisa;
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
    LblSemRegTVs: TLabel;
    FramePesquisaTvs: TFramePesquisa;
    FrameCabecalho1: TFrameCabecalho;
    DS_TVs: TFDMemTable;
    DS_TVsIDTV: TIntegerField;
    DS_TVsDESCRICAO: TStringField;
    DS_ProdutosNotTV: TFDMemTable;
    DS_ProdutosNotTVCODBARRA: TStringField;
    DS_ProdutosNotTVDESCRICAO: TStringField;
    DS_ProdutosCadTV: TFDMemTable;
    DS_ProdutosCadTVCODBARRA: TStringField;
    DS_ProdutosCadTVDESCRICAO: TStringField;
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
    procedure FramePesqProdutosNotTVEdtPesquisaKeyDown(Sender: TObject;
      var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure FramePesqProdutosCadTVEdtPesquisaKeyDown(Sender: TObject;
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
    procedure ListarProdutosNotTV;
    procedure ListarProdutoCadTV;
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

  ListarProdutosNotTV;
  ListarProdutoCadTV;
  EnabledBtn(False,False,True,False,True);
end;

procedure TFrameCadTVs.BtnAdicionarProdTvClick(Sender: TObject);
begin
  if LstProdutosNotTV.Index < 0 then
  begin
    ShowMessage('Produtos nao selecionado');
    Exit;
  end;

  DS_ProdutosNotTV.Filtered     := False;
  DS_ProdutosNotTV.Filter       := 'CodBarra = ' + QuotedStr(LstProdutosNotTV.ListItems[LstProdutosNotTV.ItemIndex].TagString);
  DS_ProdutosNotTV.Filtered     := True;
  DS_ProdutosCadTV.Insert;
  DS_ProdutosCadTV.Fields[0].Value := DS_ProdutosNotTVCODBARRA.AsString;
  DS_ProdutosCadTV.Fields[1].Value := DS_ProdutosNotTVDESCRICAO.AsString;
  DS_ProdutosCadTV.Post;
  DS_ProdutosNotTV.Delete;
  DS_ProdutosNotTV.Filtered     := False;
  DS_ProdutosCadTV.Filtered     := False;
  ListarProdutoCadTV;
  ListarProdutosNotTV;
end;

procedure TFrameCadTVs.BtnAdicionarTodosClick(Sender: TObject);
begin
  DS_ProdutosNotTV.Filtered     := False;
  DS_ProdutosCadTV.Insert;
  DS_ProdutosCadTV.Fields[0].Value := DS_ProdutosNotTV.Fields[0].AsString;
  DS_ProdutosCadTV.Fields[1].Value := DS_ProdutosNotTV.Fields[1].AsString;
  DS_ProdutosCadTV.Post;
  DS_ProdutosNotTV.Delete;

  ListarProdutoCadTV;
  ListarProdutosNotTV;
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

procedure TFrameCadTVs.FramePesqProdutosCadTVEdtPesquisaKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  vFilter: String;
  vParant: String;
begin
  vFilter := UpperCase('%' + FramePesquisaTvs.EdtPesquisa.Text + '%');
  case FramePesqProdutosCadTV.CBoxFiltro.ItemIndex of
    0:
      vParant := 'CODBARRA';
    1:
      vParant := 'DESCRICAO';
  end;

  DS_ProdutosCadTV.Filtered  := False;
  DS_ProdutosCadTV.Filter    := vParant + ' Like ' + vFilter;
  DS_ProdutosCadTV.Filtered  := True;
  ListarProdutoCadTV;
end;


procedure TFrameCadTVs.FramePesqProdutosNotTVEdtPesquisaKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  vFilter: String;
  vParant: String;
begin
  vFilter := UpperCase('%' + FramePesqProdutosNotTV.EdtPesquisa.Text + '%');
  case FramePesqProdutosNotTV.CBoxFiltro.ItemIndex of
    0:
      vParant := 'CODBARRA';
    1:
      vParant := 'DESCRICAO';
  end;
  DS_ProdutosNotTV.Filtered := False;
  DS_ProdutosNotTV.Filter   := vParant + ' Like ' + vFilter;
  DS_ProdutosNotTV.Filtered := True;
  ListarProdutosNotTV;
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
  DS_TVs.Filtered := False;
  DS_TVs.Filter   := vParant + ' Like ' + vFilter;
  DS_TVs.Filtered := True;
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
    Dm
      .InsertTv(FDescricaoTv)
      .InsertProdutos(DS_ProdutosCadTV);

  if FStatusTela = 'EDITAR' then
    Dm
      .UpdateTv(FIDTV,FDescricaoTv)
      .InsertProdutos(DS_ProdutosCadTV);

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
  if LstProdutosCadTV.count > 0 then
  begin
    vFilter := LstProdutosCadTV.ListItems[LstProdutosCadTV.ItemIndex].TagString;
    DS_ProdutosCadTV.Filtered  := False;
    DS_ProdutosCadTV.Filter    := 'CodBarra = ' + vFilter;
    DS_ProdutosCadTV.Filtered  := True;

    DS_ProdutosCadTV.First;
    while not DS_ProdutosCadTV.Eof do
    begin
      DS_ProdutosNotTV.Insert;
      DS_ProdutosNotTV.Fields[0].Value := DS_ProdutosCadTV.Fields[0].AsString;
      DS_ProdutosNotTV.Fields[1].Value := DS_ProdutosCadTV.Fields[1].AsString;
      DS_ProdutosNotTV.Post;
      DS_ProdutosCadTV.Delete;
      DS_ProdutosCadTV.Next;
    end;
    DS_ProdutosCadTV.Filtered := False;
    ListarProdutoCadTV;
    ListarProdutosNotTV;
  end
  else
    ShowMessage('Não a produto para ser removido da Tv');
end;

procedure TFrameCadTVs.BtnRemoverTodosClick(Sender: TObject);
begin
  if LstProdutosCadTV.count > 0 then
  begin
    DS_ProdutosCadTV.Filtered  := False;
    DS_ProdutosCadTV.First;
    while not DS_ProdutosCadTV.Eof do
    begin
      DS_ProdutosNotTV.Insert;
      DS_ProdutosNotTV.Fields[0].Value := DS_ProdutosCadTV.Fields[0].AsString;
      DS_ProdutosNotTV.Fields[1].Value := DS_ProdutosCadTV.Fields[1].AsString;
      DS_ProdutosNotTV.Post;
      DS_ProdutosCadTV.Delete;
      DS_ProdutosCadTV.Next;
    end;
    ListarProdutoCadTV;
    ListarProdutosNotTV;
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
  FIdTv := StrToInt(LstBoxTvs.ListItems[LstBoxTvs.ItemIndex].TagString);
  DS_TVs.Filter := 'IdTv = ' + IntToStr(FIdTv);
  DS_TVs.Filtered := True;
  EdtIdTv.Text := DS_TVsIDTV.AsString;
  EdtDescricaoTv.Text := DS_TVsDESCRICAO.AsString;
  DS_TVs.Filtered := False;

  //PRODUTOSNOTTV
  DS_ProdutosNotTV.Close;
  DS_ProdutosNotTV.Open;
  DS_ProdutosNotTV.EmptyDataSet;
  TFDMemTable(DS_ProdutosNotTV).CopyDataSet(Dm.DS_ProdutosNotTV(FIdTv));
  DS_ProdutosNotTV.Filtered := False;

  FramePesqProdutosNotTV.CBoxFiltro.Clear;
  FramePesqProdutosNotTV.CBoxFiltro.Items.Add('Codigo Barra');
  FramePesqProdutosNotTV.CBoxFiltro.Items.Add('Descrição');
  FramePesqProdutosNotTV.CBoxFiltro.ItemIndex := 0;
  ListarProdutosNotTV;

  //PRODUTOSCADTV
  DS_ProdutosCadTV.Close;
  DS_ProdutosCadTV.Open;
  DS_ProdutosCadTV.EmptyDataSet;
  TFDMemTable(DS_ProdutosCadTV).CopyDataSet(Dm.DS_ProdutosCadTV(FIdTv));
  DS_ProdutosNotTV.Filtered := False;

  FramePesqProdutosCadTV.CBoxFiltro.Clear;
  FramePesqProdutosCadTV.CBoxFiltro.Items.Add('Codigo Barra');
  FramePesqProdutosCadTV.CBoxFiltro.Items.Add('Descrição');
  FramePesqProdutosCadTV.CBoxFiltro.ItemIndex := 0;
  ListarProdutoCadTV;
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
  LblSemRegTVs.Visible := True;
  EnabledBtn(True,False,False,False,False);

  //Atualiza o DataSet;
  DS_TVs.Close;
  DS_TVs.Open;
  DS_TVs.EmptyDataSet;
  TFDMemTable(DS_TVs).CopyDataSet(Dm.DataSetTv);
  DS_TVs.Filtered := False;

  //Combox de pesquisa;
  FramePesquisaTvs.CBoxFiltro.Clear;
  FramePesquisaTvs.CBoxFiltro.Items.Add('Codigo Tv');
  FramePesquisaTvs.CBoxFiltro.Items.Add('Descrição');
  FramePesquisaTvs.CBoxFiltro.ItemIndex := 0;

  //Lista Tv ListaView;
  LstBoxTvs.Items.Clear;
  LstBoxTvs.BeginUpdate;
  try
    if DS_TVs.RecordCount > 0 then
    begin
      LblSemRegTVs.Visible := False;
      EnabledBtn(True,True,False,True,False);

      DS_TVs.First;
      while not DS_TVs.Eof do
      begin
        vListBoxItem                := TListBoxItem.Create(LstBoxTvs);
        vListBoxItem.Text           := '';
        vListBoxItem.align          := TAlignLayout.Client;
        vListBoxItem.StyleLookup    := 'listboxitembottomdetail';
        vListBoxItem.Height         := 40;
        vListBoxItem.TagString      := DS_TVsIDTV.AsString;
        vListBoxItem.ItemData.Text  := DS_TVsIDTV.AsString + ' - ' + DS_TVsDESCRICAO.AsString;
        LstBoxTvs.AddObject(vListBoxItem);

        if LstBoxTvs.count = 1 then
          vListBoxItem.IsSelected := True;
        DS_TVs.Next;
      end;
      DetalharTV;
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

procedure TFrameCadTVs.ListarProdutoCadTV;
var
  vListBoxItem: TListBoxItem;
begin
  LblSemRegProdutosCadTV.Visible  := True;
  BtnRemoverProdTv.Enabled      := False;
  BtnRemoverTodos.Enabled       := False;

  //Listar Protudos da Tv;
  LstProdutosCadTV.Items.Clear;
  LstProdutosCadTV.BeginUpdate;
  try
    if DS_ProdutosCadTV.RecordCount > 0 then
    begin
      LblSemRegProdutosCadTV.Visible := False;
      BtnRemoverProdTv.Enabled     := True;
      BtnRemoverTodos.Enabled      := True;

      DS_ProdutosCadTV.First;
      while not DS_ProdutosCadTV.Eof do
      begin
        vListBoxItem                := TListBoxItem.Create(LstProdutosCadTV);
        vListBoxItem.Text           := '';
        vListBoxItem.align          := TAlignLayout.Client;
        vListBoxItem.StyleLookup    := 'listboxitembottomdetail';
        vListBoxItem.Height         := 40;
        vListBoxItem.TagString      :=  DS_ProdutosCadTVCODBARRA.AsString;;
        vListBoxItem.ItemData.Text  := DS_ProdutosCadTVCODBARRA.AsString + ' - ' + DS_ProdutosCadTVDESCRICAO.AsString;
        LstProdutosCadTV.AddObject(vListBoxItem);

        if LstProdutosCadTV.count = 1 then
          vListBoxItem.IsSelected   := True;
        DS_ProdutosCadTV.Next;
      end;
    end;
  finally
    LstProdutosCadTV.EndUpdate;
  end;
end;

procedure TFrameCadTVs.ListarProdutosNotTV;
var
  vListBoxItem: TListBoxItem;
begin
  LblSemRegProdutosNotTV.Visible := True;
  BtnAdicionarProdTv.Enabled      := False;
  BtnAdicionarTodos.Enabled       := False;

  //Listar ProdutosNaoTv;
  LstProdutosNotTV.Items.Clear;
  LstProdutosNotTV.BeginUpdate;
  try
    if DS_ProdutosNotTV.RecordCount > 0 then
    begin
      LblSemRegProdutosNotTV.Visible := False;
      BtnAdicionarProdTv.Enabled      := True;
      BtnAdicionarTodos.Enabled       := True;

      DS_ProdutosNotTV.First;
      while not DS_ProdutosNotTV.Eof do
      begin
        vListBoxItem := TListBoxItem.Create(LstProdutosNotTV);
        vListBoxItem.Text           := '';
        vListBoxItem.align          := TAlignLayout.Client;
        vListBoxItem.StyleLookup    := 'listboxitembottomdetail';
        vListBoxItem.Height         := 40;
        vListBoxItem.TagString      := DS_ProdutosNotTVCODBARRA.AsString;
        vListBoxItem.ItemData.Text  := DS_ProdutosNotTVCODBARRA.AsString + ' - ' + DS_ProdutosNotTVDESCRICAO.AsString;
        LstProdutosNotTV.AddObject(vListBoxItem);

        if LstProdutosNotTV.count = 1 then
          vListBoxItem.IsSelected   := True;
        DS_ProdutosNotTV.Next;
      end;
    end;
  finally
    LstProdutosNotTV.EndUpdate;
  end;
end;

end.
