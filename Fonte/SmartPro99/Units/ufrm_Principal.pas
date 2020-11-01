unit ufrm_Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts,Vcl.Dialogs,FMX.Forms;

type
  TfrmPrincipal = class(TForm)
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    fComErro: Boolean;
    fMensagemErro : String;
    fMensagemAguarde: string;
    fResultDlg: Boolean;

    function OpenDialogDir: String;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses uframe_Home, udm_Conexao, uframe_CadTvs, udm_Principal;


procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin

  try

    if not assigned(DmConexao) then
    DmConexao := TDmConexao.Create(nil);

    if not assigned(DmPrincipal) then
    DmPrincipal := TDmPrincipal.Create(nil);

  except

  end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin

  try

    if frmPrincipal.fComErro then
    begin

      //FrameMsgPopUp.CreateFrameMsgPopUp(frmPrincipal.FMensagemErro);
      exit

    end;

    FrameHome.CreateFremeHome;

  except
    //FrameMsgPopUp.CreateFrameMsgPopUp(frmPrincipal.FMensagemErro);

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
