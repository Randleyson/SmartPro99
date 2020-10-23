unit uframe_FTabelaPreco;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects;

type
  TFrameFPreco = class(TFrame)
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    lblDescricaoProd: TLabel;
    lblValorVenda: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrameFPreco:TFrameFPreco;


implementation

{$R *.fmx}

end.
