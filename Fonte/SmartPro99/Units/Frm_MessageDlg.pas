unit Frm_MessageDlg;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects;

type
  TfrmMessageDlg = class(TForm)
    Rectangle1: TRectangle;
    Layout1: TLayout;
    Layout2: TLayout;
    btnSim: TCornerButton;
    lblMensagem: TLabel;
    btnNao: TCornerButton;
    Rectangle2: TRectangle;
    procedure btnSimClick(Sender: TObject);
    procedure btnNaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMessageDlg: TfrmMessageDlg;

implementation

{$R *.fmx}

uses u_Message;

procedure TfrmMessageDlg.btnNaoClick(Sender: TObject);
begin

  fResult :=  False;
  if Assigned(frmMessageDlg) then
  frmMessageDlg.Close;

end;

procedure TfrmMessageDlg.btnSimClick(Sender: TObject);
begin

  fResult :=  True;
  if Assigned(frmMessageDlg) then
  frmMessageDlg.Close;

end;

end.
