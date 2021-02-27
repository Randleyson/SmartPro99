unit Module.DmConfiguracao;

interface

uses
  System.SysUtils, System.Classes, System.IniFiles;

type
  TDmConfiguracao = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    fPathConfigIni: string;
  public
    { Public declarations }
    function GetConfig(pSecao, pValue: String): String;
    procedure SetConfig(pSecao, pParament, pValue: String);
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TDataModule1 }

procedure TDmConfiguracao.DataModuleCreate(Sender: TObject);
begin
  fPathConfigIni := ExtractFilePath(ParamStr(0)) + 'Config.ini';;
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

end.
