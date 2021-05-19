unit View.FrmTvs;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Edit, FMX.Layouts,
  FMX.ListBox, View.Frame.Pesquisa, FMX.StdCtrls, FMX.Controls.Presentation,
  View.Frame.Cabecalho, Controller.oTvs, Controller.uTvs, FMX.Objects;

type
  TViewFrmTvs = class(TForm)
    LytCadTv: TLayout;
    LytProdTv: TLayout;
    ToolBarBotao: TToolBar;
    Label5: TLabel;
    LytCadProd: TLayout;
    LstBoxProdNaoTv: TListBox;
    LytProdTvs: TLayout;
    LstBoxProdTv: TListBox;
    LytBotao: TLayout;
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
    FMemTableProdNaoTv: TFDMemTable;
    FMemTableProdTv: TFDMemTable;
    FMemTableTvs: TFDMemTable;
    FramePesquisaTvs: TFramePesquisa;
    FramePesquisaProdutos: TFramePesquisa;
    FrameCabecalho: TFrameCabecalho;
    FMemTableTvsIDTV: TIntegerField;
    FMemTableTvsDESCRICAO: TStringField;
    LblSemRegistroLstBoxTv: TLabel;
    LblSemRegistroLstBoxProd: TLabel;
    FMemTableProdNaoTvCODBARRA: TStringField;
    FMemTableProdNaoTvDESCRICAO: TStringField;
    FMemTableProdNaoTvCODTV: TIntegerField;
    FMemTableProdTvCODBARRA: TStringField;
    FMemTableProdTvDESCRICAO: TStringField;
    FMemTableProdTvCODTV: TIntegerField;
    FramePesquisaProdTv: TFramePesquisa;
    BtnAdicionarProdTv: TRectangle;
    Label6: TLabel;
    BtnRemoverProdTv: TRectangle;
    Label7: TLabel;
    BtnRemoverTodos: TRectangle;
    Label8: TLabel;
    BtnAdicionarTodos: TRectangle;
    Label9: TLabel;
    LblSemRegistroProdTv: TLabel;
    BtnAdicionar: TRectangle;
    BtnCancelar: TRectangle;
    BtnExcluir: TRectangle;
    BtnGravar: TRectangle;
    BtnEditar: TRectangle;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    procedure FormShow(Sender: TObject);
    procedure LstBoxTvsItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure BtnAdicionarProdTvClick(Sender: TObject);
    procedure BtnRemoverProdTvClick(Sender: TObject);
    procedure BtnAdicionarTodosClick(Sender: TObject);
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
  private
    oTvs: ToTvs;
    FStatusTela: String;
    procedure AdicinarProdutoTv;
    procedure AdicionarTodosProdutoTv;
    procedure AdicionarTv;
    procedure Cancelar;
    procedure CarregaTvs;
    procedure CarregaProdNaoTv;
    procedure CarregaProdutoTv;
    procedure CloseViewTvs;
    procedure DetalharCadTvs;
    procedure EditarTv;
    procedure EnabledButton(pBtnAdicionar, pEdita, pGravar, pExcluir, pCancelar: Boolean);
    procedure ExcluirTv;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function GetCBoxPesquisaTv: String;
    function GetCBoxPesquisaProduto: String;
    function GetCBoxPesquisaProdTv: String;
    procedure GravarTv;
    procedure InicializaViewCadTvs;
    procedure ListarTVs;
    procedure ListarProdNaoTv;
    procedure ListarProdutoTv;
    procedure RemoverProdutoTv;
    procedure RemoverTodosProdutosTv;
    procedure PesquisarTvs;
    procedure PesquisarProdutos;
    procedure PesquisarProdutoTv;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewFrmTvs: TViewFrmTvs;

implementation

uses
  Controller.uFarctory,
  Controller.uMessageDialog;

{$R *.fmx}

procedure TViewFrmTvs.AdicinarProdutoTv;
begin

  if LstBoxProdNaoTv.count > 0 then
  begin

    oTvs.MoverProduto(FMemTableProdNaoTv, FMemTableProdTv,
      LstBoxProdNaoTv.ListItems[LstBoxProdNaoTv.ItemIndex].TagString);
    ListarProdutoTv;
    ListarProdNaoTv;

  end
  else
    ShowMessage('Não a produto para ser adicionado na Tv');

