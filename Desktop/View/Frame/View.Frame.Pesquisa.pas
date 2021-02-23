unit View.Frame.Pesquisa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.ListBox, FMX.Layouts, FMX.Objects;

type
  TFramePesquisa = class(TFrame)
    RectPesquisaProduto: TRectangle;
    LytPesquisaProduto: TLayout;
    CBoxFiltro: TComboBox;
    EdtPesquisa: TEdit;
    BtnPesquisa: TRectangle;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

{ TFramePesquisa }


end.
