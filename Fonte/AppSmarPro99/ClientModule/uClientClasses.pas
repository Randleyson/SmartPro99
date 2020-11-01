//
// Created by the DataSnap proxy generator.
// 01/11/2020 18:27:49
//

unit uClientClasses;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.FireDACJSONReflect, Data.DBXJSONReflect;

type

  IDSRestCachedTFDJSONDataSets = interface;

  TServerMethods1Client = class(TDSAdminRestClient)
  private
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FSincronizaTxtToFreeboardCommand: TDSRestCommand;
    FGetCommand: TDSRestCommand;
    FGetCommand_Cache: TDSRestCommand;
    FGetStringCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    procedure SincronizaTxtToFreeboard;
    function Get(pSQL: string; const ARequestFilter: string = ''): TFDJSONDataSets;
    function Get_Cache(pSQL: string; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function GetString(pSQL: string; const ARequestFilter: string = ''): string;
  end;

  IDSRestCachedTFDJSONDataSets = interface(IDSRestCachedObject<TFDJSONDataSets>)
  end;

  TDSRestCachedTFDJSONDataSets = class(TDSRestCachedObject<TFDJSONDataSets>, IDSRestCachedTFDJSONDataSets, IDSRestCachedCommand)
  end;

const
  TServerMethods1_EchoString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_ReverseString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_Get: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'pSQL'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods1_Get_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'pSQL'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_GetString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'pSQL'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

implementation

function TServerMethods1Client.EchoString(Value: string; const ARequestFilter: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FConnection.CreateCommand;
    FEchoStringCommand.RequestType := 'GET';
    FEchoStringCommand.Text := 'TServerMethods1.EchoString';
    FEchoStringCommand.Prepare(TServerMethods1_EchoString);
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.Execute(ARequestFilter);
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.ReverseString(Value: string; const ARequestFilter: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FConnection.CreateCommand;
    FReverseStringCommand.RequestType := 'GET';
    FReverseStringCommand.Text := 'TServerMethods1.ReverseString';
    FReverseStringCommand.Prepare(TServerMethods1_ReverseString);
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.Execute(ARequestFilter);
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

procedure TServerMethods1Client.SincronizaTxtToFreeboard;
begin
  if FSincronizaTxtToFreeboardCommand = nil then
  begin
    FSincronizaTxtToFreeboardCommand := FConnection.CreateCommand;
    FSincronizaTxtToFreeboardCommand.RequestType := 'GET';
    FSincronizaTxtToFreeboardCommand.Text := 'TServerMethods1.SincronizaTxtToFreeboard';
  end;
  FSincronizaTxtToFreeboardCommand.Execute;
end;

function TServerMethods1Client.Get(pSQL: string; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetCommand = nil then
  begin
    FGetCommand := FConnection.CreateCommand;
    FGetCommand.RequestType := 'GET';
    FGetCommand.Text := 'TServerMethods1.Get';
    FGetCommand.Prepare(TServerMethods1_Get);
  end;
  FGetCommand.Parameters[0].Value.SetWideString(pSQL);
  FGetCommand.Execute(ARequestFilter);
  if not FGetCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods1Client.Get_Cache(pSQL: string; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetCommand_Cache = nil then
  begin
    FGetCommand_Cache := FConnection.CreateCommand;
    FGetCommand_Cache.RequestType := 'GET';
    FGetCommand_Cache.Text := 'TServerMethods1.Get';
    FGetCommand_Cache.Prepare(TServerMethods1_Get_Cache);
  end;
  FGetCommand_Cache.Parameters[0].Value.SetWideString(pSQL);
  FGetCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethods1Client.GetString(pSQL: string; const ARequestFilter: string): string;
begin
  if FGetStringCommand = nil then
  begin
    FGetStringCommand := FConnection.CreateCommand;
    FGetStringCommand.RequestType := 'GET';
    FGetStringCommand.Text := 'TServerMethods1.GetString';
    FGetStringCommand.Prepare(TServerMethods1_GetString);
  end;
  FGetStringCommand.Parameters[0].Value.SetWideString(pSQL);
  FGetStringCommand.Execute(ARequestFilter);
  Result := FGetStringCommand.Parameters[1].Value.GetWideString;
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TServerMethods1Client.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FSincronizaTxtToFreeboardCommand.DisposeOf;
  FGetCommand.DisposeOf;
  FGetCommand_Cache.DisposeOf;
  FGetStringCommand.DisposeOf;
  inherited;
end;

end.

