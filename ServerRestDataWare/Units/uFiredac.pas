unit uFiredac;

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
  FireDAC.Dapt
  {$IFDEF ANDROID}
  ,System.IOUtils
  {$ENDIF};

type
  TFiredac = class
    private
      FDConnection: TFDConnection;
      FQuery: TFDQuery;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: TFiredac;
      function Active (aValue: Boolean): TFiredac;
      function AddParan(aParem: String; aValue: Variant): TFiredac;
      function DataSet: TDataSet;
      function ExceSQL: TFiredac;
      function Open: TFiredac;
      function SQL(aValue: String) : TFiredac;
      function SQLClear: TFiredac;
  end;

implementation

uses
  System.SysUtils, System.IniFiles;

{ TModelComponnentsConeectionFiredac }

function TFiredac.Active(aValue: Boolean): TFiredac;
begin
  Result := Self;
  fQuery.Active := aValue;
end;

function TFiredac.AddParan(aParem: String; aValue: Variant): TFiredac;
begin
  Result := Self;
  FQuery.ParamByName(aParem).Value := aValue;
end;

constructor TFiredac.Create;
var
  vArquivoINI: TIniFile;
  vCaminhoDB: String;
begin

  vArquivoINI := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.ini');
  try
    vCaminhoDB := vArquivoINI.ReadString('BancoDados', 'CaminhoDB', '');
  finally
    vArquivoINI.DisposeOf;
  end;


  FDConnection := TFDConnection.Create(Nil);
  FQuery := TFDQuery.Create(Nil);
  FQuery.Connection := FDConnection;
  FDConnection.Params.Add('Database='+ vCaminhoDB);
  FDConnection.Params.Add('User_Name=sysdba');
  FDConnection.Params.Add('Password=masterkey');
  FDConnection.Params.Add('DriverID=FB');


  try
    FDConnection.Connected := True;
  Except
    raise Exception.Create('Erro ao conectar a banco de dados');
  end;

end;

function TFiredac.DataSet: TDataSet;
begin
  Result := fQuery;
end;

destructor TFiredac.Destroy;
begin
  FQuery.DisposeOf;
  FDConnection.DisposeOf;
  inherited;
end;

function TFiredac.ExceSQL: TFiredac;
begin
  Result := Self;
  FQuery.ExecSQL;
end;

class function TFiredac.New: TFiredac;
begin
  Result := Self.Create;
end;

function TFiredac.Open: TFiredac;
begin
  Result := Self;
  FQuery.Open;
end;

function TFiredac.SQL(aValue: String): TFiredac;
begin
  Result := self;
  FQuery.SQL.Add(aValue);
end;

function TFiredac.SQLClear: TFiredac;
begin
  Result := self;
  FQuery.SQL.Clear;
end;

end.
