unit Model.Components.RestDataWare.Interfaces;

interface
type
  iModelComponentsRestDataWare = interface
    ['{E1755AB4-B080-44DF-8507-BEF5BED302EA}']
  function AddParameter(pParans: String; aValues: Variant): iModelComponentsRestDataWare;
  function ClearParans: iModelComponentsRestDataWare;
  function Execute: iModelComponentsRestDataWare;
  function HostServer( aValue: String): iModelComponentsRestDataWare;
  function JSONString( aParant: String): String;
  function Resource( aValue: String) : iModelComponentsRestDataWare;
  function StatusCode: Integer;
  end;

implementation

end.
