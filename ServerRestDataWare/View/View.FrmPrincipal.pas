unit View.FrmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, uDWAbout, uRESTDWBase,
  FMX.Objects, FMX.Layouts, FMX.ScrollBox, FMX.Memo,
  FMX.Edit, FMX.Forms, Controller.oConfiguracao, FMX.TabControl, FMX.ListBox,
  StrUtils;

type
  TFrmPrincipal = class(TForm)
    RESTPooler: TRESTServicePooler;
    TabControl: TTabControl;
    TabConfiguracao: TTabItem;
    TabLos: TTabItem;
    RectPrincipal: TRectangle;
    Line1: TLine;
    LytConfiguracaoServidor: TLayout;
    LblConfiguracaoServer: TLabel;
    Line2: TLine;
    Layout8: TLayout;
    Layout9: TLayout;
    Label17: TLabel;
    EdtPortaServer: TEdit;
    Layout10: TLayout;
    Label18: TLabel;
    EdtUsuarioServer: TEdit;
    Layout11: TLayout;
    Label19: TLabel;
    EdtSenhaServer: TEdit;
    LytConfgDB1: TLayout;
    Label5: TLabel;
    Layout13: TLayout;
    Layout14: TLayout;
    Label20: TLabel;
    EdtIpDB: TEdit;
    Layout15: TLayout;
    Label21: TLabel;
    EdtSenhaDB: TEdit;
    Layout16: TLayout;
    Label22: TLabel;
    EdtUsuarioDB: TEdit;
    Layout17: TLayout;
    Label23: TLabel;
    EdtPortaDB: TEdit;
    LytConfigDB2: TLayout;
    Layout19: TLayout;
    Label24: TLabel;
    EdtPastaDB: TEdit;
    Layout20: TLayout;
    Label25: TLabel;
    EdtBancoDB: TEdit;
    LytBotao: TLayout;
    BtnStart: TRectangle;
    BtnStop: TRectangle;
    LblRodaPe: TLabel;
    Image2: TImage;
    LytConfiguracaoDB: TLayout;
    LytImagem: TLayout;
    LytClient: TLayout;
    LytConfig1: TLayout;
    Label7: TLabel;
    Label8: TLabel;
    MmLogs: TMemo;
    CliStatus: TCircle;
    LblOnOff: TLabel;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Label1: TLabel;
    CboxDriverBD: TComboBox;
    TmSincronizaProduto: TTimer;
    PBarSincronizara: TProgressBar;
    Layout4: TLayout;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnStartClick(Sender: TObject);
    procedure BtnStopClick(Sender: TObject);
    procedure TmSincronizaProdutoTimer(Sender: TObject);
  private
    { Private declarations }
    procedure ReloadFrmPrincipal;
    procedure StartServer;
    procedure StopServer;
    procedure SalvarConfiguracaoNoIni;
    procedure StatusServer(Values: Boolean);
    procedure SincronizarProdutos;
  public
  { Public declarations }
    const
    cVersao: String = '1.0.0';
    procedure EscreveMmLogs(pErro: String);
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  Module.ServerMethod,
  Controller.uConfiguracao,
  Controller.uConexaoSQL,
  Controller.oSincronizacao;

{$R *.fmx}

procedure TFrmPrincipal.ReloadFrmPrincipal;
begin

  try
    oConfiguracao.CarregaConfigIni;

    // Listar config nos edits
    EdtPortaServer.Text := oConfiguracao.PortaServer;
    EdtUsuarioServer.Text := oConfiguracao.UsuarioServer;
    EdtSenhaServer.Text := oConfiguracao.SenhaServer;

    EdtIpDB.Text := oConfiguracao.IpDB;
    EdtPortaDB.Text := oConfiguracao.PortaDB;
    EdtBancoDB.Text := oConfiguracao.BancoDB;
    EdtPastaDB.Text := oConfiguracao.PastaDB;
    EdtUsuarioDB.Text := oConfiguracao.UsuarioDB;
    EdtSenhaDB.Text := oConfiguracao.SenhaDB;

    CboxDriverBD.Items.Clear;
    CboxDriverBD.Items.Add('Oracle');
    CboxDriverBD.Items.Add('Freeboard');

    CboxDriverBD.ItemIndex := AnsiIndexStr(UpperCase(oConfiguracao.DriverDB),
      ['ORA', 'FB']);

    BtnStart.Enabled := True;
    BtnStop.Enabled := False;

    LblRodaPe.Text :=
      '© 2021 Consolide Registro de Marcas - Todos os direitos reservados.' +
      'Versão: ' + cVersao;

    PBarSincronizara.Visible := False;

  except
    raise;
  end;

end;

procedure TFrmPrincipal.SalvarConfiguracaoNoIni;
var
  vDriver: array of string;
