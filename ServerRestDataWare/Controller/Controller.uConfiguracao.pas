unit Controller.uConfiguracao;

interface

uses
  Module.DmConfiguracao;

type
  TuConfiguracao = class
  private
    DaoDmConfiguracao: TDmConfiguracao;
  public
    function GetConfig(pSecao,pValue: String): String;
    procedure SetConfig(pSecao,pParament,pValue: String);

    Constructor Create;
    Destructor Destroy; override;
  end;

implementation
uses
  System.SysUtils;


constructor TuConfiguracao.Create;
begin
  DaoDmConfiguracao := TDmConfiguracao.Create(nil);
end;

destructor TuConfiguracao.Destroy;
begin
  FreeAndNil(DaoDmConfiguracao);
  inherited;
end;

function TuConfiguracao.GetConfig(pSecao, pValue: String): String;
begin
  Result := DaoDmConfiguracao.GetConfig(pSecao,pValue);

end;

procedure TuConfiguracao.SetConfig(pSecao,pParament, pValue: String);
begin
  DaoDmConfiguracao.SetConfig(pSecao,pParament, pValue);
end;

end.
