unit SmartPro99.Controlle.Message;

interface

uses
  FMX.Forms,
  System.SysUtils;
  type TMessage = class
  private
  public
    class function MessagemPopUp(pFrmPrinipal: TForm; pMenssagem: string): Boolean;
    class function MessagemDlg(pFrmPrinipal: TForm; pMenssagem: string): Boolean;

  end;

  var
  fResult: Boolean;


implementation

uses
  SmartPro99.View.MessageDlg, SmartPro99.View.MessagePopUp;

class function TMessage.MessagemDlg(pFrmPrinipal: TForm;
  pMenssagem: string): Boolean;
begin

  ViewMessageDlg := TViewMessageDlg.Create(pFrmPrinipal);
  ViewMessageDlg.lblMensagem. Text := pMenssagem;
  ViewMessageDlg.ShowModal;
  result := fResult;
  FreeAndNil(ViewMessageDlg);

end;

class function TMessage.MessagemPopUp(pFrmPrinipal: TForm;
  pMenssagem: string): Boolean;
begin

    ViewMessagePopUp := TViewMessagePopUp.Create(pFrmPrinipal);
    ViewMessagePopUp.lblMensagem. Text := pMenssagem;
    ViewMessagePopUp.ShowModal;
    result := fResult;
    FreeAndNil(ViewMessagePopUp);

end;

end.
