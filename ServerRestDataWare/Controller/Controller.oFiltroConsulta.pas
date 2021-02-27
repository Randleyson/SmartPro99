unit Controller.oFiltroConsulta;

interface

type
  ToFiltroConsulta = class
  private

  public
    function ListarArray(const Args: array of integer): string; overload;
    //function ListarArray(const Args: array of string): string; overload;

  end;

implementation

uses
  System.SysUtils;
{
function ToFiltroConsulta.ListarArray(const Args: array of string)
  : string; overload;
var
  i: integer;
begin
  result := '(';
  for i := 0 to high(Args) do
    result := result + QuotedStr(Args[i]) + ',';
  result[length(result)] := ')';
end;}

function ToFiltroConsulta.ListarArray(const Args: array of integer)
  : string;
var
  i: integer;
begin
  {result := '(';
  for i := 0 to high(Args) do
    result := result + IntToStr(Args[i]) + ',';
  result[length(result)] := ')';}

  for i := 0 to high(Args) do
    result := result + IntToStr(Args[i]) + ',';


end;

end.
