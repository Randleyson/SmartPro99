unit SmartPro99.View.MessagePopUp;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Objects;

type
  TViewMessagePopUp = class(TForm)
    Rectangle1: TRectangle;
    lblMensagem: TLabel;
    Layout1: TLayout;
    Layout2: TLayout;
    btnOk: TCornerButton;
    Rectangle2: TRectangle;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewMessagePopUp: TViewMessagePopUp;

implementation

{$R *.fmx}

uses SmartPro99.Controlle.Message;

procedure TViewMessagePopUp.btnOkClick(Sender: TObject);
begin

   fResult :=  True;
  if Assigned(ViewMessagePopUp) then
  ViewMessagePopUp.Close;

end;

end.
