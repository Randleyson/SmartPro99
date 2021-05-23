unit uDm;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  uFiredac, FMX.StdCtrls;

type
  TDm = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    uFiredac: TFiredac;
    FCodBarra: String;
    FDescricao: String;
    FVrVenda: String;
    FUnidade: String;
    function Unidade: String;
  public
    { Public declarations }
    function JSONArrayTv: TJSONArray;
    function JSONArrayProduto( aParant: Integer): TJSONArray;
    procedure SincronizarProdutos(pProgressBar: TProgressBar; aPathArquivo: String);
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

procedure TDm.SincronizarProdutos(pProgressBar: TProgressBar; aPathArquivo: String);
var

  vTextFile: TextFile;
  vLinha: String;
  vDataSet: TDataSet;
  vStringList: TStringList;
begin
  pProgressBar.Value   := 1;
  vStringList := TStringList.Create;
  try
    vStringList.LoadFromFile(aPathArquivo);
    pProgressBar.Max := vStringList.Count;
  finally
    vStringList.DisposeOf;
  end;

  uFiredac
    .Active(False)
      .SQLClear
        .SQL('Update produtos set EXISTENOARQ = :PARANTER')
        .AddParan('PARANTER','N')
      .ExceSQL;

  AssignFile(vTextFile, aPathArquivo);
  reset(vTextFile);
  try
    while not EOF(vTextFile) do
    begin
      Readln(vTextFile, vLinha);
      if Length(vLinha) < 50 then
        Exit;
      FCodBarra := Copy(vLinha, 6, 6);
      FDescricao := Copy(vLinha, 21, 25);
      FVrVenda := Copy(Copy(vLinha, 12, 6), 0, 4) + '.' + Copy(Copy(vLinha, 12, 6), 5, 2);
      FUnidade := Copy(vLinha,5,1);
      if uFiredac
          .Active(False)
            .SQLClear
            .SQL('select * from produtos where codbarra = :CODBARRA')
            .AddParan('CODBARRA',FCodBarra)
            .Open
          .DataSet.RecordCount > 0 then
        uFiredac
          .Active(False)
            .SQLClear
            .SQL(' update produtos set descricao = :DESCRICAO,')
            .SQL(' vrvenda = :VRVENDA, Unidade = :UNIDADE, EXISTENOARQ= :EXISTENOARQ')
            .SQL(' WHERE codbarra = :CODBARRA')
            .AddParan('DESCRICAO',FDescricao)
            .AddParan('VRVENDA',FVrVenda)
            .AddParan('UNIDADE',Unidade)
            .AddParan('EXISTENOARQ','S')
            .AddParan('CODBARRA',FCodBarra)
          .ExceSQL
      else
        uFiredac
          .Active(False)
            .SQLClear
            .SQL('INSERT INTO produtos (codbarra,descricao,vrvenda,unidade,existenoarq)')
            .SQL(' values (:CODBARRA, :DESCRICAO, :VRVENDA,:UNIDADE, :EXISTENOARQ)')
            .AddParan('CODBARRA',FCodBarra)
            .AddParan('DESCRICAO',FDescricao)
            .AddParan('VRVENDA',FVrVenda)
            .AddParan('UNIDADE',Unidade)
            .AddParan('EXISTENOARQ','S')
          .ExceSQL;
      pProgressBar.Value := pProgressBar.Value + 1
    end;
    uFiredac
      .Active(False)
        .SQLClear
        .SQL('Delete from produtos where EXISTENOARQ = :EXISTENOARQ')
        .AddParan('EXISTENOARQ','N')
      .ExceSQL;
  finally
    CloseFile(vTextFile);
  end;
end;


function TDm.Unidade: String;
begin
  case StrToInt(FUnidade) of
  0:  Result := 'KG';
  1: Result  := 'UN';
  end;

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
