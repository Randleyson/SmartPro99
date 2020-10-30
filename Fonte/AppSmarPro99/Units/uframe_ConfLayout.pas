unit uframe_ConfLayout;

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
  FMX.Effects,
  FMX.Filter.Effects,
  FMX.Controls.Presentation,
  FMX.Objects,
  FMX.Layouts;

type
  TFrameConfLayout = class(TFrame)
    lytTitulo: TLayout;
    Rectangle1: TRectangle;
    Label1: TLabel;
    btnFechar: TSpeedButton;
    FillRGBEffect1: TFillRGBEffect;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    btnCancelar: TCornerButton;
    btnSalvar: TCornerButton;
    Layout4: TLayout;
    Layout5: TLayout;
    rdNome1: TRadioButton;
    Layout6: TLayout;
    rdNome2: TRadioButton;
    rdNome3: TRadioButton;
    lytMargTopGrid: TLayout;
    Label14: TLabel;
    edtMarTopGrid1: TEdit;
    lblMarTopGrid2: TLabel;
    lblMarTopGrid3: TLabel;
    Layout10: TLayout;
    lytLargFrm: TLayout;
    Label2: TLabel;
    edtLargFrm1: TEdit;
    lblLargFrm2: TLabel;
    lblLargFrm3: TLabel;
    lytAltFrm: TLayout;
    Label3: TLabel;
    edtAltFrm1: TEdit;
    lblAltFrm2: TLabel;
    lblAltFrm3: TLabel;
    lytFontGridPreco: TLayout;
    Label4: TLabel;
    edtFontGridPreco1: TEdit;
    lblFontGridPreco2: TLabel;
    lblFontGridPreco3: TLabel;
    lytLargLogo: TLayout;
    Label5: TLabel;
    edtLargLogo1: TEdit;
    lblLargLogo2: TLabel;
    lblLargLogo3: TLabel;
    ltyLargGridPreco: TLayout;
    Label8: TLabel;
    edtLargGrid1: TEdit;
    lblLargGrid2: TLabel;
    lblLargGrid3: TLabel;
    lytQuantProd: TLayout;
    Label11: TLabel;
    edtQuantProd1: TEdit;
    lblQuantProd2: TLabel;
    lblQuantProd3: TLabel;
    lytAltBarraProd: TLayout;
    Label15: TLabel;
    edtAltBarraProd1: TEdit;
    lblAltBarraProd2: TLabel;
    lblAltBarraProd3: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
    procedure InciarFrame;
    procedure ClickGravaAlteracaoLayout;

  public
    { Public declarations }
    procedure Resolucao(pId, pNome, pMarTopGridPreco, pLargFrmPrinc,
                        pAltFrmPrinc, pTanFontGridPreco, pLargLogo,
                        pLargGridPreco, pQuantProdGrid, pAltBarraGridProd: string;
                        pPosicao:integer);
    procedure CreateFrameConfigResolucao;
    procedure FechaFrameConfigResolucao;
  end;

  var
    FrameConfLayout : TFrameConfLayout;

implementation

{$R *.fmx}

uses ufrm_Principal, uframe_MensagemInfor, udm_Principal;

{ TFrameConfLayout }

procedure TFrameConfLayout.btnFecharClick(Sender: TObject);
begin

  try

    FechaFrameConfigResolucao;

  except
    on e: Exception do
    begin
      FrameMsgInfor.CreateFrameMsgInfor(e.Message);
    end;

  end;
end;

procedure TFrameConfLayout.btnSalvarClick(Sender: TObject);
begin

  try

    ClickGravaAlteracaoLayout;

  except
  on e: exception do
    begin
      FrameMsgInfor.CreateFrameMsgInfor('Erro ao Gravar '+ e.Message);
    end;

  end;

end;

procedure TFrameConfLayout.CreateFrameConfigResolucao;
begin

  try

    if not assigned(FrameConfLayout) then
    FrameConfLayout := TFrameConfLayout.Create(self);

    with FrameConfLayout do
    begin

      Name      := 'ConfConfResolucao';
      Parent    := frmPrincipal;

      Width     := Screen.Width;
      Height    := Screen.Height;

      InciarFrame;
      BringToFront;

    end;

  except
    raise
  end;

