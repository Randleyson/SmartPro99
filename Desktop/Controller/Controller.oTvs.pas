unit Controller.oTvs;

interface

uses
  FMX.StdCtrls, FMX.ListBox, FireDAC.Comp.Client;

type
  ToTvs = class
  private
    FIdTv: Integer;
    FDescricao: String;
    FCodProd: String;
    FDescricaoProd: String;
    procedure SetFDescricao(const Value: String);
  public
    property IdTv: Integer read FIdTv write FIdTv;
    property Descricao: String read FDescricao write SetFDescricao;
    function GetTagStringListBox(pListBox: TlistBox): String;

    procedure MoverProduto(pFMenTableOrigem, pFMenTableDestino: TFDMemTable;
      pCodBara: String = '');
  end;

implementation

uses
  System.SysUtils;

{ ToTvs }

procedure ToTvs.SetFDescricao(const Value: String);
begin
  FDescricao := UpperCase(Value);
end;

{ ToTvs }

function ToTvs.GetTagStringListBox(pListBox: TlistBox): String;
begin
  if pListBox.Count > 0 then
    Result := pListBox.ListItems[pListBox.ItemIndex].TagString
  else
  Result := '0'
end;

procedure ToTvs.MoverProduto(pFMenTableOrigem, pFMenTableDestino: TFDMemTable;
  pCodBara: String = '');
var
  vI: Integer;
begin

  try
    if pCodBara = '' then
    begin
      pFMenTableOrigem.Filtered := False;
    end
    else
    begin
      pFMenTableOrigem.Filter := 'CodBarra = ' + pCodBara;
      pFMenTableOrigem.Filtered := True;
    end;

    pFMenTableOrigem.First;
    for vI := 0 to pFMenTableOrigem.RecordCount - 1 do
    begin
      pFMenTableDestino.Insert;
      pFMenTableDestino.Fields[0].Value := pFMenTableOrigem.Fields[0].AsString;
      pFMenTableDestino.Fields[1].Value := pFMenTableOrigem.Fields[1].AsString;
      pFMenTableDestino.Post;
      pFMenTableOrigem.Delete;
      pFMenTableOrigem.Next;
    end;

    pFMenTableOrigem.Filtered := False;
  except
    Raise;

  end;

end;

end.
