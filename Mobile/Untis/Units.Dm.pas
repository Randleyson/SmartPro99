unit Units.Dm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.JSON, uRestDataWare, uFiredac;

type
  TDm = class(TDataModule)
    FMenProduto: TFDMemTable;
    FMenTvs: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    uRestDataWare: TRestDataWare;
    uFiredac: TFiredac;
    FJOSNArray: TJSONArray;
    FIdTV: Integer;
    FHostServer: String;
  public
    { Public declarations }
    function ReloandProdutos: Integer;
    procedure ReloandTv;
    function DS_Produtos: TFDMemTable;
    function DS_Tvs: TFDMemTable;
    function IdTv: Integer; overload;
    function IdTv( aValue: Integer): TDm; overload;
    function HostServer: String; overload;
    function HostServer( aValue: String): TDm; overload;
    function GravarTv: TDm;
    function GravarServer: TDm;
  end;

var
  Dm: TDm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TDm }

procedure TDm.DataModuleCreate(Sender: TObject);
var
  vDataSet: TDataSet;
begin
  uFiredac := TFiredac.New;
  vDataSet := uFiredac
                  .Active(False)
                  .SQLClear
                  .SQL('select idtv, hostserver, portaserver from tab_configuracoes')
                .Open
               .DataSet;
  try
    FHostServer := vDataSet.FieldByName('hostserver').AsString + ':' + vDataSet.FieldByName('portaserver').AsString;
    FIdTV := vDataSet.FieldByName('Idtv').AsInteger;
    uRestDataWare := TRestDataWare.Create;
    uRestDataWare.HostServer(FHostServer);
  finally
    uFiredac.Active(False);
  end;

end;

procedure TDm.DataModuleDestroy(Sender: TObject);
begin
  uRestDataWare.DisposeOf;
  uFiredac.DisposeOf;
end;

function TDm.GravarServer: TDm;
begin
  Result := Self;
  uFiredac
    .Active(False)
    .SQLClear
      .SQL('update tab_configuracoes set hostServer = :HOSTSERVER')
      .AddParan('HOSTSERVER',FHostServer)
    .ExceSQL;
end;

function TDm.GravarTv: TDm;
begin
  Result := Self;
  uFiredac
    .Active(False)
    .SQLClear
      .SQL('update tab_configuracoes set idtv = :IDTV')
      .AddParan('IDTV',FIdTV)
    .ExceSQL;
end;

function TDm.HostServer(aValue: String): TDm;
begin
  Result := Self;
  FHostServer := aValue;
end;

function TDm.HostServer: String;
begin
  Result := FHostServer;
end;

function TDm.IdTv(aValue: Integer): TDm;
begin
  Result := Self;
  FIdTV := aValue;
end;

function TDm.IdTv: Integer;
begin
  Result := FIdTV;
end;

function TDm.DS_Produtos: TFDMemTable;
begin
  Result := FMenProduto;
end;

function TDm.DS_TVs: TFDMemTable;
begin
  Result := FMenTvs;
end;

function TDm.ReloandProdutos: Integer;
var
  i: Integer;
begin
  Result := 1;
  //Receber Produtos Server
  FJOSNArray := Nil;
  FJOSNArray := uRestDataWare
                  .Resource('ProdutosTv')
                  .ClearParans
                    .AddParameter('Idtv',FIdTv)
                  .Execute
                .JSONArray;

  if uRestDataWare.StatusCode = 200 then
  begin
    try
      Result := 0;
      //Insert no banco Local
      uFiredac
        .Active(False)
        .SQLClear.SQL('update tab_produtos set ie = ''E''')
      .ExceSQL;

      try
        for I := 0 to (FJOSNArray.Size - 1) do
        begin
          uFiredac
            .Active(False)
              .SQLClear
              .SQL('Insert Into tab_produtos (codbarra,descricao,vrvenda,unidade,ie) values ')
              .SQL(' (:CODBARRA, :DESCRICAO, :VRVENDA, :UNIDADE, :IE)')
              .AddParan('CODBARRA',FJOSNArray.Get(I).GetValue<String>('codbarra'))
              .AddParan('DESCRICAO',FJOSNArray.Get(I).GetValue<String>('descricao'))
              .AddParan('VRVENDA',FJOSNArray.Get(I).GetValue<String>('vrvenda'))
              .AddParan('UNIDADE',FJOSNArray.Get(I).GetValue<String>('unidade'))
              .AddParan('IE','I')
            .ExceSQL;
        end;
      finally
        FJOSNArray.DisposeOf;
      end;

      uFiredac
        .Active(False)
          .SQLClear.SQL('delete from tab_produtos where ie = ''E''')
        .ExceSQL;
    except
      uFiredac
        .Active(False)
        .SQLClear.SQL('delete from tab_produtos where ie = ''I''')
      .ExceSQL;

      uFiredac
        .Active(False)
        .SQLClear.SQL('update tab_produtos set ie = ''I''')
      .ExceSQL;
      raise;
    end;
  end;

  if FMenProduto.Active then
  begin
    FMenProduto.EmptyDataSet;
    FMenProduto.Close;
  end;
  FMenProduto.CloneCursor(uFiredac
                            .Active(False)
                            .SQLClear
                            .SQL('select * from tab_Produtos')
                          .Open
                          .DataSet);
end;

procedure TDm.ReloandTv;
var
  i: Integer;
begin

  //Receber Tvs do server;
  FJOSNArray := Nil;
  FJOSNArray := uRestDataWare
                  .Resource('ListaTvs')
                  .ClearParans
                  .Execute
                .JSONArray;

  if uRestDataWare.StatusCode <> 200 then
  begin
    try
      //Inserir Tvs no banco Local;
      uFiredac
        .Active(False)
          .SQLClear
          .SQL('update tab_tvs set ie = ''E''')
        .ExceSQL;

      for I := 0 to (FJOSNArray.Size - 1) do
      begin
        uFiredac
          .Active(False)
            .SQLClear
            .SQL('Insert Into tab_tvs (idtv,descricao,ie) values ')
            .SQL(' (:IDTV, :DESCRICAO, :IE) ')
            .AddParan('IDTV',FJOSNArray.Get(I).GetValue<String>('idtv'))
            .AddParan('DESCRICAO',FJOSNArray.Get(I).GetValue<String>('descricao'))
            .AddParan('IE','I')
          .ExceSQL;
      end;
    finally
      FJOSNArray.DisposeOf;
    end;

    uFiredac
      .Active(False)
        .SQLClear.SQL('delete from tab_tvs where ie = ''E''')
      .ExceSQL;
  end;

  if FMenTvs.Active then
  begin
    FMenTvs.EmptyDataSet;
    FMenTvs.Close;
  end;
  FMenTvs.CloneCursor(uFiredac
                          .Active(False)
                            .SQLClear
                              .SQL('select * from tab_Tvs')
                            .Open
                            .DataSet);
end;



end.
