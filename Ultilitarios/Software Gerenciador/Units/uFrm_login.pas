unit uFrm_login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmLogin = class(TForm)
    edtLogin: TEdit;
    edtSenha: TEdit;
    btn_Entrar: TButton;
    Label1: TLabel;
    Label2: TLabel;
    FDQUsuario: TFDQuery;
    procedure btn_EntrarClick(Sender: TObject);
  private
    function ValidaUsuario: Boolean;
    procedure AcessaSistema;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.dfm}

uses ufrm_Principal, Dm_Principal;

procedure TFrmLogin.AcessaSistema;
begin

  FrmLogin.Close;

end;

function TFrmLogin.ValidaUsuario: Boolean;
begin

  FDQUsuario.Active   := False;
  FDQUsuario.Filtered := False;
  FDQUsuario.Filter   := 'login = '+ QuotedStr(UpperCase(edtLogin.Text)) +
                         ' and senha = '+QuotedStr(UpperCase(edtSenha.Text));
  FDQUsuario.Filtered := True;
  FDQUsuario.Active   := True;

  if FDQUsuario.RecordCount > 0 then
  result := True
  else
  result := False;

end;

procedure TFrmLogin.btn_EntrarClick(Sender: TObject);
begin

  if ValidaUsuario then
  AcessaSistema
  else
  ShowMessage('Senha Invalida!');

end;

end.
