unit ufrm_Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts,Vcl.Dialogs,FMX.Forms;

type
  TfrmPrincipal = class(TForm)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    fComErro: Boolean;
    fMensagemErro : String;
    fMensagemAguarde: string;
    function OpenDialogDir: String;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses uframe_Home, udm_Conexao, uframe_CadTvs, udm_Principal, ufrm_MensagemInfor;


procedure TfrmPrincipal.FormShow(Sender: TObject);
begin

  try

    FrameHome.CreateFremeHome;

  except
    FrameMsgInfor.CreateFrameMsgInfor(frmPrincipal.FMensagemErro);

  end;

end;

function TfrmPrincipal.OpenDialogDir: String;
begin

  with TOpenDialog.Create(nil) do
  try

    InitialDir  := 'D:';
    Options     := [ofFileMustExist];
    Filter      := '*.txt';
    if Execute then
      Result := FileName;
  finally
    Free;
  end;



end;

end.