end;

procedure TViewFrmTvs.AdicionarTodosProdutoTv;
begin

  if LstBoxProdNaoTv.count > 0 then
  begin

    oTvs.MoverProduto(FMemTableProdNaoTv, FMemTableProdTv);
    ListarProdutoTv;
    ListarProdNaoTv;

  end
  else
    ShowMessage('Não a produto para ser adicionado na Tv');

end;

procedure TViewFrmTvs.AdicionarTv;
begin

  FStatusTela := 'ADICIONAR';

  EdtIdTv.Text := '';
  EdtDescricaoTv.Text := '';

  LytCadTv.Enabled := True;
  LytListaTv.Enabled := False;
  oTvs.IdTv := 0;

  CarregaProdNaoTv;
  CarregaProdutoTv;
  EnabledButton(False,False,True,False,True);

end;

procedure TViewFrmTvs.BtnAdicionarClick(Sender: TObject);
begin
  AdicionarTv;
end;

procedure TViewFrmTvs.BtnAdicionarProdTvClick(Sender: TObject);
begin
  AdicinarProdutoTv;

end;

procedure TViewFrmTvs.BtnAdicionarTodosClick(Sender: TObject);
begin
  AdicionarTodosProdutoTv;
end;

procedure TViewFrmTvs.BtnCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TViewFrmTvs.BtnEditarClick(Sender: TObject);
begin
  EditarTv;
end;

procedure TViewFrmTvs.BtnExcluirClick(Sender: TObject);
begin
  ExcluirTv;
end;

procedure TViewFrmTvs.BtnGravarClick(Sender: TObject);
begin
  GravarTv;
end;

procedure TViewFrmTvs.BtnRemoverProdTvClick(Sender: TObject);
begin
  RemoverProdutoTv;
end;

procedure TViewFrmTvs.BtnRemoverTodosClick(Sender: TObject);
begin
  RemoverTodosProdutosTv;
end;

procedure TViewFrmTvs.Cancelar;
begin

  LytCadTv.Enabled := False;
  LytListaTv.Enabled := True;
  CarregaTvs;
  EnabledButton(True,True,False,True,False);

end;

procedure TViewFrmTvs.CarregaProdNaoTv;
begin

  //Adiciona os filtro de pesquisa
  FramePesquisaProdutos.CBoxFiltro.Clear;
  FramePesquisaProdutos.CBoxFiltro.Items.Add('Codigo Barra');
  FramePesquisaProdutos.CBoxFiltro.Items.Add('Descrição');
  FramePesquisaProdutos.CBoxFiltro.ItemIndex := 0;

  uTvs.CarregaDataSetProdutos(FMemTableProdNaoTv, oTvs.IdTv);
  ListarProdNaoTv;

end;

procedure TViewFrmTvs.CarregaProdutoTv;
begin

  //Adiciona os filtro de pesquisa
  FramePesquisaProdTv.CBoxFiltro.Clear;
  FramePesquisaProdTv.CBoxFiltro.Items.Add('Codigo Barra');
  FramePesquisaProdTv.CBoxFiltro.Items.Add('Descrição');
  FramePesquisaProdTv.CBoxFiltro.ItemIndex := 0;

  uTvs.CarregaDataSetProdTvs(FMemTableProdTv, oTvs.IdTv);
  ListarProdutoTv;

end;

procedure TViewFrmTvs.CarregaTvs;
begin

  FramePesquisaTvs.CBoxFiltro.Clear;
  FramePesquisaTvs.CBoxFiltro.Items.Add('Codigo Tv');
  FramePesquisaTvs.CBoxFiltro.Items.Add('Descrição');
  FramePesquisaTvs.CBoxFiltro.ItemIndex := 0;

  uTvs.CarergaDataSetTv(FMemTableTvs);
  ListarTVs;
  DetalharCadTvs;

end;

