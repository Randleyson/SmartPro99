unit Controller.uLogin;

interface

uses
  Module.DmLogin, Controller.oLogin;

type
  TControllerLogin = class
    private
      DmLogin: TDmLogin;
    public
    function ValidaLogin(oLogin: ToLogin; out sErro: String): Boolean;
    function EmpresaPermitida(oLogin: ToLogin; out sErro: String): Boolean;

    Constructor Create;
    Destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils;

{ TControllerLogin }

constructor TControllerLogin.Create;
begin
  DmLogin := TDmLogin.Create(nil);
end;

destructor TControllerLogin.Destroy;
begin
  FreeAndNil(DmLogin);
  inherited;
end;

function TControllerLogin.EmpresaPermitida(oLogin: ToLogin; out sErro: String): Boolean;
begin
  Result := DmLogin.EmpresaPermitida(oLogin,sErro);
end;

function TControllerLogin.ValidaLogin(oLogin: ToLogin;
  out sErro: String): Boolean;
begin
  Result := DmLogin.ValidaLogin(oLogin,sErro);
end;

end.
