object DaoConexaoDB: TDaoConexaoDB
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 316
  Width = 357
  object FDConn: TFDConnection
    Params.Strings = (
      'Database=D:\Projetos\SmartPro99\trunk\Db\SmartPro99.fdb'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 64
    Top = 32
  end
end
