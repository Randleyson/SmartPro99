unit SmartPro99.View.Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts,Vcl.Dialogs,FMX.Forms;

type
  TViewPrincipal = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
  ViewPrincipal: TViewPrincipal;

implementation

uses
  SmartPro99.Model.Conexao, SmartPro99.Model.Principal,
  SmartPro99.Controlle.Message, SmartPro99.View.Home;

{$R *.fmx}



{ TViewPrincipal }

procedure TViewPrincipal.FormCreate(Sender: TObject);
begin

  try

    if not assigned(ModelConexao) then
    ModelConexao := TModelConexao.Create(nil);

    if not assigned(ModelPrincipal) then
    ModelPrincipal := TModelPrincipal.Create(nil);

  except

  end;

end;

procedure TViewPrincipal.FormShow(Sender: TObject);
begin

  try

    if ViewPrincipal.fComErro then
    begin

      TMessage.MessagemPopUp(ViewPrincipal,ViewPrincipal.FMensagemErro);
      Application.Terminate

    end;

    ViewHome.CreateFremeHome;

  except
    TMessage.MessagemPopUp(ViewPrincipal,ViewPrincipal.FMensagemErro);

  end;

end;

function TViewPrincipal.OpenDialogDir: String;
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
