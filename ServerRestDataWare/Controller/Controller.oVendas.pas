unit Controller.oVendas;

interface

type
  ToVendas = class
  private
    FIdEmpresa: String;
    FDtInicial: String;
    FDtFinal: String;
    FQtdeCupom: integer;
    FTotalVenda: Currency;
    FTicketMedio: Currency;

  public
    property IdEmpresa: String read FIdEmpresa write FIdEmpresa;
    property DtInicial: String read FDtInicial write FDtInicial;
    property DtFinal: String read FDtFinal write FDtFinal;
    property QtdeCupom: integer read FQtdeCupom write FQtdeCupom;
    property TotalVenda: Currency read FTotalVenda write FTotalVenda;
    property TicketMedio: Currency read FTicketMedio write FTicketMedio;
  end;

implementation

end.