procedure TViewFrmTvs.CloseViewTvs;
begin
  FreeAndNil(oTvs);
  FreeAndNil(uTvs);
  uFarctory.TvsDestroyView;

end;

procedure TViewFrmTvs.DetalharCadTvs;
begin

  oTvs.IdTv := StrToInt(oTvs.GetTagStringListBox(LstBoxTvs));
  try
    FMemTableTvs.Filter := 'IdTv = ' + IntToStr(oTvs.IdTv);
    FMemTableTvs.Filtered := True;

    EdtIdTv.Text := FMemTableTvsIDTV.AsString;
    EdtDescricaoTv.Text := FMemTableTvsDESCRICAO.AsString;

    CarregaProdNaoTv;
    CarregaProdutoTv;

  except
    raise;

  end;

end;

procedure TViewFrmTvs.EditarTv;
begin
  FStatusTela := 'EDITAR';

  LytCadTv.Enabled := True;
  LytListaTv.Enabled := False;
  EnabledButton(False,False,True,False,True);

end;

procedure TViewFrmTvs.EnabledButton(pBtnAdicionar, pEdita, pGravar, pExcluir,
  pCancelar: Boolean);
begin

  BtnAdicionar.Enabled := pBtnAdicionar;
  BtnEditar.Enabled := pEdita;
  BtnGravar.Enabled := pGravar;
  BtnExcluir.Enabled := pExcluir;
  BtnCancelar.Enabled := pCancelar;

end;

procedure TViewFrmTvs.ExcluirTv;
begin

  if TuMessage.MensagemConfirmacao('Deseja realmente excluir a tv?') then
  begin
    if uTvs.DeletarTv(oTvs) then
      ShowMessage('Tv Exluida');
    CarregaTvs;

     LytCadTv.Enabled := False;
     LytListaTv.Enabled := True;

     EnabledButton(True,True,False,True,False);
  end;
  
end;

procedure TViewFrmTvs.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseViewTvs;

end;

procedure TViewFrmTvs.FormShow(Sender: TObject);
begin
  InicializaViewCadTvs;

end;

procedure TViewFrmTvs.FramePesquisaProdTvEdtPesquisaKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  If KeyChar = #0 then
    PesquisarProdutoTv;
end;

procedure TViewFrmTvs.FramePesquisaProdutosEdtPesquisaKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  If KeyChar = #0 then;
    PesquisarProdutos;
end;

procedure TViewFrmTvs.FramePesquisaTvsEdtPesquisaKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  If KeyChar = #0 then
    PesquisarTvs;
end;


function TViewFrmTvs.GetCBoxPesquisaTv: String;
begin

  case FramePesquisaTvs.CBoxFiltro.ItemIndex of
    0:
      Result := 'IDTV';
    1:
      Result := 'DESCRICAO';
  end;

end;

procedure TViewFrmTvs.GravarTv;
begin

  //Valida Nome da Tvs;
  if EdtDescricaoTv.Text = '' then
  begin
    ShowMessage('O nome da Tv deve ser infromado');
    exit;
  end;

  try
    try
      oTvs.Descricao := EdtDescricaoTv.Text;

      if FStatusTela = 'ADICIONAR' then
      begin
        uTvs.InseriTv(oTvs, FMemTableProdTv);
      end;

      if FStatusTela = 'EDITAR' then
      begin
        uTvs.UpdateTv(oTvs, FMemTableProdTv);
      end;

      CarregaTvs;
      LytCadTv.Enabled := False;
      LytListaTv.Enabled := True;
      ShowMessage('Registro gravado com exito');
      EnabledButton(True,True,False,True,False);

    except
      on E: Exception do
      begin
        ShowMessage('Erro ao Gravar: ' + E.Message);
      end;

    end;

  finally
    FreeAndNil(uTvs);
  end;

end;

procedure TViewFrmTvs.InicializaViewCadTvs;
begin

  try
    oTvs := ToTvs.Create;
    uTvs := TuTvs.Create;

    FrameCabecalho.LblNomeDaTela.Text := 'TVs';
    LytCadTv.Enabled := False;
    EdtIdTv.Enabled := False;
    CarregaTvs;

  except
    on E: Exception do
    begin
      ShowMessage('Erro :' + E.Message);
      CloseViewTvs;
    end;

  end;

