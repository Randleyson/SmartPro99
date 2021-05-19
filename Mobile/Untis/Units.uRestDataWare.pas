unit Units.uRestDataWare;

interface

uses
  Datasnap.DSClientRest,
  REST.Types,
  REST.Client,
  REST.Authenticator.Basic,
  System.JSON,
  Data.Bind.Components,
  Data.Bind.ObjectScope;
type
  TRestDataWare = class
  private
    FRESTClient: TRESTClient;
    FRESTRequest: TRESTRequest;
    FTHTTPBasicAuthenticator: THTTPBasicAuthenticator;
  public
  constructor Create;
  destructor Destroy; override;
  class function New : TRestDataWare;
  function AddParameter(pParans: String; aValues: Variant): TRestDataWare;
  function ClearParans: TRestDataWare;
  function Execute: TRestDataWare;
  function HostServer( aValue: String): TRestDataWare;
  function JSONString( aParant: String): String;
  function JSONArray: TJSONArray;
  function Resource( aValue: String) : TRestDataWare;
  function StatusCode: Integer;
  end;

implementation

uses
  System.SysUtils;

{ TModelComponentsRestDataWare }

function TRestDataWare.AddParameter(pParans: String;
  aValues: Variant): TRestDataWare;
begin
  Result := Self;
  FRESTRequest.AddParameter(pParans, aValues);
end;

function TRestDataWare.ClearParans: TRestDataWare;
begin
  Result := Self;
  FRESTRequest.Params.Clear;
end;

constructor TRestDataWare.Create;
begin
  FRESTClient := TRESTClient.Create(Nil);
  FRESTClient.Accept := 'application/json';
  FRESTClient.AcceptCharSet := 'UTF-8';
  FRESTClient.ContentType := 'application/json';
  FRESTClient.RaiseExceptionOn500 := False;
  FTHTTPBasicAuthenticator := THTTPBasicAuthenticator.Create('admin', 'admin');
  FRESTClient.Authenticator := FTHTTPBasicAuthenticator;
  FRESTRequest := TRESTRequest.Create(Nil);
  FRESTRequest.Client := FRESTClient;
end;

destructor TRestDataWare.Destroy;
begin
  FRESTRequest.DisposeOf;
  FRESTClient.DisposeOf;
  FTHTTPBasicAuthenticator.DisposeOf;
  inherited;
end;

function TRestDataWare.Execute: TRestDataWare;
begin
  Result := Self;
  try
    FRESTRequest.Execute;
  except
  end;
end;

function TRestDataWare.HostServer( aValue: String): TRestDataWare;
begin
  Result := Self;
  FRESTClient.BaseURL := 'http://'+ aValue;
end;

function TRestDataWare.JSONArray: TJSONArray;
begin
  Result := TJsonObject.ParseJSONValue
    (TEncoding.UTF8.GetBytes(FRESTRequest.Response.JSONText), 0) as TJSONArray;
end;

function TRestDataWare.JSONString( aParant: String): String;
begin
  Result := (TJsonObject.ParseJSONValue
              (TEncoding.UTF8.GetBytes
                (FRESTRequest.Response.JSONValue.ToString), 0)
                  as TJSONObject).GetValue(aParant).Value;
end;

class function TRestDataWare.New: TRestDataWare;
begin
  Result := TRestDataWare.Create;
end;

function TRestDataWare.Resource( aValue: String): TRestDataWare;
begin
  Result := Self;
  FRESTRequest.Resource := aValue;
end;

function TRestDataWare.StatusCode: Integer;
begin
  Result := FRESTRequest.Response.StatusCode
end;

end.
