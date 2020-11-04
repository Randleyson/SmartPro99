unit SmartPro99.Model.Tvs;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.StorageBin;

type
  TModelTvs = class(TDataModule)
    FQryTv: TFDQuery;
    FMenTv: TFDMemTable;
    FQryProdutos: TFDQuery;
    FMentProdNaoTv: TFDMemTable;
    FMentProdNaTv: TFDMemTable;
    FMentTabProdTv: TFDMemTable;
    FMentProdNaoTvCODBARRA: TStringField;
    FMentProdNaoTvDESCRICAO: TStringField;
    FMentProdNaoTvVRVENDA: TFMTBCDField;
    FMentProdNaoTvDESCRICAOALTERADA: TStringField;
    FMentProdNaoTvEXISTENOARQ: TStringField;
    FMentProdNaTvCODBARRA: TStringField;
    FMentProdNaTvDESCRICAO: TStringField;
    FMentProdNaTvVRVENDA: TFMTBCDField;
    FMentProdNaTvDESCRICAOALTERADA: TStringField;
    FMentProdNaTvEXISTENOARQ: TStringField;
    FQryTabProdTv: TFDQuery;
    FMentTabProdTvCODBARRA: TStringField;
    FMentTabProdTvIDTV: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RecebeProdNaoTv(pIdTv: Integer);
    procedure RecebeProdNaTv(pIdTv: Integer);
    procedure RecebeTabProdTv(pIdTv: Integer);
    procedure RecebeTv;


    function InsertTv(pDescricao: String): integer;
    procedure UpdateTv(pDescricao: String; pIdTv: integer);
    procedure DeleteTV(pIdtv: Integer);

    procedure MarcaProdTvExcluir(pIdtv: Integer);
    procedure RemoverProdTvExcluido;


  end;

var
  ModelTvs: TModelTvs;

implementation

uses
  SmartPro99.Model.Principal, SmartPro99.View.Principal,
  SmartPro99.Model.Conexao;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

function TModelTvs.InsertTv(pDescricao: String): integer;
var
  vSQL,vIdTv: string;

begin

  vIdTv := ModelPrincipal.IdTabela('idtv','tv');

  vSQL := 'Insert into tv (idtv,descricaoTv) values'+
          ' ('+ vIdtv + ','+
          QuotedStr(UpperCase(pDescricao))+')';

  try

    ModelPrincipal.ExcuteSQL(vSQL);
    Result := StrToInt(vIdTv);

  except
    ViewPrincipal.fMensagemErro := 'Erro ao tentar GravarTv no banco de dados';
    raise

  end;

end;

procedure TModelTvs.MarcaProdTvExcluir(pIdtv: Integer);
var
  vSQL: string;
begin

  vSQL := 'update tv_prod set IDR = ''E'' where idtv = '+ IntToStr(pIdtv);

  try

    ModelPrincipal.ExcuteSQL(vSQL);

  except
    ViewPrincipal.FMensagemErro := 'Erro a executar MarcaProdTvExcluir';
    raise;

  end;

end;

procedure TModelTvs.DataModuleCreate(Sender: TObject);
begin

  try

    FQryProdutos.Close;
    FQryTabProdTv.Close;
    FMentProdNaoTv.Close;
    FMentProdNaTv.Close;
    FMentTabProdTv.Close;

    FQryTv.Close;
    FMenTv.Close;

  except
    ViewPrincipal.FMensagemErro := 'Erro ao DataModuleCreate';
    raise

  end;


end;

procedure TModelTvs.DeleteTV(pIdtv: Integer);
var
  vSQL1,vSQL2: String;
begin

  vSQL1 := 'delete from tv_prod where idtv = '+ IntToStr(pIdtv);
  vSQL2 := 'delete from tv where idtv = '+ IntToStr(pIdtv);


  try

    ModelPrincipal.ExcuteSQL(vSQL1);
    ModelPrincipal.ExcuteSQL(vSQL2);

  except
    ViewPrincipal.FMensagemErro := 'Erro ao excluiar a Tv';
    raise

  end;

end;

procedure TModelTvs.RecebeProdNaoTv(pIdTv: Integer);
var
  vSQL: String;
