unit SmartPro99.Model.Conexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  System.IOUtils,Vcl.Forms,FireDAC.VCLUI.Wait;

type
  TModelConexao = class(TDataModule)
    FDC_Freeboard: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ConectaFreeboard;
  public
    { Public declarations }
    procedure AbreConexaoDb;
    procedure FechaConexaoDb;
  end;

var
  ModelConexao: TModelConexao;

implementation

uses
  SmartPro99.View.Principal;

{%CLASSGROUP 'FMX.Controls.TControl'}


{$R *.dfm}

procedure TModelConexao.AbreConexaoDb;
begin

  FDC_Freeboard.Connected := True;

end;

procedure TModelConexao.ConectaFreeboard;
begin

  try

    if not FileExists(ExtractFileDir(application.ExeName+'\Config.ini')) then
    begin
      ViewPrincipal.fComErro      := True;
      ViewPrincipal.fMensagemErro := 'Não foi encontrado o arquivo de configuração';
      exit;
    end;

    FDC_Freeboard.Connected                   := False;
    FDC_Freeboard.LoginPrompt                 := False;
    FDC_Freeboard.Params.Clear;
    FDC_Freeboard.Params.LoadFromFile(ExtractFileDir(application.ExeName) + '\Config.ini');
    FDC_Freeboard.Connected                   := True;
    FDC_Freeboard.Connected                   := False;
    ViewPrincipal.fComErro                     := False;

  except
    on e: Exception do
    begin
      ViewPrincipal.fMensagemErro := ' Erro ao tentar se conectar a base da dados freeboard '+ e.Message;
      ViewPrincipal.fComErro      := True;
      raise
    end;

  end;

end;

procedure TModelConexao.DataModuleCreate(Sender: TObject);
begin

  try

    ConectaFreeboard;

  except
    raise
  end;

end;

procedure TModelConexao.FechaConexaoDb;
begin

  FDC_Freeboard.Connected := False;

end;

end.
