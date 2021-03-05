unit Module.ServerMethod;

interface

uses
  System.SysUtils, System.Classes, uDWAbout, uRESTDWServerEvents, uDWDataModule,
  uDWJSONObject, System.json, uDWConsts;

type
  TDmServerMethod = class(TServerMethodDataModule)
    DWSEvents: TDWServerEvents;
    procedure DWServerEvents1EventsHoraReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWSEventsEventsVersaoReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWSEventsEventsListaTvReplyEventByType(var Params: TDWParams;
      var Result: string; const RequestType: TRequestType;
      var StatusCode: Integer; RequestHeader: TStringList);
    procedure DWSEventsEventsListarProdutosReplyEventByType
      (var Params: TDWParams; var Result: string;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmServerMethod: TDmServerMethod;

implementation

uses
  View.FrmPrincipal, Controller.oTvs;

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

//Hora
procedure TDmServerMethod.DWServerEvents1EventsHoraReplyEvent
  (var Params: TDWParams; var Result: string);
begin
  Result := '{"hora":"' + FormatDateTime('hh:mm:ss', now) + '"}';

end;

//Produtos Tv
procedure TDmServerMethod.DWSEventsEventsListarProdutosReplyEventByType
  (var Params: TDWParams; var Result: string; const RequestType: TRequestType;
  var StatusCode: Integer; RequestHeader: TStringList);
var
  vJson: uDWJSONObject.TJSONValue;
  oTvs: ToTvs;
begin
  vJson := uDWJSONObject.TJSONValue.Create;
  oTvs := ToTvs.Create;
  try
    try
      oTvs.IdTv := Params.ItemsString['IdTv'].AsInteger;
      vJson.LoadFromDataset('', oTvs.DataSetProdutosTv, false, jmPureJSON);
      Result := vJson.ToJSON;
      StatusCode := 200;

    except
      on E: Exception do
      begin
        StatusCode := 412;
        Result := '{"Erro":"' + E.Message + '"}';
        FrmPrincipal.EscreveMmLogs(Result);
      end;

    end;

  finally
    FreeAndNil(vJson);
  end;

end;

//Tvs
procedure TDmServerMethod.DWSEventsEventsListaTvReplyEventByType
  (var Params: TDWParams; var Result: string; const RequestType: TRequestType;
  var StatusCode: Integer; RequestHeader: TStringList);
var
  vJson: uDWJSONObject.TJSONValue;
  oTvs: ToTvs;
begin
  vJson := uDWJSONObject.TJSONValue.Create;
  oTvs := ToTvs.Create;
  try
    try
      vJson.LoadFromDataset('', oTvs.DataSetListaTvs, false, jmPureJSON);
      Result := vJson.ToJSON;
      StatusCode := 200;
    except
      on E: Exception do
      begin
        StatusCode := 412;
        Result := '{"Erro":"' + E.Message + '"}';
        FrmPrincipal.EscreveMmLogs(Result);

      end;
    end;

  finally
    FreeAndNil(vJson);
    FreeAndNil(oTvs);
  end;

end;

//Versao Server
procedure TDmServerMethod.DWSEventsEventsVersaoReplyEvent(var Params: TDWParams;
  var Result: string);
begin
  Result := '{"Versao":"' + FrmPrincipal.cVersao + '"}'

end;

end.
