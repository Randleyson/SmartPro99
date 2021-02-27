unit Module.ServerMethod;

interface

uses
  System.SysUtils, System.Classes, uDWAbout, uRESTDWServerEvents, uDWDataModule,
  uDWJSONObject, System.json;

type
  TDmServerMethod = class(TServerMethodDataModule)
    DWSEvents: TDWServerEvents;
    procedure DWServerEvents1EventsHoraReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWSEventsEventsVersaoReplyEvent(var Params: TDWParams;
      var Result: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmServerMethod: TDmServerMethod;

implementation

uses
  uDWConsts, View.FrmPrincipal;

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

procedure TDmServerMethod.DWServerEvents1EventsHoraReplyEvent
  (var Params: TDWParams; var Result: string);
begin
  Result := '{"hora":"' + FormatDateTime('hh:mm:ss', now) + '"}'

end;

procedure TDmServerMethod.DWSEventsEventsVersaoReplyEvent(var Params: TDWParams;
  var Result: string);
begin
  Result := '{"Versao":"'+FrmPrincipal.cVersao+'"}'

end;

end.
