object dmConectSQLlite: TdmConectSQLlite
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 209
  Width = 319
  object FDC_SQLlite: TFDConnection
    Params.Strings = (
      'Database=D:\Projetos\SamartPro99\AppSamartPro99\db\db.db'
      'DriverID=SQLite')
    Left = 80
    Top = 32
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 80
    Top = 112
  end
end
