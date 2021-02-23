object DmUsuario: TDmUsuario
  OldCreateOrder = False
  Height = 232
  Width = 308
  object Qry_Usuario: TFDQuery
    SQL.Strings = (
      'select idUsuario,Login,senha,nome from Usuario')
    Left = 48
    Top = 32
  end
end
