unit Module.DmFinanceiro;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Comp.Client,
  Dao.ConexaoOracle, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  Controller.oFinanceiro;

type
  TDmFinanceiro= class(TDataModule)
    FQryDocFinanceiro: TFDQuery;
    FQryDocFinanceiroVALOR: TFMTBCDField;
    FQryDocFinanceiroPARCEIRO: TStringField;
    FQryDocFinanceiroDTVENCIMENTO: TDateTimeField;
    FQryDocFinanceiroDOCUMENTO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    ConexaoOracle: TConexaoOracle;
    function AbrerQueryDocFinanceiro(oFinanceiro: ToFinanceiro): Boolean;
    function SomaDosDocumentos(pTipoDocumento: String): Currency;

  public
    { Public declarations }
    function CarregaSaldoEmpresa(oFinanceiro: ToFinanceiro;
      out sErro: String): Boolean;
    function QueryListaDeDocumento(oFiananceiro: ToFinanceiro;
      out sErro: String): TFDQuery;
  end;

implementation

uses
  Controller.oUtilitario;

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TDataModule1 }

function TDmFinanceiro.AbrerQueryDocFinanceiro
  (oFinanceiro: ToFinanceiro): Boolean;

begin

  try
    with FQryDocFinanceiro do
    begin
      Connection := ConexaoOracle.FDConnOracle;
      try
        Close;
        SQL.Text := ToUltilitaro.SubstituirString(SQL.Text, ':DATA1',
          QuotedStr(oFinanceiro.DtInicial));
        SQL.Text := ToUltilitaro.SubstituirString(SQL.Text, ':DATA2',
          QuotedStr(oFinanceiro.DtFinal));
        SQL.Text := ToUltilitaro.SubstituirString(SQL.Text, ':IDEMPRESA',
          oFinanceiro.IdEmpresa);
        Open;
      except
        Result := False;
      end;

    end;

  finally
    Result := FQryDocFinanceiro.Active;
  end;

end;

function TDmFinanceiro.QueryListaDeDocumento(oFiananceiro: ToFinanceiro;
  out sErro: String): TFDQuery;
begin

  if AbrerQueryDocFinanceiro(oFiananceiro) then
  begin

    with FQryDocFinanceiro do
    begin
      Filtered := False;
      Filter := 'documento = ' + QuotedStr(oFiananceiro.TipoDocumentoString);
      Filtered := True;

      Result := FQryDocFinanceiro;
    end;
  end;

end;

function TDmFinanceiro.CarregaSaldoEmpresa(oFinanceiro: ToFinanceiro;
  out sErro: String): Boolean;
begin

  try
    try
      if not AbrerQueryDocFinanceiro(oFinanceiro) then
        Result := False;

      oFinanceiro.TotalAreceber := SomaDosDocumentos('ARECEBER');
      oFinanceiro.TotalCartao := SomaDosDocumentos('CARTAO');
      oFinanceiro.TotalChequePre := SomaDosDocumentos('CHEQUEPRE');
      oFinanceiro.TotalApagar := SomaDosDocumentos('APAGAR');
      oFinanceiro.TotalChequeProp := SomaDosDocumentos('CHEQUEPROP');

    except
      on E: Exception do
      begin
        Result := False;
        sErro := E.Message;
        FQryDocFinanceiro.Close;
      end;

    end;

  finally
    FQryDocFinanceiro.Close;

  end;

end;

procedure TDmFinanceiro.DataModuleCreate(Sender: TObject);
begin
  ConexaoOracle := TConexaoOracle.Create(nil);
end;

procedure TDmFinanceiro.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(ConexaoOracle);
end;

function TDmFinanceiro.SomaDosDocumentos(pTipoDocumento: String): Currency;
begin

  with FQryDocFinanceiro do
  begin

    if not Active then
      raise Exception.Create('Query Financeiro nao esta aberta');

    Filtered := False;
    Filter := 'Documento = ' + QuotedStr(pTipoDocumento);
    Filtered := True;

    Result := 0;
    First;
    while not EoF do
    begin
      Result := Result + FieldByName('Valor').AsFloat;
      Next;
    end;

  end;

end;

end.
