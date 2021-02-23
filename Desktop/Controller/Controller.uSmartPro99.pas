unit Controller.uSmartPro99;

interface
type
  TuSmartPro99 = class
    private
    public
    class function SubstituirString(pString,pOld,pNew: String): String;
    class function FormatReal(pValor: Currency): String;
  end;

implementation

uses
  System.SysUtils;

{ TuSmartPro99 }

class function TuSmartPro99.FormatReal(pValor: Currency): String;
begin
  Result := Formatfloat('##,###,##0.00', pValor);
end;

class function TuSmartPro99.SubstituirString(pString, pOld,
  pNew: String): String;
begin
  Result := StringReplace(pString,pOld,pNew,[rfReplaceAll, rfIgnoreCase]);

end;

end.