end;

procedure TViewFrmTvs.ListarProdutoTv;
var
  vCodBarra, vDescricao: String;

  procedure AddItemLstBoxProdNaoTv;
  var
    vItem: TListBoxItem;
  begin

    try

      vItem := TListBoxItem.Create(LstBoxProdTv);
      vItem.Text := '';
      vItem.align := TAlignLayout.Client;
      vItem.StyleLookup := 'listboxitembottomdetail';
      vItem.Height := 40;
      vItem.TagString := vCodBarra;
      vItem.ItemData.Text := vCodBarra + ' - ' + vDescricao;

      LstBoxProdTv.AddObject(vItem);

      if LstBoxProdTv.count = 1 then
        vItem.IsSelected := True;

    except
      raise
    end;

  end;

begin

  LstBoxProdTv.Items.Clear;
  LstBoxProdTv.BeginUpdate;
  try

    LblSemRegistroProdTv.Visible := True;
    BtnRemoverProdTv.Enabled := False;
    BtnRemoverTodos.Enabled := False;


    if FMemTableProdTv.RecordCount > 0 then
    begin
      LblSemRegistroProdTv.Visible := False;
      BtnRemoverProdTv.Enabled := True;
      BtnRemoverTodos.Enabled := True;

      FMemTableProdTv.First;
      while not FMemTableProdTv.Eof do
      begin
        vCodBarra := FMemTableProdTvCODBARRA.AsString;
        vDescricao := FMemTableProdTvDESCRICAO.AsString;

        AddItemLstBoxProdNaoTv;

        FMemTableProdTv.Next;
      end;

    end;
  finally
    LstBoxProdTv.EndUpdate;
  end;

end;

procedure TViewFrmTvs.ListarProdNaoTv;
var
  vCodBarra, vDescricao: String;

  procedure AddItemLstBoxProdNaoTv;
  var
    vItem: TListBoxItem;
  begin

    try
      vItem := TListBoxItem.Create(LstBoxProdNaoTv);
      vItem.Text := '';
      vItem.align := TAlignLayout.Client;
      vItem.StyleLookup := 'listboxitembottomdetail';
      vItem.Height := 40;
      vItem.TagString := vCodBarra;
      vItem.ItemData.Text := vCodBarra + ' - ' + vDescricao;
      LstBoxProdNaoTv.AddObject(vItem);
      if LstBoxProdNaoTv.count = 1 then
        vItem.IsSelected := True;

    except
      raise
    end;

  end;

begin

  LstBoxProdNaoTv.Items.Clear;
  LstBoxProdNaoTv.BeginUpdate;
  try

    LblSemRegistroLstBoxProd.Visible := True;
    BtnAdicionarProdTv.Enabled := False;
    BtnAdicionarTodos.Enabled := False;

    if FMemTableProdNaoTv.RecordCount > 0 then
    begin
      LblSemRegistroLstBoxProd.Visible := False;
      BtnAdicionarProdTv.Enabled := True;
      BtnAdicionarTodos.Enabled := True;

      FMemTableProdNaoTv.First;
      while not FMemTableProdNaoTv.Eof do
      begin
        vCodBarra := FMemTableProdNaoTvCODBARRA.AsString;
        vDescricao := FMemTableProdNaoTvDESCRICAO.AsString;

        AddItemLstBoxProdNaoTv;
        FMemTableProdNaoTv.Next;
      end;

    end;
  finally
    LstBoxProdNaoTv.EndUpdate;
  end;
end;

procedure TViewFrmTvs.ListarTVs;
var
  vIdTv, vDescricao: String;

  procedure AddItemLisBoxTvs;
  var
    vItem: TListBoxItem;
  begin

    try

      vItem := TListBoxItem.Create(LstBoxTvs);
      vItem.Text := '';
      vItem.align := TAlignLayout.Client;
      vItem.StyleLookup := 'listboxitembottomdetail';
      vItem.Height := 40;
      vItem.TagString := vIdTv;
      vItem.ItemData.Text := vIdTv + ' - ' + vDescricao;

      LstBoxTvs.AddObject(vItem);

      if LstBoxTvs.count = 1 then
        vItem.IsSelected := True;

    except
      raise
    end;

  end;

