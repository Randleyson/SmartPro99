unit uConfiguracao;

interface

type
  TTipoIntegracao = (tsToledo, tsFilizola, tsOutros);

type
  TConfiguracao = class
  private
    FTipoIntegracao: TTipoIntegracao;
    FLocalArquivo: String;
  public
    property  LocalArquivo: String read FLocalArquivo write FLocalArquivo;

    procedure TipoIntegracaoToString(pTipo: String); overload;
    procedure TipoIntegracao(pTipo: TTipoIntegracao); overload;
    function  TipoIntegracaoToString: String; overload;
    function  TipoIntegracao: TTipoIntegracao; overload;

    constructor Create;
    destructor Destroy; override;
    class function New: TConfiguracao;

  end;

implementation

{ TConfiguracao }

uses
  StrUtils, System.SysUtils;

constructor TConfiguracao.Create;
begin

end;

destructor TConfiguracao.Destroy;
begin

  inherited;
end;

class function TConfiguracao.New: TConfiguracao;
begin
  Result := TConfiguracao.Create;

end;
procedure TConfiguracao.TipoIntegracao(pTipo: TTipoIntegracao);
begin
  FTipoIntegracao := pTipo;

end;

function TConfiguracao.TipoIntegracao: TTipoIntegracao;
begin
  Result := FTipoIntegracao;

end;

procedure TConfiguracao.TipoIntegracaoToString(pTipo: String);
begin
  case AnsiIndexStr(UpperCase(pTipo), ['T', 'F','O']) of
  0 : FTipoIntegracao := tsToledo;
  1 : FTipoIntegracao := tsFilizola;
  2 : FTipoIntegracao := tsOutros;
  end;

end;

function TConfiguracao.TipoIntegracaoToString: String;
begin
  case FTipoIntegracao of
  tsToledo   : Result := 'T';
  tsFilizola : Result := 'F';
  tsOutros   : Result := 'O';
  end;

end;

end.
