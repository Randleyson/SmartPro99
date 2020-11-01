unit uframe_Oferta;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation;

type
  TFrameOferta = class(TFrame)
    Image1: TImage;
    lblNomeProduto: TLabel;
    Image2: TImage;
    Layout1: TLayout;
    Image3: TImage;
    Layout2: TLayout;
    lblVrvendaReal: TLabel;
    lblUnidade: TLabel;
    Layout3: TLayout;
    lblVrvendaCentavos: TLabel;
    Rectangle1: TRectangle;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
