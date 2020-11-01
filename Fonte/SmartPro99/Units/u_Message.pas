unit u_Message;

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

uses  Frm_MessagePopUp, Frm_MessageDlg;

class function TMessage.MessagemDlg(pFrmPrinipal: TForm;
  pMenssagem: string): Boolean;
begin

  frmMessageDlg := TfrmMessageDlg.Create(pFrmPrinipal);
  frmMessageDlg.lblMensagem. Text := pMenssagem;
  frmMessageDlg.ShowModal;
  result := fResult;
  FreeAndNil(frmMessageDlg);

end;

class function TMessage.MessagemPopUp(pFrmPrinipal: TForm;
  pMenssagem: string): Boolean;
begin

    FrmMessagePopUp := TFrmMessagePopUp.Create(pFrmPrinipal);
    FrmMessagePopUp.lblMensagem. Text := pMenssagem;
    FrmMessagePopUp.ShowModal;
    result := fResult;
    FreeAndNil(FrmMessagePopUp);

end;

end.
