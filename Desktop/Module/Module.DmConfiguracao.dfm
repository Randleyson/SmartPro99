object DmConfiguracao: TDmConfiguracao
  OldCreateOrder = False
  Height = 459
  Width = 360
  object Qry_GetConfiguracao: TFDQuery
    SQL.Strings = (
      'select padraoarquivo,localarquivo from configuracao')
    Left = 56
    Top = 32
  end
end
