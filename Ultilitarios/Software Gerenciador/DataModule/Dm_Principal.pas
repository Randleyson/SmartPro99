unit Dm_Principal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef,System.IOUtils;

type
  TDmPrincipal = class(TDataModule)
    FDC_Freeboard: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    function ConectaBdFreeboard: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmPrincipal: TDmPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses ufrm_Principal, Vcl.Forms;

{$R *.dfm}

function TDmPrincipal.ConectaBdFreeboard: Boolean;
begin

  with FDC_Freeboard do
  begin
    try
      Connected                     := False;
      LoginPrompt                   := False;
      Params.Clear;
      Params.Values['DriverID']   := 'FB';
      Params.Values['User_Name']  := 'sysdba';
      Params.Values['Password']   := 'masterkey';
      Params.Values['Database']   := ExtractFileDir(Application.ExeName)+'\..\dbLocal\DB.FDB';
      Connected := true;
      Connected := False;
    except
      FrmPrincipal.fMensagemErro:= 'Erro ao conectar ao banco local (freeboard)';
      raise
    end;
  end;

end;

procedure TDmPrincipal.DataModuleCreate(Sender: TObject);
begin
  ConectaBdFreeboard;
end;

end.
