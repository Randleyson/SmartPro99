unit udm_conectSQLlite;

interface

uses
  System.SysUtils, System.Classes,System.IOUtils, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client
  {$IFDEF MSWINDOWS}
  ,vcl.Forms
  {$ENDIF};

type
  TdmConectSQLlite = class(TDataModule)
    FDC_SQLlite: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure ConectarSQLlite;
    { Private declarations }
  public
    { Public declarations }
    procedure AbreConexaoSQLlite;
    procedure FechaSQLlite;
  end;

var
  dmConectSQLlite: TdmConectSQLlite;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses ufrm_Principal;

{$R *.dfm}

procedure TdmConectSQLlite.AbreConexaoSQLlite;
begin

  try

    if FDC_SqlLite.Connected then
    Sleep(15000);
    if FDC_SqlLite.Connected then
    Sleep(15000);
    if FDC_SqlLite.Connected then
    Sleep(15000);
    if not FDC_SqlLite.Connected then
    FDC_SqlLite.Connected := True;

  except
    raise;

  end;


end;

procedure TdmConectSQLlite.DataModuleCreate(Sender: TObject);
begin

  try

    ConectarSQLlite;

  except
    raise
  end;

end;

procedure TdmConectSQLlite.FechaSQLlite;
begin

  try

    FDC_SQLlite.Connected := False;;

  except
    raise;

  end;

end;

procedure TdmConectSQLlite.ConectarSQLlite;
begin

  try

    try
      FechaSQLlite;
      FDC_SQLlite.LoginPrompt                   := False;
      FDC_SQLlite.Params.Clear;
      FDC_SQLlite.Params.Values['DriverID']     := 'SQLite';
      FDC_SQLlite.Params.Values['OpenMode']     := 'ReadWrite';
      FDC_SQLlite.params.Values['LockingMode']  := 'Normal';

      {$IFDEF MSWINDOWS}
      FDC_SQLlite.Params.Values['Database']     := 'D:\Projetos\SmartPro99\trunk\Fonte\AppSmarPro99\db\db.db';
      {$ENDIF}
      {$IFDEF ANDROID}
      FDC_SQLlite.Params.Values['Database']     := TPath.Combine(TPath.GetDocumentsPath, 'db.db');
      {$ENDIF}

      AbreConexaoSQLlite;
      FrmPrincipal.fComErro := False;

    except
      {$IFDEF MSWINDOWS}
      FrmPrincipal.fMensagemErro := 'Não foi possivel conectar a base de dados SQLlite'+
                                  'Verifique o caminho : '+
                                  ExtractFileDir(Application.ExeName)+'\db\db.db';
      {$ENDIF}
      {$IFDEF ANDROID}
      FrmPrincipal.fMensagemErro := 'Não foi possivel conectar a base de dados SQLlite'+
                                  'Verifique o caminho : '+
                                  TPath.Combine(TPath.GetDocumentsPath, 'db.db');
      {$ENDIF}

      FrmPrincipal.fComErro := True;

    end;

  finally
    FechaSQLlite;
  end;

end;


end.
