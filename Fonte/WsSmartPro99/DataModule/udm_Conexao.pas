unit udm_Conexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client;

type
  TdmConexao = class(TDataModule)
    FDC_Freeboard: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    fConexaoFreeboard : Boolean;
    procedure ConectaFreeboard;
    procedure AbreConexaoDB;
    procedure FechaConexaoDB;
  end;

var
  dmConexao: TdmConexao;

implementation

uses
  Vcl.Forms, ufrm_Principal;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmConexao.ConectaFreeboard;
begin

  try

    FDC_Freeboard.Connected                   := False;
    FDC_Freeboard.LoginPrompt                 := False;
    FDC_Freeboard.Params.Clear;
    FDC_Freeboard.Params.Values['DriverID']   := 'FB';
    FDC_Freeboard.Params.Values['User_Name']  := 'sysdba';
    FDC_Freeboard.Params.Values['Password']   := 'masterkey';
    FDC_Freeboard.Params.Values['Database']   := ExtractFileDir(Application.ExeName)+'\..\DbPro99\DB.FDB';
    FDC_Freeboard.Connected                   := True;
    FDC_Freeboard.Connected                   := False;
    fConexaoFreeboard                         := True;

    except
      FrmPrincipal.fMensagemErro := 'Erro ao conectar ao base de dados freeboard.'+
                                    ' verifique o caminho do banco existe : '+
                                    ExtractFileDir(Application.ExeName)+'\..\DbPro99\DB.FDB';
      fConexaoFreeboard := False;
  end;

end;

procedure TdmConexao.DataModuleCreate(Sender: TObject);
begin

  try

    ConectaFreeboard

  except
    raise;

  end;

end;

procedure TdmConexao.AbreConexaoDB;
begin

  FDC_Freeboard.Connected := True;

end;

procedure TdmConexao.FechaConexaoDB;
begin

  FDC_Freeboard.Connected := False;

end;

end.