begin

  vSQL := 'select * from produtos '+
          ' where codbarra not in (select codbarra from tv_prod '+
                                  ' where idtv = '+ IntToStr(pIdTv)+ ')';

  try

    try

      ModelConexao.AbreConexaoDb;
      FQryProdutos.Close;
      FQryProdutos.SQL.Text := '';
      FQryProdutos.SQL.Add(vSQL);
      FQryProdutos.Open();

      FMentProdNaoTv.Close;
      FMentProdNaoTv.Open;
      FMentProdNaoTv.EmptyDataSet;
      ModelPrincipal.CopyDataSet(FQryProdutos,FMentProdNaoTv);
      FMentProdNaoTv.Filtered := False;

    except
      ViewPrincipal.FMensagemErro := 'Erro ao RecebeProdNaoTv';
      raise
    end;

  finally
    FQryProdutos.Close;
    ModelConexao.FechaConexaoDb;

  end;

end;

procedure TModelTvs.RecebeProdNaTv(pIdTv: Integer);
var
  vSQL: String;
begin
  vSQL := 'select * from produtos '+
          ' where codbarra in (select codbarra from tv_prod '+
                                  ' where idtv = '+ IntToStr(pIdTv)+ ')';

  try
    try

      ModelConexao.AbreConexaoDb;
      FQryProdutos.Close;
      FQryProdutos.SQL.Text := '';
      FQryProdutos.SQL.Add(vSQL);
      FQryProdutos.Open;

      FMentProdNaTv.Close;
      FMentProdNaTv.Open;
      FMentProdNaTv.EmptyDataSet;
      ModelPrincipal.CopyDataSet(FQryProdutos,FMentProdNaTv);
      FMentProdNaTv.Filtered := False;

    except
      ViewPrincipal.FMensagemErro := 'Erro ao RecebeProdNaoTv';
      raise

    end;

  finally
    FQryProdutos.Close;
    ModelConexao.FechaConexaoDb;

  end;

end;

procedure TModelTvs.RecebeTabProdTv(pIdTv: Integer);
begin

  try
    try

      ModelConexao.AbreConexaoDb;
      FQryTabProdTv.Close;
      FQryTabProdTv.Open();
      FQryTabProdTv.Filter := 'idtv = '+ IntToStr(pIdTv);
      FQryTabProdTv.Filtered := True;

      FMentTabProdTv.Close;
      FMentTabProdTv.Open;
      FMentTabProdTv.EmptyDataSet;
      ModelPrincipal.CopyDataSet(FQryTabProdTv,FMentTabProdTv);
      FMentTabProdTv.Filtered := False;

    except
      ViewPrincipal.FMensagemErro := 'Erro ao RecebeProdNaoTv';
      raise

    end;

  finally
    FQryTabProdTv.Close;
    ModelConexao.FechaConexaoDb;

  end;

end;

procedure TModelTvs.RecebeTv;
begin

  try

    try

      ModelConexao.AbreConexaoDb;
      FQryTv.Close;
      FQryTv.Filtered := False;
      FQryTv.Open;

      FMenTv.Close;
      FMenTv.Open;
      FMenTv.EmptyDataSet;
      ModelPrincipal.CopyDataSet(FQryTv,FMenTv);
      FMenTv.Filtered := False;

    except
      ViewPrincipal.FMensagemErro := 'Erro ao RecebeProdNaoTv';
      raise

    end;

  finally
    FQryTv.Close;
    ModelConexao.FechaConexaoDb;

  end;

end;

procedure TModelTvs.RemoverProdTvExcluido;
var
  vSQL: String;
begin

  vSQL := 'delete from tv_prod where IDR = ''E''';

  try

    ModelPrincipal.ExcuteSQL(vSQL);

  except
    ViewPrincipal.FMensagemErro := 'Erro ao executar procedure UpdateTv';
    raise

  end;

end;

procedure TModelTvs.UpdateTv(pDescricao: String; pIdTv: integer);
var
  vSQL: String;
begin

  vSQL := 'Update tv set descricaotv = '+ QuotedStr(UpperCase(pDescricao))+ ' where idtv = '+ IntToStr(pIdTv);

  try

    ModelPrincipal.ExcuteSQL(vSQL);

  except
    ViewPrincipal.FMensagemErro := 'Erro ao executar procedure UpdateTv';
    raise

  end;

end;

end.
