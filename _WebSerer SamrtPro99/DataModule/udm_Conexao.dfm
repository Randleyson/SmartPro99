object dmConexao: TdmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 190
  Width = 315
  object FDC_Freeboard: TFDConnection
    Params.Strings = (
      'Database=D:\Projetos\SamartPro99\DbSamartPro99\DB.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 48
    Top = 32
  end
end
