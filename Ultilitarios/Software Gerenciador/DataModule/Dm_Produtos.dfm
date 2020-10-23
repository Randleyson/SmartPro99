object dmProduto: TdmProduto
  OldCreateOrder = False
  Height = 152
  Width = 363
  object FDQProdutos: TFDQuery
    Connection = DmPrincipal.FDC_Freeboard
    SQL.Strings = (
      'select * from produtos')
    Left = 32
    Top = 16
  end
end