end;

procedure TFrameConfLayout.FechaFrameConfigResolucao;
begin

  try

    FrameConfLayout.Visible := False;
    FrameConfLayout         := nil;

  except
   raise;

  end;

end;

procedure TFrameConfLayout.ClickGravaAlteracaoLayout;
var
  vR: integer;
begin

  try

    if rdNome1.IsChecked then
    vR := 1;
    if rdNome2.IsChecked then
    vR := 2;
    if rdNome3.IsChecked then
    vR := 3;

    DmPrincipal.AlteraResolucao(vR,
                                edtMarTopGrid1.Text,
                                edtLargFrm1.Text,
                                edtAltFrm1.Text,
                                edtFontGridPreco1.Text,
                                edtLargLogo1.Text,
                                edtLargGrid1.Text,
                                edtQuantProd1.Text,
                                edtAltBarraProd1.Text);

    FrameMsgInfor.CreateFrameMsgInfor('Configurção salva com exito.');
    FechaFrameConfigResolucao;

  except
    raise

  end;

end;

procedure TFrameConfLayout.InciarFrame;
begin

  try

    DmPrincipal.CarregaParamentros;
    DmPrincipal.ListarResolucao;

  finally

  end;

end;

procedure TFrameConfLayout.Resolucao(pId, pNome, pMarTopGridPreco,
  pLargFrmPrinc, pAltFrmPrinc, pTanFontGridPreco, pLargLogo, pLargGridPreco,
  pQuantProdGrid, pAltBarraGridProd: string;pPosicao:integer);
begin

  try

    case pPosicao of
    1 :
      begin

        rdNome1.IsChecked := False;
        if FrmPrincipal.fResolucaoAtual = 1 then
        rdNome1.IsChecked := True;

        rdNome1.Text           := pNome;
        edtMarTopGrid1.Text    := pMarTopGridPreco;
        edtLargFrm1.Text       := pLargFrmPrinc;
        edtAltFrm1.Text        := pAltFrmPrinc;
        edtFontGridPreco1.Text := pTanFontGridPreco;
        edtLargLogo1.Text      := pLargLogo;
        edtLargGrid1.Text      := pLargGridPreco;
        edtQuantProd1.Text     := pQuantProdGrid;
        edtAltBarraProd1.Text  := pAltBarraGridProd;

      end;
    2 :
      begin

        rdNome2.IsChecked := False;
        if FrmPrincipal.fResolucaoAtual = 2 then
        rdNome2.IsChecked := True;

        rdNome2.Text        := pNome;
        lblMarTopGrid2.Text := pMarTopGridPreco;
        lblLargFrm2.Text    := pLargFrmPrinc;
        lblAltFrm2.Text     := pAltFrmPrinc;
        lblFontGridPreco2.Text := pTanFontGridPreco;
        lblLargLogo2.Text      := pLargLogo;
        lblLargFrm2.Text      := pLargGridPreco;
        lblQuantProd2.Text     := pQuantProdGrid;
        lblAltBarraProd2.Text  := pAltBarraGridProd;

      end;

    3 :
      begin

        rdNome3.IsChecked := False;
        if FrmPrincipal.fResolucaoAtual = 3 then
        rdNome3.IsChecked := True;

        rdNome3.Text           := pNome;
        lblMarTopGrid3.Text    := pMarTopGridPreco;
        lblLargFrm3.Text       := pLargFrmPrinc;
        lblAltFrm3.Text        := pAltFrmPrinc;
        lblFontGridPreco3.Text := pTanFontGridPreco;
        lblLargLogo3.Text      := pLargLogo;
        lblLargFrm3.Text       := pLargGridPreco;
        lblQuantProd3.Text     := pQuantProdGrid;
        lblAltBarraProd3.Text  := pAltBarraGridProd;

      end;

    end;

  except
    raise

  end;

end;

end.
