unit Model.components.connections.uFiredac;

interface

uses
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.FMXUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.SQLite,
  FireDAC.Dapt,
  Model.components.connections.Interfaces
  {$IFDEF ANDROID}
  ,System.IOUtils
  {$ENDIF};

type
  TComponnentsConeectionFiredac = class(TInterfacedObject, iComponentsConnections)
    private
      FDConnection: TFDConnection;
      FQuery: TFDQuery;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: TComponnentsConeectionFiredac;
      function Active (aValue: Boolean): iComponentsConnections;
      function AddParan(aParem: String; aValue: Variant): iComponentsConnections;
      function DataSet: TDataSet;
      function ExceSQL: iComponentsConnections;
      function Open: iComponentsConnections;
      function SQL(aValue: String) : iComponentsConnections;
      function SQLClear: iComponentsConnections;
  end;

implementation

uses
  System.SysUtils;

{ TModelComponnentsConeectionFiredac }

function TComponnentsConeectionFiredac.Active(aValue: Boolean): iComponentsConnections;
begin
  Result := Self;
  fQuery.Active := aValue;
end;

function TComponnentsConeectionFiredac.AddParan(aParem: String; aValue: Variant): iComponentsConnections;
begin
  Result := Self;
  FQuery.ParamByName(aParem).Value := aValue;
end;

constructor TComponnentsConeectionFiredac.Create;
begin

  FDConnection := TFDConnection.Create(Nil);
  FQuery := TFDQuery.Create(Nil);
  FQuery.Connection := FDConnection;

  FDConnection.Params.DriverID := 'SQLite';
  FDConnection.Params.Add('LockingMode=Normal');
  {$IFDEF ANDROID}
  FDConnection.Params.Database := TPath.Combine(TPath.GetDocumentsPath, 'Mobile1.0.1.db');
  {$ENDIF}
  {$IFDEF MSWINDOWS}
  FDConnection.Params.Database := 'D:\Projetos\ColetorPro99\trunk\DB\Mobile1.0.1.db';
  {$ENDIF}

  try
    FDConnection.Connected := True;
  Except
    raise Exception.Create('Erro ao conectar a banco de dados');
  end;

end;

function TComponnentsConeectionFiredac.DataSet: TDataSet;
begin
  Result := fQuery;
end;

destructor TComponnentsConeectionFiredac.Destroy;
begin
  FQuery.DisposeOf;
  FDConnection.DisposeOf;
  inherited;
end;

function TComponnentsConeectionFiredac.ExceSQL: iComponentsConnections;
begin
  Result := Self;
  FQuery.ExecSQL;
end;

class function TComponnentsConeectionFiredac.New: TComponnentsConeectionFiredac;
begin
  Result := Self.Create;
end;

function TComponnentsConeectionFiredac.Open: iComponentsConnections;
begin
  Result := Self;
  FQuery.Open;
end;

function TComponnentsConeectionFiredac.SQL(aValue: String): iComponentsConnections;
begin
  Result := self;
  FQuery.SQL.Add(aValue);
end;

function TComponnentsConeectionFiredac.SQLClear: iComponentsConnections;
begin
  Result := self;
  FQuery.SQL.Clear;
end;

end.
