unit Controller.uConfiguracao;

interface

uses
  Module.DmConfiguracao;

type
  TuConfiguracao = class
  private
    DmConfiguracao: TDmConfiguracao;
  public
    function GetConfig(pSecao, pValue: String): String;
    procedure SetConfig(pSecao, pParament, pValue: String);
    procedure SincronizarProdutos;
  end;

implementation

uses
  System.SysUtils;

function TuConfiguracao.GetConfig(pSecao, pValue: String): String;
begin

  DmConfiguracao := TDmConfiguracao.Create(nil);
  try
    Result := DmConfiguracao.GetConfig(pSecao, pValue);

  finally
    FreeAndNil(DmConfiguracao);
  end;

end;

procedure TuConfiguracao.SetConfig(pSecao, pParament, pValue: String);
begin

  DmConfiguracao := TDmConfiguracao.Create(nil);
  try
    DmConfiguracao.SetConfig(pSecao, pParament, pValue);
  finally
    FreeAndNil(DmConfiguracao);
  end;
end;

procedure TuConfiguracao.SincronizarProdutos;
begin

  DmConfiguracao := TDmConfiguracao.Create(nil);
  try
    DmConfiguracao.SincronizarProdutos;
  finally
    FreeAndNil(DmConfiguracao);
  end;
end;

end.
