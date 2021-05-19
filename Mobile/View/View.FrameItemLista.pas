unit View.FrameItemLista;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects;

type
  TFrame1 = class(TFrame)
    Rectangle1: TRectangle;
    Image1: TImage;
    LblDescricao: TLabel;
    LblUnd: TLabel;
    LblValor: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
