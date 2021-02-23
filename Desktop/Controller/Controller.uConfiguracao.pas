unit Controller.uConfiguracao;

interface

uses
  Controller.oConfiguracao;

type
  TuConfiguracao = class
  private
  public
    function CarregaConfiguracaoDB(oConfiguracao: ToConfiguracao): Boolean;
    function GravaAlteracaoDb(oConfiguracao: ToConfiguracao): Boolean;
    function OpenDialogDir: String;
    class function New : TuConfiguracao;
  end;

implementation

uses
  System.SysUtils, FMX.Dialogs, Vcl.Dialogs, Controller.uFarctory;

{ TuConfiguracao }

function TuConfiguracao.CarregaConfiguracaoDB(oConfiguracao
  : ToConfiguracao): Boolean;
begin

  try
    Result := uFarctory.ConfiguracaoDm.CarregaConfiguracaoDB(oConfiguracao);

  finally
    uFarctory.ConfiguracaoDestroyDm;

  end;

end;

function TuConfiguracao.GravaAlteracaoDb(oConfiguracao: ToConfiguracao)
  : Boolean;
begin

  try
    Result := uFarctory.ConfiguracaoDm.GravaAlteracaoDb(oConfiguracao);

  finally
    uFarctory.ConfiguracaoDestroyDm;

  end;

end;

class function TuConfiguracao.New: TuConfiguracao;
begin
  Result := TuConfiguracao.Create;

end;

function TuConfiguracao.OpenDialogDir: String;
begin

  with TOpenDialog.Create(nil) do
    try

      InitialDir := 'C:';
      Options := [ofFileMustExist];
      Filter := '*.txt';
      if Execute then
        Result := FileName;
    finally
      Free;
    end;

end;

end.
