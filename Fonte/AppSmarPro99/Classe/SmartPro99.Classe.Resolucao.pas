{

Largura do form                 : LARGFRMPRINC
Altura do form                  : ALTFRMPRINC

Quanitde de produtos na Grid    : QTDEPRODGRID
Tananho da fonte da Grid 	      : SIZERFONTEGRID
Largura da Grid 			          : LARGGRIDPRECO
Marege da Grid 				          : MARGTOPGRIDPRECO

Largura do layout oferta		    : LARGLYTOFERTA
Marge do top layout oferta		  : MARGTOPLYTOFERTA
Altura do layout imagem oferta 	: ALTLYIMGTOFERTA
Altura da imagem oferta			    : ALTIMGOFERTA
Largura da imagem oferta		    : LARGIMGOFERTA

}

unit SmartPro99.Classe.Resolucao;

interface

type
  TResolucao = class
  public
  class var
  {GERAL}
  fLargFrmPrinc,
  fAlturaFrmPrinc : integer;

  {GRID PRECO}
  fQtdeProdGrid,
  fSizeFonteGrid,
  fLargGrid,
  fMarTopGrid: integer;

  {LAYOUT OFERTA}
  fLargLytOferta,
  fMargTopLytOferta,
  fAlturaLytImgOferta,
  fAlturaImgOferta,
  fLargImgOferta : integer;

end;

implementation

{ TResolucao }

{ TResolucao }


end.
