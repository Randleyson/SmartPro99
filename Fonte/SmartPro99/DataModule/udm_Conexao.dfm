object DmConexao: TDmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 231
  Width = 191
  object FDC_Freeboard: TFDConnection
    Params.Strings = (
      'Database=D:\Projetos\SamartPro99\DbPro99\DB.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 64
    Top = 32
  end
end
