unit udm_CadTv;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.StorageBin;

type
  TdmCadTv = class(TDataModule)
    FQryProdNaoTv: TFDQuery;
    FQryProdNaTv: TFDQuery;
    FQryTv: TFDQuery;
    FMenTv: TFDMemTable;
    FMenProdutos: TFDMemTable;
    FQryProdutoTv: TFDQuery;
    FMenProdutosCODBARRA: TStringField;
    FMenProdutosDESCRICAO: TStringField;
    FMenProdutosVRVENDA: TFMTBCDField;
    FMenProdutosIDTV: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
    function InseriTv(pDescricao: String): integer;
    procedure AlteraTv(pIdTv: integer; pDescricao: String);


    procedure CopyDataSet(pDataSetSaida,pDataSetEntrada: TDataSet);
    //procedure FQryTvToFMenTv;
    //procedure AbreFMenProdutoTv;
    procedure InserirProdutoNaTv(pCodBarra: String;pIdTv: Integer);
    procedure RemoveProdutoDaTv(pCodBarra: String;pIdTv: Integer);
    procedure InserirTodosProdNaTv(pIdtv: Integer);
    procedure RemoverTodosProdTv(pIdtv: Integer);
    Function InserieNovaTv: String;

    procedure GravarProtTv(pIdtv,pCodBarra: string);
    procedure ExcluTv(pIdtv: Integer);

  end;

var
  dmCadTv: TdmCadTv;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses ufrm_Principal, udm_Principal, udm_Conexao;

{$R *.dfm}



procedure TdmCadTv.InserirProdutoNaTv(pCodBarra: String; pIdTv: Integer);
var
  vSQL: String;
begin

  vSQL := 'Insert into tv_prod (codbarra,idtv) values'+
          '( '+ QuotedStr(pCodBarra)+ ','+ IntToStr(pIdTv)+ ')';

  try
     DmPrincipal.ExcuteSQL(vSQL);
  except
    frmPrincipal.fMensagemErro := 'Não foi possivel Inserir o produto na Tv';
    raise
  end;

end;

procedure TdmCadTv.RemoveProdutoDaTv(pCodBarra: String; pIdTv: Integer);
var
  vSQL: String;
begin

  vSQL := 'Delete from tv_prod where codbarra = ' + QuotedStr(pCodBarra)+
          ' and idtv = '+ IntToStr(pIdTv);
  try
    DmPrincipal.ExcuteSQL(vSQL);
  except
    frmPrincipal.fMensagemErro := 'Não foi possivel RemoveProdutoDaTv';
    raise
  end;

end;

procedure TdmCadTv.InserirTodosProdNaTv(pIDTV: Integer);
var
  vSQL: String;
begin

  vSQL := 'Insert into tv_prod (codbarra,idtv) select codbarra, '+ IntToStr(pIDTV) +
          ' from produtos where codbarra not in (select codbarra from tv_prod '+
          '                                      where idtv = '+ IntToStr(pIDTV)+')';
  try
    DmPrincipal.ExcuteSQL(vSQL);
  except
    frmPrincipal.fMensagemErro := 'Não foi possivel InserirTodosProdNaTv';
    raise
    
  end;

end;

procedure TdmCadTv.RemoverTodosProdTv(pIDTV: Integer);
var
  vSQL: String;
begin

  vSQL := 'Delete from tv_prod'+
          ' where idtv = '+ IntToStr(pIdTv);
          
  try
    DmPrincipal.ExcuteSQL(vSQL);
  except
    frmPrincipal.fMensagemErro := 'Não foi possivel InserirTodosProdNaTv';
    raise  
  end;

end;

function TdmCadTv.InserieNovaTv: String;
var
  vSQL,vId: string;
