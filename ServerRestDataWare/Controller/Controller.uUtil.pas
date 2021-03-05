unit Controller.uUtil;

interface

uses
  FMX.ListBox;

type
  TuUtil = class
  private
  public
    class function SubstituirStr(pString, pOld, pNew: String): String;
    class function TagStringListBox(pListBox: TlistBox): String;
    class Function NumeroDeLinhasTXT(pPath: String): integer;
  end;

implementation

uses
  System.SysUtils, System.Classes;

{ TuUtil }

class function TuUtil.NumeroDeLinhasTXT(pPath: String): integer;
Var
  vList: TStringList;
begin
  Result := 0;
  if FileExists(pPath) then
  Begin
    vList := TStringList.Create;
    Try
      // Carrego o arquivo para dentro da lista
      vList.LoadFromFile(pPath);
      // Retorno o número de linhas que o arquivo contem
      Result := vList.Count;
    Finally
      // Destruo o objeto
      FreeAndNil(vList);
    End;
  End;
end;

class function TuUtil.SubstituirStr(pString, pOld, pNew: String): String;
begin
  Result := StringReplace(pString, pOld, pNew, [rfReplaceAll, rfIgnoreCase]);
end;

class function TuUtil.TagStringListBox(pListBox: TlistBox): String;
begin
  if pListBox.Count > 0 then
    Result := pListBox.ListItems[pListBox.ItemIndex].TagString
  else
    Result := '0'
end;

end.
