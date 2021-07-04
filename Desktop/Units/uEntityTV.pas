unit uEntityTV;

interface

type
  TEntityTV = class
  private
    FStatusTela: String;
    FIdTv: Integer;
    FDescricaoTv: String;
  public
    Constructor Create;
    destructor Destroy; override;
    class function New: TEntityTV;
    function StatusTela: String; overload;
    function StatusTela( aValue: String): TEntityTV; overload;
    function IDtv: Integer; overload;
    function IDtv( aValue: String): TEntityTV; overload;
    function DescricaoTv: String; overload;
    function DescricaoTv( aValue: String): TEntityTV; overload;
  end;

implementation

uses
  System.SysUtils;

{ TEntityTV }

function TEntityTV.IDtv: Integer;
begin
  Result := FIdTv;
end;

function TEntityTV.IDtv(aValue: String): TEntityTV;
begin
  Result := Self;
  FIdTv := StrToInt(aValue);
end;

constructor TEntityTV.Create;
begin

end;

function TEntityTV.DescricaoTv: String;
begin
  Result := FDescricaoTv;
end;

function TEntityTV.DescricaoTv(aValue: String): TEntityTV;
begin
  Result := Self;
  FDescricaoTv := aValue;
end;

destructor TEntityTV.Destroy;
begin

  inherited;
end;

class function TEntityTV.New: TEntityTV;
begin
  Result := Self.Create;
end;

function TEntityTV.StatusTela: String;
begin
  Result := FStatusTela;
end;

function TEntityTV.StatusTela(aValue: String): TEntityTV;
begin
  Result := Self;
  FStatusTela := aValue;
end;

end.
