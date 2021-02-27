unit Controller.uFinanceiro;

interface

uses
  FireDAC.Comp.Client, Module.DmFinanceiro, Controller.oFinanceiro;

type
  TControllerFinanceiro = class
  private
    DmFinanceiro: TDmFinanceiro;
  public
    function CarregaSaldoEmpresa
      (oFiananceiro: ToFinanceiro; out sErro: String): Boolean;
    function QueryListaDeDocumento
      (oFiananceiro: ToFinanceiro; out sErro: String): TFDQuery;

    Constructor Create;
    Destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils;

{ TControllerFinanceiro }

function TControllerFinanceiro.QueryListaDeDocumento(oFiananceiro: ToFinanceiro;
  out sErro: String): TFDQuery;
begin
  Result := DmFinanceiro.QueryListaDeDocumento(oFiananceiro,sErro);

end;

function TControllerFinanceiro.CarregaSaldoEmpresa(oFiananceiro: ToFinanceiro;
  out sErro: String): Boolean;
begin
  Result := DmFinanceiro.CarregaSaldoEmpresa(oFiananceiro, sErro);

end;

constructor TControllerFinanceiro.Create;
begin
  DmFinanceiro := TDmFinanceiro.Create(nil);
end;

destructor TControllerFinanceiro.Destroy;
begin
  FreeAndNil(DmFinanceiro);
  inherited;
end;

end.
