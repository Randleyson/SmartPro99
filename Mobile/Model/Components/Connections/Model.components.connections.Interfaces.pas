unit Model.components.connections.Interfaces;

interface

uses
  Data.DB;
type
  iComponentsConnections = Interface
    ['{37823AD4-CFD6-4E79-B588-76D874692F21}']
    function Active(aValue : Boolean ) : iComponentsConnections;
    function AddParan(aParem: String; aValue: Variant): iComponentsConnections;
    function DataSet: TDataSet;
    function ExceSQL: iComponentsConnections;
    function Open: iComponentsConnections;
    function SQL(aValue: String ) : iComponentsConnections;
    function SQLClear: iComponentsConnections;
  End;

implementation

end.