begin

  LstBoxTvs.Items.Clear;
  LstBoxTvs.BeginUpdate;
  try

    LblSemRegistroLstBoxTv.Visible := True;
    EnabledButton(True,False,False,False,False);
    if FMemTableTvs.RecordCount > 0 then
    begin
      LblSemRegistroLstBoxTv.Visible := False;
      EnabledButton(True,True,False,True,False);

      FMemTableTvs.First;
      while not FMemTableTvs.Eof do
      begin
        vIdTv := FMemTableTvsIDTV.AsString;
        vDescricao := FMemTableTvsDESCRICAO.AsString;

        AddItemLisBoxTvs;
        FMemTableTvs.Next;
      end;
    end;

    oTvs.IdTv := StrToInt(oTvs.GetTagStringListBox(LstBoxTvs));
    
  finally
    LstBoxTvs.EndUpdate;
  end;

end;

procedure TViewFrmTvs.LstBoxTvsItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  DetalharCadTvs;
end;

procedure TViewFrmTvs.PesquisarProdutoTv;
var
  vFiltro: String;
begin

  vFiltro := UpperCase('%' + FramePesquisaTvs.EdtPesquisa.Text + '%');
  FMemTableProdTv.Filtered := False;
  FMemTableProdTv.Filter := GetCBoxPesquisaProdTv + ' Like ' +
    QuotedStr(vFiltro);
  FMemTableProdTv.Filtered := True;
  ListarProdutoTv;

end;

procedure TViewFrmTvs.PesquisarProdutos;
var
  vFiltro: String;
begin

  vFiltro := UpperCase('%' + FramePesquisaProdutos.EdtPesquisa.Text + '%');
  FMemTableProdNaoTv.Filtered := False;
  FMemTableProdNaoTv.Filter := GetCBoxPesquisaProduto + ' Like ' +
    QuotedStr(vFiltro);
  FMemTableProdNaoTv.Filtered := True;
  ListarProdNaoTv;

end;

procedure TViewFrmTvs.PesquisarTvs;
var
  vFiltro: String;
begin

  vFiltro := UpperCase('%' + FramePesquisaTvs.EdtPesquisa.Text + '%');
  FMemTableTvs.Filtered := False;
  FMemTableTvs.Filter := GetCBoxPesquisaTv + ' Like ' + QuotedStr(vFiltro);
  FMemTableTvs.Filtered := True;
  ListarTVs;

end;

procedure TViewFrmTvs.RemoverProdutoTv;
begin

  if LstBoxProdTv.count > 0 then
  begin

    oTvs.MoverProduto(FMemTableProdTv, FMemTableProdNaoTv,
      LstBoxProdTv.ListItems[LstBoxProdTv.ItemIndex].TagString);
    ListarProdutoTv;
    ListarProdNaoTv;

  end
  else
    ShowMessage('Não a produto para ser removido da Tv');

end;

procedure TViewFrmTvs.RemoverTodosProdutosTv;
begin

  if LstBoxProdTv.count > 0 then
  begin

    oTvs.MoverProduto(FMemTableProdTv, FMemTableProdNaoTv);
    ListarProdutoTv;
    ListarProdNaoTv;

  end
  else
    ShowMessage('Não a produto para ser removido da Tv');

end;

function TViewFrmTvs.GetCBoxPesquisaProdTv: String;
begin

  case FramePesquisaProdTv.CBoxFiltro.ItemIndex of
    0:
      Result := 'CODBARRA';
    1:
      Result := 'DESCRICAO';
  end;

end;

function TViewFrmTvs.GetCBoxPesquisaProduto: String;
begin

  case FramePesquisaProdutos.CBoxFiltro.ItemIndex of
    0:
      Result := 'CODBARRA';
    1:
      Result := 'DESCRICAO';
  end;

end;

end.
