unit Controller.oLogin;

interface

uses
  FireDAC.Comp.Client;

type
  ToLogin = class
  private
    FLogin: string;
    FSenha: String;
    FCodUsuario: Integer;
    FRazaoEmpresa: String;
    FCnpj: String;
    FNomeUsuario: String;
    FEmpresaPermitida: TFDQuery;
    procedure SetLogin(const Value: string);
    procedure SetSenha(const Value: String);
  public
    property Login: string read FLogin write SetLogin;
    property Senha: String read FSenha write SetSenha;
    property CodUsuario: Integer read FCodUsuario write FCodUsuario;
    property NomeUsuario: String read FNomeUsuario write FNomeUsuario;
    property RazaoEmpresa: String read FRazaoEmpresa write FRazaoEmpresa;
    property Cnpj: String read FCnpj write FCnpj;
    property EmpresaPermitida: TFDQuery read FEmpresaPermitida
      write FEmpresaPermitida;

  end;

implementation

uses
  System.SysUtils;

{ ToLogin }

procedure ToLogin.SetLogin(const Value: string);
begin
  FLogin := UpperCase(Value);
end;

procedure ToLogin.SetSenha(const Value: String);
begin
  FSenha := UpperCase(Value);
end;

end.
