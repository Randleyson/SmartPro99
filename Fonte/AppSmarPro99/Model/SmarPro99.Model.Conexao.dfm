object ModelConexao: TModelConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 209
  Width = 319
  object FDC_SQLlite: TFDConnection
    Params.Strings = (
      
        'Database=D:\Projetos\SmartPro99\trunk\Fonte\AppSmarPro99\db\db.d' +
        'b'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 80
    Top = 32
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 80
    Top = 112
  end
end