begin
  try
    vDriver := ['ORA', 'FB'];
    oConfiguracao.DriverDB := vDriver[CboxDriverBD.Index];
    oConfiguracao.IpDB := EdtIpDB.Text;
    oConfiguracao.PortaDB := EdtPortaDB.Text;
    oConfiguracao.BancoDB := EdtBancoDB.Text;
    oConfiguracao.PastaDB := EdtPastaDB.Text;
    oConfiguracao.UsuarioDB := EdtUsuarioDB.Text;
    oConfiguracao.SenhaDB := EdtSenhaDB.Text;

    oConfiguracao.UsuarioServer := EdtUsuarioServer.Text;
    oConfiguracao.SenhaServer := EdtSenhaServer.Text;
    oConfiguracao.PortaServer := EdtPortaServer.Text;

    oConfiguracao.SalvarConfigIni;
    EscreveMmLogs('Alteracao gravada com exito');
  except
    raise Exception.Create
      ('Erro ao gravar o configuracao no arquivo config.ini');
  end;

end;

procedure TFrmPrincipal.SincronizarProdutos;
begin

  if not FileExists(oConfiguracao.PathAquivoIntegracao) then
  begin
    EscreveMmLogs('o Arquivo de integacao nao exite');
    exit;
  end;

  oSincronizacao := ToSincronizacao.Create;
  try

    PBarSincronizara.Max := oSincronizacao.QuantidadeLinha;
    PBarSincronizara.Value := 1;
    PBarSincronizara.Visible := True;

    EscreveMmLogs('Sincronizacao Inicia');
    TThread.CreateAnonymousThread(
      procedure
      begin
        try
          try
            oSincronizacao.SincronizarProdutos;

          except
            raise
          end;

        finally

          TThread.Synchronize(nil,
            procedure
            begin
              EscreveMmLogs('Sincronizacao finalizada');
              FreeAndNil(oSincronizacao);
              PBarSincronizara.Visible := False;
            end);
        end;

      end).Start;

  except
    on E: Exception do EscreveMmLogs('Erro ao sincronizar produtos :' + E.Message);
  end;

end;

procedure TFrmPrincipal.StartServer;
begin

  try
    try
      SalvarConfiguracaoNoIni;

      RESTPooler.ServerMethodClass := TDmServerMethod;
      RESTPooler.ServicePort := StrToint(oConfiguracao.PortaServer);
      RESTPooler.Active := True;
      EscreveMmLogs('Server Iniciado');
      TmSincronizaProduto.Interval := 15000;
      TmSincronizaProduto.Enabled := True;

    except
      raise;
    end;

  finally
    FrmPrincipal.BtnStart.Enabled := not RESTPooler.Active;
    FrmPrincipal.BtnStop.Enabled := RESTPooler.Active;
    StatusServer(RESTPooler.Active);
  end;

end;

procedure TFrmPrincipal.StatusServer(Values: Boolean);
begin

  if Values then
  begin
    LblOnOff.Text := 'ON';
    CliStatus.Fill.Color := TAlphaColor($FF0EE515);
  end
  else
  begin
    LblOnOff.Text := 'OFF';
    CliStatus.Fill.Color := TAlphaColor($FFE50E0E);

  end;

end;

procedure TFrmPrincipal.StopServer;
begin

  RESTPooler.Active := False;
  FrmPrincipal.BtnStart.Enabled := True;
  FrmPrincipal.BtnStop.Enabled := False;
  FreeAndNil(DmServerMethod);
  StatusServer(False);
  TmSincronizaProduto.Enabled := False;

  MmLogs.Lines.Add('Serviço parado ...');

end;

procedure TFrmPrincipal.TmSincronizaProdutoTimer(Sender: TObject);
begin
  SincronizarProdutos;
end;

procedure TFrmPrincipal.BtnStartClick(Sender: TObject);
begin

  try
    StartServer;

  except
    on E: Exception do
    begin
      EscreveMmLogs('Erro :' + E.Message);
      StopServer;
    end;
  end;

end;

procedure TFrmPrincipal.BtnStopClick(Sender: TObject);
begin
  StopServer;

end;

procedure TFrmPrincipal.EscreveMmLogs(pErro: String);
begin
  MmLogs.Lines.Add(pErro);
end;

procedure TFrmPrincipal.FormDestroy(Sender: TObject);
begin
  StopServer;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
var
  sErro: string;
begin

  oConfiguracao := ToConfiguracao.Create;
  try
    ReloadFrmPrincipal;
    StartServer;
  except
    on E: Exception do
    begin
      EscreveMmLogs('Erro ao iniciar o serviço ' + E.Message);
      ShowMessage('Erro ao iniciar o serviço ' + E.Message);
    end;
  end;

end;

end.
