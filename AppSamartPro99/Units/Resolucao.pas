{ Tabela de resulucao
  1 - CELULAR
  2 - TV 32

A = Altura
Q = Quantidade
L = Largura
T = Tanho fonte

}

unit Resolucao;

interface

uses ufrm_Principal;

type
  TResolucao = class
  public
    class function AlstTabPreco: integer;
    class function QProdutoListado: integer;
    class function LlstTabPreco: integer;
    class function LimgLogo: integer;
    class function TlstTabPreco: integer;
    class function AfrmPrinc: integer;
    class function LfrmPrinc: integer;
    class function MarTopLstTabPreco: integer;

end;

implementation

{ TResolucao }

class function TResolucao.MarTopLstTabPreco: integer;
begin

  case FrmPrincipal.fResolucaoAtual of
    1 : result := 60;
    2 : result := 100;
  end;

end;

class function TResolucao.AlstTabPreco: integer;
begin

  case FrmPrincipal.fResolucaoAtual of
    1 : result := 35;
    2 : result := 50;
  end;

end;

class function TResolucao.QProdutoListado: integer;
begin

  case FrmPrincipal.fResolucaoAtual of
    1 : result := 6;
    2 : result := 10;
  end;

end;

class function TResolucao.LlstTabPreco: integer;
begin

  case FrmPrincipal.fResolucaoAtual of
    1 : result := 380;
    2 : result := 1200;
  end;

end;

class function TResolucao.LimgLogo: integer;
begin

  case FrmPrincipal.fResolucaoAtual of
    1 : result := 120;
    2 : result := 390;
  end;

end;

class function TResolucao.TlstTabPreco: integer;
begin

  case FrmPrincipal.fResolucaoAtual of
    1 : result := 16;
    2 : result := 24;
  end;

end;

class function TResolucao.AfrmPrinc: integer;
begin

    case FrmPrincipal.fResolucaoAtual of
    1 : result := 360;
    2 : result := 700;
  end;

end;

class function TResolucao.LfrmPrinc: integer;
begin

  case FrmPrincipal.fResolucaoAtual of
    1 : result := 600;
    2 : result := 1700;
  end;

end;

end.
