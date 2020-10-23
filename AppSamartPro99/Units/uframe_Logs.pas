unit uframe_Logs;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.Objects, FMX.Effects,
  FMX.Filter.Effects;

type
  TFrameLogs = class(TFrame)
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Logs: TLabel;
    MemoLogs: TMemo;
    SpeedButton1: TSpeedButton;
    FillRGBEffect1: TFillRGBEffect;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CreateFrameLogs;
    procedure VisualizaLogs;
    procedure FechaLogs;
    procedure AddLogs(pLogs: String);
  end;
var
  FrameLogs: TFrameLogs;

implementation

{$R *.fmx}

uses uframe_MensagemInfor;

{ TFrameLogs }

procedure TFrameLogs.AddLogs(pLogs: String);
begin

  MemoLogs.Lines.Add(pLogs);

end;

procedure TFrameLogs.CreateFrameLogs;
begin

  try

    if not assigned(FrameLogs) then
    FrameLogs := TFrameLogs.Create(self);

    with FrameLogs do
    begin

      Name      := 'FrameLogs';
      Parent    := FrameLogs;

      BringToFront;

    end;

  except
    FrameMsgInfor.CreateFrameMsgInfor('Erro ao inicar o frame de logs');

  end;


end;

procedure TFrameLogs.FechaLogs;
begin

  FrameLogs.Visible := False;

end;

procedure TFrameLogs.SpeedButton1Click(Sender: TObject);
begin

  try

    FechaLogs;

  except

  end;

end;

procedure TFrameLogs.VisualizaLogs;
begin

  FrameLogs.Visible := True;
  BringToFront;

end;

end.
