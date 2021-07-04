unit uController;

interface

uses
  uModel.Dao.TV;


type
  TController = class
    private
      FCadTV: TModelDaoTV;
    public
      function CadTV: TModelDaoTV;
    constructor Create;
    destructor Destroy; override;
    class function New: TController;
  end;

implementation

{ TController }

function TController.CadTV: TModelDaoTV;
begin
  Result := FCadTV;
  if not Assigned(FCadTV) then
    FCadTV := TModelDaoTV.New;
end;

constructor TController.Create;
begin

end;

destructor TController.Destroy;
begin

  inherited;
end;

class function TController.New: TController;
begin
  Result := Self.Create;
end;

end.
