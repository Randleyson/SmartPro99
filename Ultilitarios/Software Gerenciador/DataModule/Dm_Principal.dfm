object DmPrincipal: TDmPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 351
  Width = 369
  object FDC_Freeboard: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      
        'Database=D:\Projetos\Gest'#227'o PV - Propaganda Visual\Software Gere' +
        'nciador\db\DB.FDB'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 24
  end
end
