unit uTv;

interface

type
  TStatus = (tsAdicionar, tsEditar);

type
  TTv = class
  private
    FStatusTela: TStatus;
    FId: Integer;
    FName: String;
    procedure SetName(const Value: String);
  public
    property StatusTela: TStatus read FStatusTela write FStatusTela;
    property IdTV: Integer read FId write FId;
    property NomeTV: String read FName write SetName;
    constructor Create;
    destructor Destroy; override;
    class function New: TTv;
  end;

implementation

uses
  System.SysUtils;

{ Tv }

constructor TTv.Create;
begin

end;

destructor TTv.Destroy;
begin

  inherited;
end;

class function TTv.New: TTv;
begin
  Result := TTv.Create;
end;

procedure TTv.SetName(const Value: String);
begin
  if Value = '' then
    raise Exception.Create('Nome da TV e invalido');

  FName := UpperCase(Value);
end;

end.
