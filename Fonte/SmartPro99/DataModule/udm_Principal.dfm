object DmPrincipal: TDmPrincipal
  OldCreateOrder = False
  Height = 320
  Width = 430
  object FQryConfig: TFDQuery
    Connection = DmConexao.FDC_Freeboard
    SQL.Strings = (
      'select * from configuracao')
    Left = 40
    Top = 24
  end
end
