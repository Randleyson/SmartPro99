unit View.Configuracao;

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
  FMX.Edit,
  FMX.Layouts,
  FMX.ListBox,
  FMX.Controls.Presentation,
  FMX.Objects;

type
  TViewConfiguracoes = class(TFrame)
    ToolBar: TRectangle;
    Label1: TLabel;
    RectClient: TRectangle;
    LytListaTv: TLayout;
    Label13: TLabel;
    Line1: TLine;
    LstBoxTvs: TListBox;
    LytConfiguracoes: TLayout;
    LytTvPadrao: TLayout;
    Line2: TLine;
    Label15: TLabel;
    Layout1: TLayout;
    Layout2: TLayout;
    LytServidor: TLayout;
    Line3: TLine;
    Layout4: TLayout;
    Label18: TLabel;
    Layout5: TLayout;
    EdtHostServer: TEdit;
    BtnAlterarTv: TRectangle;
    Layout3: TLayout;
    Label2: TLabel;
    BtnCancelar: TRectangle;
    Label3: TLabel;
    BtnGravarTv: TRectangle;
    Label4: TLabel;
    Layout6: TLayout;
    BtnAlterarServer: TRectangle;
    Label5: TLabel;
    BtnCancelarServer: TRectangle;
    Label6: TLabel;
    BtnGravarServer: TRectangle;
    Label7: TLabel;
    LblSemRegistro: TLabel;
    BtnFecharView: TRectangle;
    Image1: TImage;
    Label9: TLabel;
    LblCodigo: TLabel;
    LblDescricao: TLabel;
    Layout7: TLayout;
    Label8: TLabel;
    EdtTime: TEdit;
    Label10: TLabel;
    EdtQtde: TEdit;
    edtWidthLaouytImagen: TEdit;
    procedure BtnAlterarTvClick(Sender: TObject);
    procedure BtnGravarTvClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure LstBoxTvsItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure BtnAlterarServerClick(Sender: TObject);
    procedure BtnGravarServerClick(Sender: TObject);
    procedure BtnCancelarServerClick(Sender: TObject);
    procedure BtnFecharViewClick(Sender: TObject);
  private
    { Private declarations }
    //FIdTv: Integer;
    //FDescricao: String;
    procedure DetalharTvPadrao;
    procedure ListarHostServer;
    procedure EnabledBtnTvs(pLstTvs, pBtnAlterar, pBtnGravar, pBtnCancelar, pTime, pQtde, pWidthLaouytImagen: Boolean);
    procedure EnabledBtnServer(pEdtServer, pBtnAlterar, pBtnGravar, pBtnCancelar: Boolean);
    procedure ListarTvs;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;
    procedure ShowView;
  end;

implementation

{$R *.fmx}

uses  Units.Dm,
      View.Principal;
{ TViewConfiguracao }

procedure TViewConfiguracoes.BtnAlterarServerClick(Sender: TObject);
begin
  EnabledBtnServer(True, False, True, True);
end;

procedure TViewConfiguracoes.BtnAlterarTvClick(Sender: TObject);
begin
  EnabledBtnTvs(True, False, True, True,True,True,True);
end;

procedure TViewConfiguracoes.BtnCancelarClick(Sender: TObject);
begin
  EnabledBtnTvs(False, True, False, False,False,False,False);
end;

procedure TViewConfiguracoes.BtnCancelarServerClick(Sender: TObject);
begin
  EnabledBtnServer(False, True, False, False);
end;

procedure TViewConfiguracoes.BtnFecharViewClick(Sender: TObject);
begin
  Dm.ReloandProdutos;
  FrmPrincipal.FrameConfiguracao.Visible := False;
  FrmPrincipal.FrameConfiguracao.DisposeOf;
  FrmPrincipal.FrameConfiguracao := Nil;
  FrmPrincipal.FrameTabelaPreco.ShowView;
end;

procedure TViewConfiguracoes.BtnGravarServerClick(Sender: TObject);
begin
  Dm.HostServer(EdtHostServer.Text).GravarServer;
  EnabledBtnServer(False,True,False,False);
end;

