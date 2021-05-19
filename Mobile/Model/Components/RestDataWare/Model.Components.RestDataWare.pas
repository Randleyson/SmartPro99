unit Model.Components.RestDataWare;

interface

uses
  Model.Components.RestDataWare.Interfaces,
  Datasnap.DSClientRest,
  REST.Types,
  REST.Client,
  REST.Authenticator.Basic,
  System.JSON,
  Data.Bind.Components,
  Data.Bind.ObjectScope;
type
  TModelComponentsRestDataWare = class(TInterfacedObject, iModelComponentsRestDataWare)
  private
    FRESTClient: TRESTClient;
    FRESTRequest: TRESTRequest;
    FTHTTPBasicAuthenticator: THTTPBasicAuthenticator;
  public
  constructor Create;
  destructor Destroy; override;
  class function New : TModelComponentsRestDataWare;
  function AddParameter(pParans: String; aValues: Variant): iModelComponentsRestDataWare;
  function ClearParans: iModelComponentsRestDataWare;
  function Execute: iModelComponentsRestDataWare;
  function HostServer( aValue: String): iModelComponentsRestDataWare;
  function JSONString( aParant: String): String;
  function Resource( aValue: String) : iModelComponentsRestDataWare;
  function StatusCode: Integer;
  end;

implementation

uses
  System.SysUtils;

{ TModelComponentsRestDataWare }

function TModelComponentsRestDataWare.AddParameter(pParans: String;
  aValues: Variant): iModelComponentsRestDataWare;
begin
  Result := Self;
  FRESTRequest.AddParameter(pParans, aValues);
end;

function TModelComponentsRestDataWare.ClearParans: iModelComponentsRestDataWare;
begin
  Result := Self;
  FRESTRequest.Params.Clear;
end;

constructor TModelComponentsRestDataWare.Create;
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

destructor TModelComponentsRestDataWare.Destroy;
begin
  FRESTRequest.DisposeOf;
  FRESTClient.DisposeOf;
  FTHTTPBasicAuthenticator.DisposeOf;
  inherited;
end;

function TModelComponentsRestDataWare.Execute: iModelComponentsRestDataWare;
begin
  Result := Self;
  FRESTRequest.Execute;
end;

function TModelComponentsRestDataWare.HostServer( aValue: String): iModelComponentsRestDataWare;
begin
  Result := Self;
  FRESTClient.BaseURL := 'http://'+ aValue;
end;

function TModelComponentsRestDataWare.JSONString( aParant: String): String;
begin
  Result := (TJsonObject.ParseJSONValue
              (TEncoding.UTF8.GetBytes
                (FRESTRequest.Response.JSONValue.ToString), 0)
                  as TJSONObject).GetValue(aParant).Value;
end;

class function TModelComponentsRestDataWare.New: TModelComponentsRestDataWare;
begin
  Result := TModelComponentsRestDataWare.Create;
end;

function TModelComponentsRestDataWare.Resource( aValue: String): iModelComponentsRestDataWare;
begin
  Result := Self;
  FRESTRequest.Resource := aValue;
end;

function TModelComponentsRestDataWare.StatusCode: Integer;
begin
  Result := FRESTRequest.Response.StatusCode
end;

end.
