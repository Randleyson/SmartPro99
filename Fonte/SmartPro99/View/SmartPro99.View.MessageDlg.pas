unit SmartPro99.View.MessageDlg;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects;

type
  TViewMessageDlg = class(TForm)
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
  ViewMessageDlg: TViewMessageDlg;

implementation

{$R *.fmx}

uses SmartPro99.Controlle.Message;


procedure TViewMessageDlg.btnNaoClick(Sender: TObject);
begin

  fResult :=  False;
  if Assigned(ViewMessageDlg) then
  ViewMessageDlg.Close;

end;

procedure TViewMessageDlg.btnSimClick(Sender: TObject);
begin

  fResult :=  True;
  if Assigned(ViewMessageDlg) then
  ViewMessageDlg.Close;

end;

end.
