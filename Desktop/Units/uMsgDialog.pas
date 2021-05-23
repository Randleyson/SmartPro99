unit uMsgDialog;

interface

type
  TuMessage = class
  private
  public
    class function MensagemConfirmacao(pMessage: String): Boolean;
  end;

implementation

uses
  FMX.DialogService, System.UITypes, FMX.Dialogs;

{ TuMessageDialog }

class function TuMessage.MensagemConfirmacao(pMessage: String): Boolean;
var
  lResultStr: Boolean;
begin
  lResultStr := False;
  TDialogService.PreferredMode:=TDialogService.TPreferredMode.Platform;
  TDialogService.MessageDialog(pMessage, TMsgDlgType.mtConfirmation,
    FMX.Dialogs.mbYesNo, TMsgDlgBtn.mbNo, 0,
    procedure(const AResult: TModalResult)
    begin
      case AResult of
        mrYes: lResultStr:= True;
        mrNo:  lResultStr:= False;
      end;
    end);

  Result:=lResultStr;
end;

end.
