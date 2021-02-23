unit Module.DmProdutos;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDmProdutos = class(TDataModule)
    QryProdutos: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function CarregaProdutoDb(pFDMemTable: TFDMemTable): Boolean;
  end;

implementation

uses
  Doa.DmConexaoSQL;

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TDmProdutos }

function TDmProdutos.CarregaProdutoDb(pFDMemTable: TFDMemTable): Boolean;
var
  DmConexao: TDmConexaoSQL;
begin

  DmConexao := TDmConexaoSQL.Create(Nil);
  try
    with QryProdutos do
    begin
      try
        Close;
        Connection := DmConexao.ConnectionSQL;
        Open;
        TFDMemTable(pFDMemTable).CopyDataSet(QryProdutos);

      except
        raise

      end;

    end;
  finally
    QryProdutos.Close;
    FreeAndNil(DmConexao);

  end;

end;

end.
