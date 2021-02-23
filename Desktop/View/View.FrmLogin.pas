unit View.FrmLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Objects, FMX.Layouts,
  Controller.oUsuario;

type
  TViewFrmLogin = class(TForm)
    EdtLogin: TEdit;
    EdtSenha: TEdit;
    Layout1: TLayout;
    Label1: TLabel;
    Label2: TLabel;
    Layout3: TLayout;
    BtnAcessar: TRectangle;
    LytLogin: TLayout;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BtnAcessarClick(Sender: TObject);
  private
    { Private declarations }
    procedure InicializaViewLogin;
    procedure Acessar;
    procedure CloseViewLogin;
  public
    { Public declarations }
  end;

var
  ViewFrmLogin: TViewFrmLogin;

implementation

{$R *.fmx}

uses Controller.uFarctory;

procedure TViewFrmLogin.Acessar;
var
  sMsg: String;

  function LoginSenhaVaisa: Boolean;
  begin
    Result := False;
    if oUsuario.Login = '' then
      Result := True;
    if oUsuario.Login = '' then
      Result := True;

  end;

begin

  oUsuario.Login := EdtLogin.Text;
  oUsuario.Senha := EdtSenha.Text;
  if LoginSenhaVaisa then
  begin
    ShowMessage('Login ou Senha não informada');
    exit;
  end;

  try
    if oUsuario.ValidaLogin then
    begin
      uFarctory.PrincipalView.Show;
      CloseViewLogin;
    end
    else
      ShowMessage('Usuario Não Cadastrado');
  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
    end;

  end;

end;

procedure TViewFrmLogin.BtnAcessarClick(Sender: TObject);
begin
  Acessar;
end;

procedure TViewFrmLogin.CloseViewLogin;
begin
  self.Destroy;

end;

procedure TViewFrmLogin.FormCreate(Sender: TObject);
begin
  InicializaViewLogin;

end;

procedure TViewFrmLogin.InicializaViewLogin;
begin

  uFarctory := TFarctory.create;
  oUsuario := ToUsuario.create;

  EdtLogin.Text := '';
  EdtSenha.Text := '';

{$IFDEF DEBUG}
  EdtLogin.Text := 'ADMIN';
  EdtSenha.Text := 'ADMIN';
{$ENDIF}
end;

end.
