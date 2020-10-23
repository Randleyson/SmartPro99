unit udm_Principal;

interface

uses
  System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Winapi.Windows, System.SysUtils,Vcl.Forms;

type
  TdmPrincipal = class(TDataModule)
    FQryConfiguracao: TFDQuery;
    FQryTemp: TFDQuery;
    FQryProduto: TFDQuery;
  private
    { Private declarations }
    procedure ExecutaSQL(pSQL: string);

  public
    { Public declarations }
    procedure ParamentroConfiguracao;
    procedure InserieProduto(pCodBarra,pDescricao,pVrvenda: string);
    procedure UpdateProduto(pCodbarra,pDescricao,pVrVenda: String);

    procedure MarcaProdExisteNoArqNao;
    procedure DeletaProdNaoNoArq;

  end;

var
  dmPrincipal: TdmPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses ufrm_Principal, udm_Conexao;

{$R *.dfm}

{ TdmPrincipal }

{ TdmPrincipal }

procedure TdmPrincipal.DeletaProdNaoNoArq;
var
  vSQL: string;
begin

  vSQL := 'delete from produtos where existenoarq = ''N''';

  try
    ExecutaSQL(vSQL);
  except
    frmPrincipal.fMensagemErro := 'Erro ao DeletaProdNaoNoArq';
    raise
  end;

end;

procedure TdmPrincipal.MarcaProdExisteNoArqNao;
var
  vSQL: string;
begin

  vSQL := 'update produtos set existenoarq = ''N''';

  try
    ExecutaSQL(vSQL);
  except
    frmPrincipal.fMensagemErro := 'Erro ao DesmarcaExisteNoArq';
    raise
  end;

end;

procedure TdmPrincipal.ExecutaSQL(pSQL: string);
begin

  try

    dmConexao.FDC_Freeboard.ExecSQL(pSQL);
    dmConexao.FDC_Freeboard.Commit;

  except
    raise

  end;

end;



procedure TdmPrincipal.InserieProduto(pCodBarra, pDescricao, pVrvenda: string);
var
  vSQL: String;
begin

   vSQL := 'Insert into produtos (CODBARRA,DESCRICAO,VRVENDA,EXISTENOARQ)'+
            ' values(:Codbarra,:Descricao,:Vrvenda,''S'')';

  try

    try
      dmConexao.AbreConexaoDB;
      with FQryTemp do
      begin
        Active   := False;
        SQL.Text := '';
        SQL.Text := vSQl;

        ParamByName('Codbarra').Value  := pCodBarra;
        ParamByName('Descricao').Value := pDescricao;
        ParamByName('Vrvenda').Value   := pVrvenda;

        ExecSQL;
      end;

    except
      frmPrincipal.fMensagemErro := 'Não foi possivel inserir produto';
      raise

    end;

  finally
    FQryTemp.Active := False;
    dmConexao.FechaConexaoDB;

  end;

end;

procedure TdmPrincipal.ParamentroConfiguracao;
begin

  try

    try

      dmConexao.AbreConexaoDB;

      with FQryConfiguracao do
      begin

        Close;
        Open;

        frmPrincipal.fTipoArquivo    := FieldByName('TIPOARQUIVOTXT').AsString;
        frmPrincipal.fCaminhoArquivo := FieldByName('LOCALARQUIVOTXT').AsString;

        Close;
      end;

    except
      frmPrincipal.fMensagemErro := 'Não foi possivel carrega os paramentro de configuração';
      raise

    end;

  finally
    dmConexao.FechaConexaoDB;

  end;
end;

procedure TdmPrincipal.UpdateProduto(pCodbarra, pDescricao, pVrVenda: String);
var
  vSQL: String;
begin

   vSQL := 'Update produtos set Descricao = :Descricao,'+
                              ' Vrvenda = :Vrvenda,'+
                              ' existenoarq = ''S'''+
           ' where Codbarra = :Codbarra';

  try

    try
      dmConexao.AbreConexaoDB;

      with FQryTemp do
      begin
        Close;
        SQL.Text := '';
        SQL.Text := vSQl;

        ParamByName('Descricao').Value  := pDescricao;
        ParamByName('Vrvenda').Value    := pVrVenda;
        ParamByName('Codbarra').Value   := pCodbarra;

        ExecSQL;
      end;

    except
      frmPrincipal.fMensagemErro := 'Não foi possivel Atualizar o produto produto'+ pCodBarra;
      raise

    end;

  finally
    FQryTemp.Close;
    dmConexao.FechaConexaoDB;

  end;

end;

end.
