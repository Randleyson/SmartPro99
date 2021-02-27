unit Module.DmProduto;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Controller.oProduto;

type
  TDmProduto = class(TDataModule)
    FDQryProduto: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function CarregaProduto(oProduto: ToProduto; sErro: String): Boolean;
    function InsertEtiqueta(pCodOperador: Integer; oProduto: ToProduto;
      sErro: String): Boolean;
  end;

implementation

uses
  Dao.ConexaoOracle, View.FrmPrincipal, Controller.oUtilitario;

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TDataModule1 }

function TDmProduto.CarregaProduto(oProduto: ToProduto;
  sErro: String): Boolean;
var
  ConexaoSQL: TConexaoOracle;
begin

  ConexaoSQL := TConexaoOracle.Create(nil);
  try

    with FDQryProduto do
    begin
      try
        Close;
        Connection := ConexaoSQL.FDConnOracle;

        SQL.Text := ToUltilitaro.SubstituirString
          (SQL.Text, ':CODBARRA', QuotedStr(oProduto.CodBarra));
        SQL.Text := ToUltilitaro.SubstituirString
          (SQL.Text, ':IDEMPRESA', oProduto.IdEmpresa);

        Open;
        oProduto.IdEmpresa := FieldByName('idempresa').AsString;
        oProduto.IdProduto := FieldByName('idproduto').AsString;
        oProduto.CodBarra := FieldByName('codbarra').AsString;
        oProduto.Descricao := FieldByName('descricao').AsString;
        oProduto.Unidade := FieldByName('unidade').AsString;
        oProduto.VrVenda := FieldByName('vrvenda').AsString;
        oProduto.CustoRep := FieldByName('custorep').AsString;
        oProduto.Promocao := FieldByName('promocao').AsString;
        oProduto.VrPromocao := FieldByName('vrpromoca').AsString;
        oProduto.Ativo := FieldByName('ativo').AsString;
        oProduto.Estoque := FieldByName('estoque').AsString;

        Result := True;
      except
        on E: Exception do
        begin
          sErro := E.Message;
          Result := False;
        end;
      end;
    end;

  finally
    FDQryProduto.Close;
    FreeAndNil(ConexaoSQL);
  end;

end;

function TDmProduto.InsertEtiqueta(pCodOperador: Integer;
  oProduto: ToProduto; sErro: String): Boolean;
var
  ConexaoSQL: TConexaoOracle;
  vSQL: String;
begin

  vSQL := 'insert into etiqueta_cons_prod ' +
    '(idetiqueta, idproduto, operador, data_consulta, impressa, idempresa)' +
    ' VALUES (Id_idetiqueta.NEXTVAL, :IDPRODUTO, :CODOPERADOR, SYSDATE,' +
    ' ''N'', :IDEMPRESA)';

  vSQL := ToUltilitaro.SubstituirString(vSQL, ':IDPRODUTO', oProduto.IdProduto);
  vSQL := ToUltilitaro.SubstituirString(vSQL, ':CODOPERADOR', IntToStr(pCodOperador));
  vSQL := ToUltilitaro.SubstituirString(vSQL, ':IDEMPRESA', oProduto.IdEmpresa);

  ConexaoSQL := TConexaoOracle.Create(nil);
  try
    if not ConexaoSQL.ExcecutarSQL(vSQL, sErro) then
      Result := False;

    Result := True;

  finally
    FreeAndNil(ConexaoSQL);

  end;
end;

end.
