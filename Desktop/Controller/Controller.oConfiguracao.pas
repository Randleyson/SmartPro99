unit Controller.oConfiguracao;

interface

type
  ToConfiguracao = class
  private
    FPadraoArquivo: String;
    FLocalArquivo: String;
    FNewLocalArquivo: String;
    FNewPadraoArquivo: String;

  public
    procedure CarregaConfiguracaoDb;
    property PadraoArquivo: String read FPadraoArquivo write FPadraoArquivo;
    property LocalArquivo: String read FLocalArquivo write FLocalArquivo;
    property NewPadraoArquivo: String read FNewPadraoArquivo write FNewPadraoArquivo;
    property NewLocalArquivo: String read FNewLocalArquivo write FNewLocalArquivo;

  end;

var
  oConfiguracao: ToConfiguracao;

implementation

uses
  Controller.uConfiguracao, System.SysUtils;

{ ToConfiguracao }

procedure ToConfiguracao.CarregaConfiguracaoDb;
var
  uConfiguracao: TuConfiguracao;
begin

  uConfiguracao := TuConfiguracao.Create;
  try
    uConfiguracao.CarregaConfiguracaoDb(oConfiguracao);

  finally
    FreeAndNil(uConfiguracao);

  end;

end;

end.
