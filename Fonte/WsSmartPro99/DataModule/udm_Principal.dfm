object dmPrincipal: TdmPrincipal
  OldCreateOrder = False
  Height = 284
  Width = 295
  object FQryConfiguracao: TFDQuery
    Connection = dmConexao.FDC_Freeboard
    SQL.Strings = (
      'select TIPOARQUIVOTXT,'
      '       LOCALARQUIVOTXT '
      'from configuracao')
    Left = 48
    Top = 88
  end
  object FQryTemp: TFDQuery
    Connection = dmConexao.FDC_Freeboard
    Left = 48
    Top = 24
  end
  object FQryProduto: TFDQuery
    Connection = dmConexao.FDC_Freeboard
    SQL.Strings = (
      'select * from produtos')
    Left = 48
    Top = 160
  end
end
