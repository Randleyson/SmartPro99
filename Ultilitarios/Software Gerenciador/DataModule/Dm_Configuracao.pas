unit Dm_Configuracao;

interface

uses
  System.SysUtils, System.Classes;

type
  TdmConfiguracao = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PostArquivoTxt(pCaminho: string);
  end;

var
  dmConfiguracao: TdmConfiguracao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Dm_Principal, ufrm_Principal;

{$R *.dfm}

{ TDataModule1 }

procedure TdmConfiguracao.PostArquivoTxt(pCaminho: string);
var
  vSQl : string;
begin

  vSql := 'update configuracao set caminhoarquivotxt = ' + QuotedStr(pCaminho)+
          ' where idconfig = 1';

  try

    DmPrincipal.FDC_Freeboard.ExecSQL(vSql);
    DmPrincipal.FDC_Freeboard.Commit;

  except
    FrmPrincipal.fMensagemErro := 'Erro ao insert as configuracao';
    raise
  end;

end;

end.
