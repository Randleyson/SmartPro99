unit Module.DmConfiguracao;

interface

uses
  System.SysUtils, System.Classes, System.IniFiles, Dao.ConexaoDB;

type
  TDmConfiguracao = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    fPathConfigIni: string;
    DaoConexao: TDaoConexaoDB;
    procedure UpdateNaoExitenteArquivo;
    function CodbarraDaLinhha(pLinha: String): String;
    function DescricaoDaLinhha(pLinha: String): String;
    function VrvendaDaLinhha(pLinha: String): String;
  public
    { Public declarations }
    function GetConfig(pSecao, pValue: String): String;
    procedure SetConfig(pSecao, pParament, pValue: String);
    procedure SincronizarProdutos;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses Controller.oConfiguracao;
{$R *.dfm}
{ TDataModule1 }

function TDmConfiguracao.CodbarraDaLinhha(pLinha: String): String;
begin

end;

procedure TDmConfiguracao.DataModuleCreate(Sender: TObject);
begin
  fPathConfigIni := ExtractFilePath(ParamStr(0)) + 'Config.ini';;
end;

function TDmConfiguracao.DescricaoDaLinhha(pLinha: String): String;
begin

end;

function TDmConfiguracao.GetConfig(pSecao, pValue: String): String;
var
  FArquivoINI: TIniFile;
begin

  FArquivoINI := TIniFile.Create(fPathConfigIni);
  try
    try
      if not FileExists(fPathConfigIni) then
        raise Exception.Create('Arquivo config.ini nao exite');
      Result := FArquivoINI.ReadString(pSecao, pValue, '');

    except
      raise;

    end;
  finally
    FArquivoINI.Free;
  end;

end;

procedure TDmConfiguracao.SetConfig(pSecao, pParament, pValue: String);
var
  FArquivoINI: TIniFile;
begin

  FArquivoINI := TIniFile.Create(fPathConfigIni);
  try
    FArquivoINI.WriteString(pSecao, pParament, pValue);
  finally
    FArquivoINI.Free;
  end;

end;

procedure TDmConfiguracao.SincronizarProdutos;
var
  vArquivoIntegracao: TextFile;
  vStringLinha,vCodbarra,vDescricao,vVrvenda: String;
begin

  AssignFile(vArquivoIntegracao, oConfiguracao.PathAquivoIntegracao);
  try
    try
      reset(vArquivoIntegracao);
      UpdateNaoExitenteArquivo;

      while not EOF(vArquivoIntegracao) do
      begin
        Readln(vArquivoIntegracao, vStringLinha);

        if Length(vStringLinha) < 50 then
        exit;


      end;


        //vCodbarra := ExtraiCodBarra(fLinha);
        //vDescricao := ExtraiDescricao(fLinha);
        //vVrVenda := ExtraiVrvenda(fLinha);

      //if CodBarraExite(vCodbarra) then
       // dmPrincipal.UpdateProduto(vCodbarra, vDescricao, vVrVenda)
      //else
      //  dmPrincipal.InserieProduto(vCodbarra, vDescricao, vVrVenda);

    except
    end;

  finally
    CloseFile(vArquivoIntegracao);
  end;

  {
    while not EOF(fArquivoTxt) do

    var
    vCodbarra,vDescricao,vVrvenda: string;




    Readln(frmPrincipal.fArquivoTxt,fLinha);

    if Length(fLinha) < 50 then
    exit;

    vCodbarra  := ExtraiCodBarra(fLinha);
    vDescricao := ExtraiDescricao(fLinha);
    vVrVenda   := ExtraiVrvenda(fLinha);

    if CodBarraExite(vCodbarra) then
    dmPrincipal.UpdateProduto(vCodbarra,vDescricao,vVrVenda)
    else
    dmPrincipal.InserieProduto(vCodbarra,vDescricao,vVrVenda);
    LerLinhaArquivo;

    //DELETAS PRODUTOS




  }

end;

procedure TDmConfiguracao.UpdateNaoExitenteArquivo;
var
  vSQL: String;
begin

  vSQL := 'Update produtos set EXISTENOARQ = ''N''';
  DaoConexao := TDaoConexaoDB.Create(Nil);
  try
    DaoConexao.FDConn.ExecSQL(vSQL);
    DaoConexao.FDConn.Commit;

  finally
    FreeAndNil(DaoConexao);
  end;

end;

function TDmConfiguracao.VrvendaDaLinhha(pLinha: String): String;
begin

end;

end.
