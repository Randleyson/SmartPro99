object DmPrincipal: TDmPrincipal
  OldCreateOrder = False
  Height = 367
  Width = 579
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 296
    Top = 24
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 304
    Top = 96
  end
  object FQryTv: TFDQuery
    Connection = dmConectSQLlite.FDC_SQLlite
    SQL.Strings = (
      'select * from tab_tv')
    Left = 40
    Top = 240
  end
  object FQryTabConfig: TFDQuery
    Connection = dmConectSQLlite.FDC_SQLlite
    SQL.Strings = (
      'select *'
      'from tab_config')
    Left = 40
    Top = 32
    object FQryTabConfigIDTV: TIntegerField
      FieldName = 'IDTV'
      Origin = 'IDTV'
    end
    object FQryTabConfigHOSTWS: TStringField
      FieldName = 'HOSTWS'
      Origin = 'HOSTWS'
      Size = 100
    end
    object FQryTabConfigPORTAWS: TIntegerField
      FieldName = 'PORTAWS'
      Origin = 'PORTAWS'
    end
    object FQryTabConfigIDRESOLUCAO: TIntegerField
      FieldName = 'IDRESOLUCAO'
      Origin = 'IDRESOLUCAO'
    end
  end
  object FQryProdutos: TFDQuery
    Connection = dmConectSQLlite.FDC_SQLlite
    SQL.Strings = (
      'select * from tab_produtos'
      'order by codbarra')
    Left = 40
    Top = 96
  end
  object FMentProdWs: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 136
    Top = 160
  end
  object FMentTvWs: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 128
    Top = 304
  end
  object FMentProd: TFDMemTable
    FieldDefs = <
      item
        Name = 'CODBARRA'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'DESCRICAO'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'VRVENDA'
        DataType = ftInteger
      end
      item
        Name = 'IDTV'
        DataType = ftInteger
      end
      item
        Name = 'IDR'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 1073741823
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 40
    Top = 160
  end
  object FMentTv: TFDMemTable
    FieldDefs = <
      item
        Name = 'IDTV'
        DataType = ftInteger
      end
      item
        Name = 'DESCRICAOTV'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'IPTV'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'IDR'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 1073741823
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 48
    Top = 304
  end
  object FMentConfig: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'IDTV'
        DataType = ftInteger
      end
      item
        Name = 'HOSTWS'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'PORTAWS'
        DataType = ftInteger
      end
      item
        Name = 'IDRESOLUCAO'
        DataType = ftInteger
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 1073741823
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 128
    Top = 32
    Content = {
      414442530F00FB1B6C020000FF00010001FF02FF0304001600000046004D0065
      006E00740043006F006E0066006900670005000A0000005400610062006C0065
      00060000000000070000080032000000090000FF0AFF0B040008000000490044
      005400560005000800000049004400540056000C00010000000E000D000F0001
      1000011100011200011300011400011500080000004900440054005600FEFF0B
      04000C00000048004F00530054005700530005000C00000048004F0053005400
      570053000C00020000000E0016001700640000000F0001100001110001120001
      13000114000115000C00000048004F005300540057005300180064000000FEFF
      0B04000E00000050004F005200540041005700530005000E00000050004F0052
      0054004100570053000C00030000000E000D000F000110000111000112000113
      000114000115000E00000050004F0052005400410057005300FEFF0B04001600
      0000490044005200450053004F004C005500430041004F000500160000004900
      44005200450053004F004C005500430041004F000C00040000000E000D000F00
      0110000111000112000113000114000115001600000049004400520045005300
      4F004C005500430041004F00FEFEFF19FEFF1AFEFF1BFF1C1D0000000000FF1E
      00000100000001000B0000003139322E3136382E312E340200901F0000FEFEFF
      1C1D0001000000FF1E000000000000FEFEFF1C1D0002000000FF1E0000000000
      00FEFEFF1C1D0003000000FF1E000000000000FEFEFF1C1D0004000000FF1E00
      0000000000FEFEFF1C1D0005000000FF1E000000000000FEFEFEFEFEFF1FFEFF
      20210006000000FF22FEFEFE0E004D0061006E0061006700650072001E005500
      7000640061007400650073005200650067006900730074007200790012005400
      610062006C0065004C006900730074000A005400610062006C00650008004E00
      61006D006500140053006F0075007200630065004E0061006D0065000A005400
      6100620049004400240045006E0066006F0072006300650043006F006E007300
      74007200610069006E00740073001E004D0069006E0069006D0075006D004300
      6100700061006300690074007900180043006800650063006B004E006F007400
      4E0075006C006C00140043006F006C0075006D006E004C006900730074000C00
      43006F006C0075006D006E00100053006F007500720063006500490044000E00
      6400740049006E00740033003200100044006100740061005400790070006500
      1400530065006100720063006800610062006C006500120041006C006C006F00
      77004E0075006C006C000800420061007300650014004F0041006C006C006F00
      77004E0075006C006C0012004F0049006E005500700064006100740065001000
      4F0049006E00570068006500720065001A004F0072006900670069006E004300
      6F006C004E0061006D00650018006400740041006E0073006900530074007200
      69006E0067000800530069007A006500140053006F0075007200630065005300
      69007A0065001C0043006F006E00730074007200610069006E0074004C006900
      73007400100056006900650077004C006900730074000E0052006F0077004C00
      690073007400060052006F0077000A0052006F0077004900440010004F007200
      6900670069006E0061006C001800520065006C006100740069006F006E004C00
      6900730074001C0055007000640061007400650073004A006F00750072006E00
      61006C001200530061007600650050006F0069006E0074000E00430068006100
      6E00670065007300}
  end
  object FQryResolucao: TFDQuery
    Connection = dmConectSQLlite.FDC_SQLlite
    SQL.Strings = (
      'select * from tab_Resolucao')
    Left = 216
    Top = 304
  end
  object Pingador: TIdIcmpClient
    Protocol = 1
    ProtocolIPv6 = 58
    IPVersion = Id_IPv4
    Left = 496
    Top = 24
  end
end
