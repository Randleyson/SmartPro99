unit ServerMethods;

interface

uses System.SysUtils, System.Classes, System.Json,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.StorageJSON,
  FireDAC.Stan.StorageBin,Data.FireDACJSONReflect;

type
  TServerMethods1 = class(TDSServerModule)
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;

    procedure SincronizaTxtToFreeboard;
    function Get(const pSQL : String): TFDJSONDataSets;
  end;

implementation


{$R *.dfm}


uses System.StrUtils, udm_Principal, FireDAC.Comp.Client, ufrm_Principal,
  udm_Conexao;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.Get(const pSQL: String): TFDJSONDataSets;
var
  FDQTemp: TFDQuery;
begin

  try

    try
      FDQTemp            := TFDQuery.create(nil);

      FDQTemp.Connection := dmConexao.FDC_Freeboard;
      FDQTemp.Active     := False;

      Result            := TFDJSONDataSets.Create;
      FDQTemp.SQL.Text   := pSQL;
      FDQTemp.Active     := True;

      TFDJSONDataSetsWriter.ListAdd(Result, FDQTemp);

    except
    on e: exception do
      raise

    end;

  finally
    
  end;
end;


function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

procedure TServerMethods1.SincronizaTxtToFreeboard;
begin

  frmPrincipal.SicronizaProduto;

end;

end.

