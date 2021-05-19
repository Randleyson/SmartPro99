unit uDm;

interface

uses
  System.SysUtils, System.Classes, System.JSON, uFiredac;

type
  TDm = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    uFiredac: TFiredac;
  public
    { Public declarations }
    function JSONArrayTv: TJSONArray;
    function JSONArrayProduto( aParant: Integer): TJSONArray;
  end;

var
  Dm: TDm;

implementation

uses
  Data.DB;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDm.DataModuleCreate(Sender: TObject);
begin
  uFiredac := TFiredac.New;
end;

procedure TDm.DataModuleDestroy(Sender: TObject);
begin
  uFiredac.DisposeOf;
end;

function TDm.JSONArrayProduto(aParant: Integer): TJSONArray;
var
  DataSet: TDataSet;
  JSONArray: TJSONArray;
  JSON: TJSONObject;
begin
  DataSet := uFiredac.Active(False)
              .SQLClear
              .SQL(' select codbarra,descricao,vrvenda,unidade from produtos p ')
              .SQL(' left join tv_prod tp on tp.codproduto = p.codbarra ')
              .SQL(' where codtv = :IDTV ')
              .AddParan('IDTV', IntToStr(aParant))
              .Open
            .DataSet;

  try
    JSONArray := TJSONArray.Create;
    DataSet.First;
    while not DataSet.Eof do
    begin
      JSON := TJSONObject.Create;
      JSON.AddPair('codbarra',DataSet.Fields[0].AsString);
      JSON.AddPair('descricao',DataSet.Fields[1].AsString);
      JSON.AddPair('vrvenda',DataSet.Fields[2].AsString);
      JSON.AddPair('unidade',DataSet.Fields[3].AsString);
      JSONArray.AddElement(JSON);
      DataSet.Next;
    end;
    Result := JSONArray;
  finally
    uFiredac.Active(False);
  end;
end;

function TDm.JSONArrayTv: TJSONArray;
var
  DataSet: TDataSet;
  JSONArray: TJSONArray;
  JSON: TJSONObject;
begin

  DataSet := uFiredac.Active(False).SQLClear.SQL('select idtv,descricao from tvs order by idtv').Open.DataSet;
  try
    JSONArray := TJSONArray.Create;
    DataSet.First;
    while not DataSet.Eof do
    begin
      JSON := TJSONObject.Create;
      JSON.AddPair('idtv',DataSet.Fields[0].AsString);
      JSON.AddPair('descricao',DataSet.Fields[1].AsString);
      JSONArray.AddElement(JSON);
      DataSet.Next;
    end;
    Result := JSONArray;
  finally
    uFiredac.Active(False);
  end;

end;

end.
