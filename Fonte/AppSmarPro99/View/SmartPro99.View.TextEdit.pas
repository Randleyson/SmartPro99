unit SmartPro99.View.TextEdit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Effects, FMX.Filter.Effects, FMX.Layouts, FMX.Objects,
  FMX.Controls.Presentation, FMX.Edit;

type
  TFrameEdit = class(TFrame)
    edtEdit: TEdit;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Label1: TLabel;
    btnFechar: TSpeedButton;
    btnOk: TCornerButton;
    Layout1: TLayout;
    FillRGBEffect1: TFillRGBEffect;
    procedure btnFecharClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
    fTEdit: TEdit;
  public
    { Public declarations }
    procedure CreateFrameTextoEdit(pTexto: String; pTEdit: TEdit);
    procedure FecharFrameEdit;
  end;

var
   FrameEdit : TFrameEdit;

implementation

uses
  SmartPro99.View.Message, SmartPro99.View.FrmPrincipal;

{$R *.fmx}


{ TFrameTextoEdit }

procedure TFrameEdit.btnFecharClick(Sender: TObject);
begin

  try

    FecharFrameEdit

  except
    FrameMsgInfor.CreateFrameMsgInfor(FrmPrincipal.fMensagemErro);

  end;

end;

procedure TFrameEdit.btnOkClick(Sender: TObject);
begin

  try

    fTEdit.Text := edtEdit.Text;
    FecharFrameEdit;

  except
    FrameMsgInfor.CreateFrameMsgInfor('Erro ao salvar o texto na variavel ');

  end;

end;

procedure TFrameEdit.CreateFrameTextoEdit(pTexto: String; pTEdit: TEdit);
begin

  try

  if not assigned(FrameEdit) then
    FrameEdit := TFrameEdit.Create(self);

    with FrameEdit do
    begin

      Name         := 'FrameConfig';
      Parent       := frmPrincipal;
      fTEdit       := pTEdit;
      edtEdit.Text := pTexto;
      edtEdit.SetFocus;
      BringToFront;

    end;

  except

    FrmPrincipal.fMensagemErro := 'Erro ao iniciar o frame edit ';
    raise;

  end;

end;

procedure TFrameEdit.FecharFrameEdit;
begin

  try

    FrameEdit.Visible := False;
    FrameEdit := nil;

  except
    FrmPrincipal.fMensagemErro := 'Erro ao fechar o frame Edit';
    raise;

  end;

end;

end.
