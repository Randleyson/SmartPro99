object DmTvs: TDmTvs
  OldCreateOrder = False
  Height = 316
  Width = 642
  object QryListaTvs: TFDQuery
    Connection = DaoConexaoDB.FDConn
    SQL.Strings = (
      'select * from tvs')
    Left = 48
    Top = 24
  end
  object QryProdutosTv: TFDQuery
    Left = 128
    Top = 24
  end
end
