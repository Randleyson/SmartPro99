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
    Label14: TLabel;
    Line2: TLine;
    Label15: TLabel;
    Layout1: TLayout;
    Label16: TLabel;
    Layout2: TLayout;
    EdtIdTv: TEdit;
    EdtDescricao: TEdit;
    LytServidor: TLayout;
    Label17: TLabel;
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
    procedure DetalharTvPadrao;
    procedure ListarHostServer;
    procedure EnabledBtnTvs(pLstTvs, pBtnAlterar, pBtnGravar, pBtnCancelar: Boolean);
    procedure EnabledBtnServer(pEdtServer, pBtnAlterar, pBtnGravar, pBtnCancelar: Boolean);
    procedure ListarTvs;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;
    procedure ShowView(aParent: TFmxObject);
  end;
var
  FrameConfiguracao: TViewConfiguracoes;

implementation

{$R *.fmx}

uses  Units.Dm;
{ TViewConfiguracao }

procedure TViewConfiguracoes.BtnAlterarServerClick(Sender: TObject);
begin
  EnabledBtnServer(True, False, True, True);
end;

procedure TViewConfiguracoes.BtnAlterarTvClick(Sender: TObject);
begin
  EnabledBtnTvs(True, False, True, True);
end;

procedure TViewConfiguracoes.BtnCancelarClick(Sender: TObject);
begin
  EnabledBtnTvs(False, True, False, False);
end;

procedure TViewConfiguracoes.BtnCancelarServerClick(Sender: TObject);
begin
  EnabledBtnServer(False, True, False, False);
end;

procedure TViewConfiguracoes.BtnFecharViewClick(Sender: TObject);
begin
  Dm.ReloandProdutos;
  FrameConfiguracao.Visible := False;
  FrameConfiguracao.DisposeOf;
  FrameConfiguracao := Nil;
end;

procedure TViewConfiguracoes.BtnGravarServerClick(Sender: TObject);
begin
  Dm.HostServer(EdtHostServer.Text).GravarServer;
  EnabledBtnServer(False,True,False,False);
end;

procedure TViewConfiguracoes.BtnGravarTvClick(Sender: TObject);
begin
  dm.IdTv(StrToInt(EdtIdTv.Text)).GravarTv;
  ListarTvs;
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
  EdtIdTv.Enabled := False;
  EdtDescricao.Enabled := False;
  dm.IdTv(StrToInt(LstBoxTvs.ListItems[LstBoxTvs.ItemIndex].TagString));
  Dm.FMenTvs.Filter := 'IdTv = ' + IntToStr(dm.IdTv);
  Dm.FMenTvs.Filtered := True;

  EdtIdTv.Text := Dm.FMenTvs.FieldByName('idtv').AsString;
  EdtDescricao.Text := Dm.FMenTvs.FieldByName('Descricao').AsString;
end;

procedure TViewConfiguracoes.EnabledBtnServer(pEdtServer, pBtnAlterar, pBtnGravar, pBtnCancelar: Boolean);
begin
  EdtHostServer.Enabled := pEdtServer;
  BtnAlterarServer.Enabled := pBtnAlterar;
  BtnGravarServer.Enabled := pBtnGravar;
  BtnCancelarServer.Enabled := pBtnCancelar;
end;

procedure TViewConfiguracoes.EnabledBtnTvs(pLstTvs, pBtnAlterar, pBtnGravar, pBtnCancelar: Boolean);
begin
  LstBoxTvs.Enabled := pLstTvs;
  BtnAlterarTv.Enabled := pBtnAlterar;
  BtnGravarTv.Enabled := pBtnGravar;
  BtnCancelar.Enabled := pBtnCancelar;
end;

procedure TViewConfiguracoes.ListarTvs;
var
  vIdTv, vDescricao: String;
  vItem: TListBoxItem;
begin
  dm.ReloandTv;
  LstBoxTvs.Items.Clear;
  LstBoxTvs.BeginUpdate;
  try
    Dm.FMenTvs.Filtered := False;
    LblSemRegistro.Visible := True;
    if Dm.FMenTvs.RecordCount > 0 then
    begin
      LblSemRegistro.Visible := False;
      Dm.FMenTvs.First;
      while not Dm.FMenTvs.Eof do
      begin
        vIdTv := Dm.FMenTvs.FieldByName('idtv').AsString;
        vDescricao := Dm.FMenTvs.FieldByName('descricao').AsString;

        vItem := TListBoxItem.Create(LstBoxTvs);
        vItem.Text := '';
        vItem.align := TAlignLayout.Client;
        vItem.StyleLookup := 'listboxitembottomdetail';
        vItem.Height := 40;
        vItem.TagString := vIdTv;
        vItem.ItemData.Text := vIdTv + ' - ' + vDescricao;

        LstBoxTvs.AddObject(vItem);

        if vIdTv = IntToStr(dm.IdTv) then
          vItem.IsSelected := True;;
        Dm.FMenTvs.Next;
      end;
      DetalharTvPadrao;
      EnabledBtnTvs(False, True, False, False);
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

procedure TViewConfiguracoes.ShowView(aParent: TFmxObject);
begin
  Parent := aParent;
  EnabledBtnTvs(False, False, False, False);
  EnabledBtnServer(False, True, False, False);
  ListarTvs;
  ListarHostServer;
  Self.BringToFront;
end;

end.
