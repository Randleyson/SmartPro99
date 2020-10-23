unit uframe_FListarProduto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation;

type
  TFrameFListarProduto = class(TFrame)
    lblCodBarra: TLabel;
    lblVrvenda: TLabel;
    lblDescricao: TLabel;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.fmx}

end.
