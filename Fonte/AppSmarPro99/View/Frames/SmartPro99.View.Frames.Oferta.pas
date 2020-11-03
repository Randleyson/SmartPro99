unit SmartPro99.View.Frames.Oferta;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation;

type
  TFrameOferta = class(TFrame)
    Image1: TImage;
    lblNomeProduto: TLabel;
    imgProdOferta: TImage;
    lytImag: TLayout;
    Image3: TImage;
    Layout2: TLayout;
    lblVrvendaReal: TLabel;
    lblUnidade: TLabel;
    Layout3: TLayout;
    lblVrvendaCentavos: TLabel;
    rectOferta: TRectangle;
    rectEmp: TRectangle;
    Image2: TImage;
    tmProxOferta1: TTimer;
    procedure tmProxOferta1Timer(Sender: TObject);
  private
    { Private declarations }
    fUltimaOferta: integer;
    fQtdeOfertas: integer;


  public
    { Public declarations }
    procedure CreateFrameOferta;
    procedure IniciaFrameOferta;
    procedure ListaOferta(pDecricao,pVrvenda,pUnidade:string);
    procedure LogoEmpresa;


  end;
var
   FrameOferta : TFrameOferta;

implementation

uses
  SmartPro99.Classe.Resolucao, SmartPro99.View.Message,
  SmartPro99.View.FrmPrincipal, SmarPro99.Model.Dados,
  SmartPro99.View.TabelaDePreco;

{$R *.fmx}

{ TFrameOferta }

procedure TFrameOferta.ListaOferta(pDecricao, pVrvenda, pUnidade: string);
begin

  try

    rectOferta.Visible      := True;
    lytImag.Height          := TResolucao.fAlturaLytImgOferta;

    imgProdOferta.Height    := TResolucao.fLargImgOferta;
    imgProdOferta.Width     := TResolucao.fAlturaImgOferta;

    lblNomeProduto.Text     := pDecricao;
    lblUnidade.Text         := pUnidade;

    lblVrvendaReal.Text     := copy(pVrvenda,1,pos(',',pVrvenda));
    lblVrvendaCentavos.Text := copy(pVrvenda,pos(',',pVrvenda)+1,2);

  except
  on e: Exception do
    begin
  		FrameMsgInfor.CreateFrameMsgInfor('Erro : '+ frmPrincipal.fMensagemErro + e.Message);
    end;

  end;

end;

procedure TFrameOferta.LogoEmpresa;
begin

  try

    rectOferta.Visible := False;
    rectEmp.Visible    := True;

  except
    raise


  end;

end;

procedure TFrameOferta.tmProxOferta1Timer(Sender: TObject);
begin

  try

    if (fUltimaOferta <= fQtdeOfertas) then
    begin

      ModelDados.FDMenOferta.RecNo := fUltimaOferta;
      ListaOferta(ModelDados.FDMenOfertaDESCRICAO.AsString,
                  ModelDados.FDMenOfertaVRVENDA.AsString,
                  ModelDados.FDMenOfertaUNIDADE.AsString);

      ModelDados.FDMenOferta.Next;
      fUltimaOferta := ModelDados.FDMenOferta.RecNo;

      if ModelDados.FDMenOferta.Eof then
      fUltimaOferta := fUltimaOferta+ 1;

    end
    else
    IniciaFrameOferta;

  except
  on e: Exception do
    begin
		  FrameMsgInfor.CreateFrameMsgInfor('Erro : '+ frmPrincipal.fMensagemErro + e.Message);
    end;

  end;
end;

procedure TFrameOferta.CreateFrameOferta;
begin

  try

    if not assigned(FrameOferta) then
    FrameOferta := TFrameOferta.Create(self);

    with FrameOferta do
    begin

      Name                  := 'FrameOferta';
      Parent                := VeiwTabelaDePreco.lytOferta;

      rectOferta.Visible    := False;
      rectEmp.Visible       := False;
      tmProxOferta1.Enabled := True;
      IniciaFrameOferta;
      BringToFront;

    end;

  except
  on e: Exception do
    begin
  		FrameMsgInfor.CreateFrameMsgInfor('Erro : '+ frmPrincipal.fMensagemErro + e.Message);
    end;

  end;


  end;

procedure TFrameOferta.IniciaFrameOferta;
begin

  try

    ModelDados.QryToFMent(ModelDados.FQryOferta,
                           ModelDados.FDMenOferta);
    ModelDados.FDMenOferta.First;
    fQtdeOfertas    := ModelDados.FDMenOferta.RecordCount;
    fUltimaOferta   := 1;

    if fQtdeOfertas > 0 then
    FrameOferta.ListaOferta(ModelDados.FDMenOfertaDESCRICAO.AsString,
                            ModelDados.FDMenOfertaVRVENDA.AsString,
                            ModelDados.FDMenOfertaUNIDADE.AsString)
    else
    FrameOferta.LogoEmpresa;

  except

  end;

end;
end.
