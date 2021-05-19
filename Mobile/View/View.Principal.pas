unit View.Principal;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  View.TabelaPreco,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Layouts, FMX.Objects;

type
  TViewPrincipal = class(TForm)
    TmSplash: TTimer;
    Layout1: TLayout;
    Label2: TLabel;
    Label1: TLabel;
    Rectangle1: TRectangle;
    procedure FormShow(Sender: TObject);
    procedure TmSplashTimer(Sender: TObject);
  private
    { Private declarations }
    FFrameTabelaPreco: TViewTabelaPreco;
  public
    { Public declarations }
    procedure FecharAplicacao;
  end;

var
  ViewPrincipal: TViewPrincipal;

implementation

{$R *.fmx}

uses Model.Behaviors;

procedure TViewPrincipal.FecharAplicacao;
begin
  Application.Terminate;
end;

procedure TViewPrincipal.FormShow(Sender: TObject);
begin
  TmSplash.Interval := 2000;
  TmSplash.Enabled := True;
end;

procedure TViewPrincipal.TmSplashTimer(Sender: TObject);
begin
  TmSplash.Enabled := False;
  FFrameTabelaPreco := TViewTabelaPreco.Create(Nil);
  FFrameTabelaPreco.ShowView(Self);
end;

end.
