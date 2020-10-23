unit uframe_MensagemInfor;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Objects;

type
  TFrameMensagemInfor = class(TFrame)
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    lblMensagem: TLabel;
    btnOk: TSpeedButton;
    Layout1: TLayout;
    Layout2: TLayout;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CreateFrameMsgInfor(pMensagem: string);
    procedure FechaFrame;
  end;

var
  FrameMsgInfor: TFrameMensagemInfor;

implementation

{$R *.fmx}

uses ufrm_Principal;

{ TFrame1 }

procedure TFrameMensagemInfor.btnOkClick(Sender: TObject);
begin

  try

    if FrmPrincipal.fComErro then
    Application.Terminate
    else
    FechaFrame;
    
  except

  end;

   
end;

procedure TFrameMensagemInfor.CreateFrameMsgInfor(pMensagem: string);
begin

  try

    if not assigned(FrameMsgInfor) then
    FrameMsgInfor := TFrameMensagemInfor.Create(self);

    with FrameMsgInfor do
    begin

      Name      := 'FrameMsgInfor';
      Parent    := frmPrincipal;

      lblMensagem.Text := pMensagem;
      btnOk.SetFocus;

    end;

  except
    FechaFrame;

  end;

end;

procedure TFrameMensagemInfor.FechaFrame;
begin

  try
  
    FrameMsgInfor.Visible := False;
    FrameMsgInfor := nil;

  except

    lblMensagem.Text := 'Erro ao fechar a tela'

  end;     

end;

end.
