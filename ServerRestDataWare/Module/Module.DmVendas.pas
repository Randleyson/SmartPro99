unit Module.DmVendas;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Dao.ConexaoOracle,
  Controller.oVendas;

type
  TDmVendas = class(TDataModule)
    FDQryTicketMedio: TFDQuery;
    FDQryTicketMedioQTDE_CUPONS: TFMTBCDField;
    FDQryTicketMedioTOTAL_VENDA: TFMTBCDField;
    FDQryTicketMedioMEDIA: TFMTBCDField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    ConexaoOracle: TConexaoOracle;
  public
    { Public declarations }
    function ReceberTicketMedio(oVendas: ToVendas; out sErro: string): Boolean;
  end;

implementation

uses
  Controller.oUtilitario;

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

procedure TDmVendas.DataModuleCreate(Sender: TObject);
begin
  ConexaoOracle := TConexaoOracle.Create(nil);
end;

procedure TDmVendas.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(ConexaoOracle);
end;

function TDmVendas.ReceberTicketMedio(oVendas: ToVendas;
  out sErro: string): Boolean;
var
  vSQL: string;
begin

  with FDQryTicketMedio do
  begin

    Connection := ConexaoOracle.FDConnOracle;
    try
      Close;
      SQL.Text := ToUltilitaro.SubstituirString(SQL.Text, ':DATA1',
                    QuotedStr(oVendas.DtInicial));
      SQL.Text := ToUltilitaro.SubstituirString(SQL.Text, ':DATA2',
                    QuotedStr(oVendas.DtFinal));
      SQL.Text := ToUltilitaro.SubstituirString(SQL.Text, ':IDEMPRESA',
                    oVendas.IdEmpresa);

      Open;
      oVendas.QtdeCupom := FieldByName('QTDE_CUPONS').AsInteger;
      oVendas.TotalVenda := FieldByName('TOTAL_VENDA').AsCurrency;
      oVendas.TicketMedio := FieldByName('MEDIA').AsCurrency;
      Result := True;

    except
      on E: Exception do
      begin
        Result := False;
        sErro := E.Message;
      end;
    end;
  end;

end;

end.
