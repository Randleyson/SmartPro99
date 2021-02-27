unit Controller.oUtilitario;

interface
type
  ToUltilitaro = class
    private
    public

   class function SubstituirString(pTexto, pOld, pNew: String): String;
  end;

implementation

uses
  System.SysUtils;

{ ToUltilitaro }

class function ToUltilitaro.SubstituirString(pTexto, pOld, pNew: String): String;
begin
  Result := StringReplace(pTexto, pOld, pNew, [rfReplaceAll]);

end;

end.
