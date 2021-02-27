unit Controller.oFinanceiro;

interface

uses
  FireDAC.Comp.Client;

type
  ToFinanceiro = class
  private
    FIdEmpresa: String;
    FDtFinal: String;
    FDtInicial: String;
    FTipoDocumento: Integer;

    FQueryFinanceiro: TFDQuery;
    FTotalCartao: Currency;
    FTotalApagar: Currency;
    FTotalChequePre: Currency;
    FTotalAreceber: Currency;
    FTotalChequeProp: Currency;

    procedure SetFDtFinal(const Value: String);
    procedure SetFDtInicial(const Value: String);
    procedure SetFIdEmpresa(const Value: String);
    function GetFTipoDocumento: String;
    procedure SetFTipoDocumento(const Value: Integer);

  public
    property IdEmpresa: String read FIdEmpresa write SetFIdEmpresa;
    property DtInicial: String read FDtInicial write SetFDtInicial;
    property DtFinal: String read FDtFinal write SetFDtFinal;
    property TipoDocumento: Integer read FTipoDocumento write SetFTipoDocumento;
    property TipoDocumentoString: String read GetFTipoDocumento;

    property TotalCartao: Currency read FTotalCartao write FTotalCartao;
    property TotalAreceber: Currency read FTotalAreceber write FTotalAreceber;
    property TotalChequePre: Currency read FTotalChequePre
      write FTotalChequePre;
    property TotalApagar: Currency read FTotalApagar write FTotalApagar;
    property TotalChequeProp: Currency read FTotalChequeProp
      write FTotalChequeProp;

  end;

implementation

uses
  System.SysUtils;

{ ToFiananceiro }

function ToFinanceiro.GetFTipoDocumento: String;
begin

  case FTipoDocumento of
    1:
      Result := 'ARECEBER';
    2:
      Result := 'CARTAO';
    3:
      Result := 'CHEQUEPRE';
    4:
      Result := 'APAGAR';
    5:
      Result := 'CHEQUEPROP';

  end;
end;

procedure ToFinanceiro.SetFDtFinal(const Value: String);
begin

  try
    StrToDate(Value);
    FDtFinal := Value;
  except
    raise Exception.Create('Data Final Invalida');

  end;

end;

procedure ToFinanceiro.SetFDtInicial(const Value: String);
begin

  try
    StrToDate(Value);
    FDtInicial := Value;
  except
    raise Exception.Create('Data Incial Invalida');

  end;
end;

procedure ToFinanceiro.SetFIdEmpresa(const Value: String);
begin

  try
    FDtFinal := Value;
  except
    raise Exception.Create('IdEmpresa Invalido');

  end;
  FIdEmpresa := Value;
end;

procedure ToFinanceiro.SetFTipoDocumento(const Value: Integer);
begin

  if Value > 5 then
    raise Exception.Create('Tipo Documento Invalido');
  FTipoDocumento := Value;

end;

end.
