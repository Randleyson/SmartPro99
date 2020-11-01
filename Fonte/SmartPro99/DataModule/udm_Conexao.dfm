object DmConexao: TDmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 231
  Width = 191
  object FDC_Freeboard: TFDConnection
    Params.Strings = (
      
        'Database=D:\Projetos\SmartPro99\trunk\Fonte\WsSmartPro99\db\dbSm' +
        'artPro99.fdb'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 32
  end
end
