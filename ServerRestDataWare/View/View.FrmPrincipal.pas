unit View.FrmPrincipal;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  uDWAbout,
  uRESTDWBase,
  FMX.Objects,
  FMX.Layouts,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.Edit,
  FMX.Forms,
  FMX.TabControl,
  FMX.ListBox,
  StrUtils;

type
  TFrmPrincipal = class(TForm)
    RESTPooler: TRESTServicePooler;
    TabControl: TTabControl;
    TabConfiguracao: TTabItem;
    TabLos: TTabItem;
    RectPrincipal: TRectangle;
    LytBotao: TLayout;
    BtnStart: TRectangle;
    BtnStop: TRectangle;
    LblRodaPe: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    MmLogs: TMemo;
    CliStatus: TCircle;
    LblOnOff: TLabel;
    TmSincronizaProduto: TTimer;
    PBarSincronizara: TProgressBar;
    Layout4: TLayout;
    procedure FormDestroy(Sender: TObject);
    procedure BtnStartClick(Sender: TObject);
    procedure BtnStopClick(Sender: TObject);
    procedure TmSincronizaProdutoTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FPathAquivoTxt: String;
    procedure StartServer;
    procedure StopServer;
    procedure StatusServer(Values: Boolean);
    procedure SincronizarProdutos;
  public
  { Public declarations }
    const
    cVersao: String = '2.0.0';
    procedure EscreveMmLogs(pErro: String);
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  System.IniFiles,
  uDm, uServerMethod;

{$R *.fmx}

procedure TFrmPrincipal.SincronizarProdutos;
begin
  PBarSincronizara.Visible := True;
  EscreveMmLogs('Sincronizacao Inicia');
  TThread.CreateAnonymousThread(
  procedure
      begin
        try
          try
            Dm.SincronizarProdutos(PBarSincronizara,FPathAquivoTxt);
          except
            raise
          end;

        finally

          TThread.Synchronize(nil,
            procedure
            begin
              EscreveMmLogs('Sincronizacao finalizada');
              PBarSincronizara.Visible := False;;
            end);
        end;
      end).Start;
end;

procedure TFrmPrincipal.StartServer;
begin
  RESTPooler.Active := True;
  TmSincronizaProduto.Interval  := 15000;
  TmSincronizaProduto.Enabled   := True;
  FrmPrincipal.BtnStart.Enabled := not RESTPooler.Active;
  FrmPrincipal.BtnStop.Enabled  := RESTPooler.Active;
  StatusServer(RESTPooler.Active);
  EscreveMmLogs('Server Iniciado');
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
  StartServer;
end;

procedure TFrmPrincipal.BtnStopClick(Sender: TObject);
begin
  StopServer;
end;

procedure TFrmPrincipal.EscreveMmLogs(pErro: String);
begin
  MmLogs.Lines.Add(pErro);
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
var
  FArquivoINI: TIniFile;
begin
  RESTPooler.ServerMethodClass := TDmServerMethod;
  PBarSincronizara.Visible  := False;
  LblRodaPe.Text            := '© 2021 Consolide Registro de Marcas - Todos os direitos reservados.' +
                               'Versão: ' + cVersao;
  FArquivoINI := TIniFile.Create(System.SysUtils.GetCurrentDir + '\Config.ini');
  try
    FPathAquivoTxt := FArquivoINI.ReadString('Integracao', 'Path', '');
  finally
    FArquivoINI.Free;
  end;
  StartServer;
end;

procedure TFrmPrincipal.FormDestroy(Sender: TObject);
begin
  StopServer;
end;

end.