begin

  try
    vId  := DmPrincipal.IdTabela('idtv','tv');
    vSQL := 'Insert into tv (idtv,descricaotv) values ('+ vId +','''')';
    DmPrincipal.ExcuteSQL(vSQL);
    Result := vId;
  except
    frmPrincipal.fMensagemErro := 'Não foi possivel InserirTodosProdNaTv';
    raise  
  
  end; 

end;

procedure TdmCadTv.GravarProtTv(pIdtv, pCodBarra: string);
begin




end;

function TdmCadTv.InseriTv(pDescricao: String): integer;
var
  vSQL,vIdTv: string;

begin

  vIdTv := DmPrincipal.IdTabela('idtv','tv');

  vSQL := 'Insert into tv (idtv,descricaoTv) values'+
          ' ('+ vIdtv + ','+
          QuotedStr(UpperCase(pDescricao))+')';

  try

    DmPrincipal.ExcuteSQL(vSQL);
    Result := StrToInt(vIdTv);

  except
    frmPrincipal.fMensagemErro := 'Erro ao tentar GravarTv no banco de dados';
    raise

  end;

end;

{
procedure TdmCadTv.FQryTvToFMenTv;
begin

  try
    try
      DmConexao.AbreConexaoDb;

      FQryTv.Close;
      FQryTv.Filtered := False;
      FQryTv.Open();

      FMenTv.Close;
      FMenTv.CopyDataSet(FQryTv);
      FMenTv.Filtered := False;
      FMenTv.Open;
    except
      frmPrincipal.FMensagemErro := 'Erro ao AbreFMenTv';
      raise
    end;

  finally
    FQryTv.Close;
    DmConexao.FechaConexaoDb;

  end;

end;    }

procedure TdmCadTv.AlteraTv(pIdTv: integer; pDescricao: String);
var
  vSQL : String;
begin

  vSQL := 'Update tv set DescricaoTv = '+ QuotedStr(UpperCase(pDescricao))+
          ' where idtv = '+ IntToStr(pIdTv);

  try

    DmPrincipal.ExcuteSQL(vSQL);

  except
    frmPrincipal.fMensagemErro := 'Erro ao tentar GravarTv no banco de dados';
    raise;

  end;

end;

procedure TdmCadTv.CopyDataSet(pDataSetSaida, pDataSetEntrada: TDataSet);
begin


  try
    try
      DmConexao.AbreConexaoDb;

      pDataSetSaida.Close;
      pDataSetSaida.Filtered := False;
      pDataSetSaida.Open();

      pDataSetEntrada.Close;
      TFDMemTable(pDataSetEntrada).CopyDataSet(pDataSetSaida);
      pDataSetEntrada.Filtered := False;
      pDataSetEntrada.Open;

    except
      frmPrincipal.FMensagemErro := 'Erro ao AbreFMenTv';
      raise
    end;

  finally

    pDataSetSaida.Close;
    DmConexao.FechaConexaoDb;

  end;


end;

{
procedure TdmCadTv.AbreFMenProdutoTv;
begin

  try

    try
      DmConexao.AbreConexaoDb;

      FQryProdutoTv.Close;
      FQryProdutoTv.Filtered := False;
      FQryProdutoTv.Open();

      FMenProdutos.Close;
      FMenProdutos.CopyDataSet(FQryProdutoTv);
      FQryProdutoTv.Filtered := False;
      FQryProdutoTv.Open;

    except
      frmPrincipal.FMensagemErro := 'Erro ao AbirFMenProdutoTv';
      raise
    end;

  finally
    FQryProdutoTv.Close;
    DmConexao.FechaConexaoDb;

  end;

end; }

procedure TdmCadTv.ExcluTv(pIdtv: Integer);
var
  vSQL: String;
begin

  try

    {EXCLUI PROD TV}
    vSQL := 'delete from tv_prod where idtv = '+ IntToStr(pIdtv);
    DmPrincipal.ExcuteSQL(vSQL);

    {EXCLUI TV}
    vSQL := 'delete from tv where idtv = '+ IntToStr(pIdtv);
    DmPrincipal.ExcuteSQL(vSQL);

  except
    frmPrincipal.FMensagemErro := 'Erro ao excluiar a Tv';

  end;

end;

end.