procedure TViewConfiguracoes.BtnGravarTvClick(Sender: TObject);
begin
  Dm.FIdTv := StrToInt(LblCodigo.Text);
  Dm.Time(StrToInt(EdtTime.Text));
  Dm.QtdeProduto(StrToInt(EdtQtde.Text));
  Dm.WidthLayoutImagen(StrToInt(edtWidthLaouytImagen.Text));
  dm.GravarTv;
  ListarTvs;
  EnabledBtnTvs(False,True,False,False,False,False,False);
  ShowMessage('Tv Padrao definida com exito.');
end;

constructor TViewConfiguracoes.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TViewConfiguracoes.Destroy;
begin
  inherited;
end;

procedure TViewConfiguracoes.ListarHostServer;
begin
  EdtHostServer.Text := dm.HostServer;
end;

procedure TViewConfiguracoes.DetalharTvPadrao;
begin
  if LstBoxTvs.ItemIndex < 0 then
  begin
    LblCodigo.Text    := '';
    LblDescricao.Text := '';
    Exit;
  end;
  LblCodigo.Text    := LstBoxTvs.ListItems[LstBoxTvs.ItemIndex].TagString;
  LblDescricao.Text := LstBoxTvs.ListItems[LstBoxTvs.ItemIndex].Text;
end;

procedure TViewConfiguracoes.EnabledBtnServer(pEdtServer, pBtnAlterar, pBtnGravar, pBtnCancelar: Boolean);
begin
  EdtHostServer.Enabled := pEdtServer;
  BtnAlterarServer.Enabled := pBtnAlterar;
  BtnGravarServer.Enabled := pBtnGravar;
  BtnCancelarServer.Enabled := pBtnCancelar;
end;

procedure TViewConfiguracoes.EnabledBtnTvs(pLstTvs, pBtnAlterar, pBtnGravar, pBtnCancelar, pTime, pQtde, pWidthLaouytImagen: Boolean);
begin
  LstBoxTvs.Enabled     := pLstTvs;
  BtnAlterarTv.Enabled  := pBtnAlterar;
  BtnGravarTv.Enabled   := pBtnGravar;
  BtnCancelar.Enabled   := pBtnCancelar;
  EdtTime.Enabled       := pTime;
  EdtQtde.Enabled       := pQtde;
  edtWidthLaouytImagen.Enabled := pWidthLaouytImagen
end;

procedure TViewConfiguracoes.ListarTvs;
var
  vIdTv, vDescricao: String;
  vListItem: TListBoxItem;
begin
  EdtTime.Text              := IntToStr(Dm.Time);
  EdtQtde.Text              := IntToStr(Dm.QtdeProduto);
  edtWidthLaouytImagen.Text := IntToStr(Dm.WidthLayoutImagen);
  try
    dm.ReloandTv;
  Except
    Exit;
  end;

  LstBoxTvs.Items.Clear;
  LstBoxTvs.BeginUpdate;
  try
    Dm.FMenTvs.Filtered     := False;
    LblSemRegistro.Visible  := True;
    if Dm.FMenTvs.RecordCount > 0 then
    begin
      LblSemRegistro.Visible := False;
      Dm.FMenTvs.First;
      while not Dm.FMenTvs.Eof do
      begin
        vIdTv                   := Dm.FMenTvs.FieldByName('idtv').AsString;
        vDescricao              := Dm.FMenTvs.FieldByName('descricao').AsString;
        vListItem               := TListBoxItem.Create(LstBoxTvs);
        vListItem.Text          := '';
        vListItem.align         := TAlignLayout.Client;
        vListItem.StyleLookup   := 'listboxitembottomdetail';
        vListItem.Height        := 40;
        vListItem.TagString     := vIdTv;
        vListItem.ItemData.Text := vDescricao;

        LstBoxTvs.AddObject(vListItem);

        if vIdTv = IntToStr(Dm.FIdTv) then
          vListItem.IsSelected := True;
        Dm.FMenTvs.Next;
      end;
      DetalharTvPadrao;
    end;

  finally
    LstBoxTvs.EndUpdate;
  end;

end;

procedure TViewConfiguracoes.LstBoxTvsItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  DetalharTvPadrao;
end;

procedure TViewConfiguracoes.ShowView;
begin
  Parent := FrmPrincipal;
  EnabledBtnTvs(False, True, False, False, False,False,False);
  EnabledBtnServer(False, True, False, False);
  ListarTvs;
  ListarHostServer;
  Self.BringToFront;
end;

end.
