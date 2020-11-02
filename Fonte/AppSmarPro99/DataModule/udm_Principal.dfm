object DmPrincipal: TDmPrincipal
  OldCreateOrder = False
  Height = 367
  Width = 579
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 488
    Top = 80
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 496
    Top = 152
  end
  object FQryTv: TFDQuery
    Connection = dmConectSQLlite.FDC_SQLlite
    SQL.Strings = (
      'select * from tab_tv')
    Left = 112
    Top = 24
  end
  object FQryTabConfig: TFDQuery
    Connection = dmConectSQLlite.FDC_SQLlite
    SQL.Strings = (
      'select *'
      'from tab_config')
    Left = 176
    Top = 24
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
    Left = 32
    Top = 24
  end
  object FMentProdWs: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 32
    Top = 152
  end
  object FMentTvWs: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 112
    Top = 152
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
        DataType = ftFloat
        Precision = 13
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
      end
      item
        Name = 'UNIDADE'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 2
      end
      item
        Name = 'PROMOCAO'
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
    Left = 32
    Top = 88
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
    Left = 112
    Top = 88
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
    Left = 176
    Top = 88
    Content = {
      414442530F00D72D6C020000FF00010001FF02FF0304001600000046004D0065
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
    Left = 264
    Top = 24
  end
  object Pingador: TIdIcmpClient
    Host = '192.168.1.4'
    Protocol = 1
    ProtocolIPv6 = 58
    IPVersion = Id_IPv4
    Left = 496
    Top = 24
  end
  object FQryOferta: TFDQuery
    Connection = dmConectSQLlite.FDC_SQLlite
    SQL.Strings = (
      'select codbarra,descricao,vrvenda,unidade,promocao'
      'from tab_produtos'
      'where promocao = '#39'S'#39)
    Left = 352
    Top = 24
  end
  object FDMenOferta: TFDMemTable
    Active = True
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
        DataType = ftFloat
        Precision = 13
      end
      item
        Name = 'UNIDADE'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 2
      end
      item
        Name = 'PROMOCAO'
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
    Left = 352
    Top = 88
    Content = {
      414442530F00D72D1E030000FF00010001FF02FF03040016000000460044004D
      0065006E004F006600650072007400610005000A0000005400610062006C0065
      00060000000000070000080032000000090000FF0AFF0B04001000000043004F
      0044004200410052005200410005001000000043004F00440042004100520052
      0041000C00010000000E000D000F000F00000010000111000112000113000114
      000115000116001000000043004F0044004200410052005200410017000F0000
      00FEFF0B040012000000440045005300430052004900430041004F0005001200
      0000440045005300430052004900430041004F000C00020000000E000D000F00
      C800000010000111000112000113000114000115000116001200000044004500
      5300430052004900430041004F001700C8000000FEFF0B04000E000000560052
      00560045004E004400410005000E00000056005200560045004E00440041000C
      00030000000E00180019000D0000001000011100011200011300011400011500
      0116000E00000056005200560045004E00440041001A000D000000FEFF0B0400
      0E00000055004E004900440041004400450005000E00000055004E0049004400
      4100440045000C00040000000E000D000F00020000001000011100011B000112
      000113000114000115000116000E00000055004E004900440041004400450017
      0002000000FEFF0B040010000000500052004F004D004F00430041004F000500
      10000000500052004F004D004F00430041004F000C00050000000E000D000F00
      010000001000011100011B000112000113000114000115000116001000000050
      0052004F004D004F00430041004F00170001000000FEFEFF1CFEFF1DFEFF1EFF
      1F200000000000FF2100000600000030303030303201000B00000050414F2046
      52414E43455302007B14AE47E1FA23400300020000004B4704000100000053FE
      FEFF1F200001000000FF21000006000000303030303034010013000000524F53
      5155494E484120444520515545494A4F02003D0AD7A370FD3940030002000000
      4B4704000100000053FEFEFEFEFEFF22FEFF23240004000000FF25FEFEFE0E00
      4D0061006E0061006700650072001E0055007000640061007400650073005200
      650067006900730074007200790012005400610062006C0065004C0069007300
      74000A005400610062006C00650008004E0061006D006500140053006F007500
      7200630065004E0061006D0065000A0054006100620049004400240045006E00
      66006F0072006300650043006F006E00730074007200610069006E0074007300
      1E004D0069006E0069006D0075006D0043006100700061006300690074007900
      180043006800650063006B004E006F0074004E0075006C006C00140043006F00
      6C0075006D006E004C006900730074000C0043006F006C0075006D006E001000
      53006F0075007200630065004900440018006400740041006E00730069005300
      7400720069006E00670010004400610074006100540079007000650008005300
      69007A0065001400530065006100720063006800610062006C00650012004100
      6C006C006F0077004E0075006C006C000800420061007300650014004F004100
      6C006C006F0077004E0075006C006C0012004F0049006E005500700064006100
      7400650010004F0049006E00570068006500720065001A004F00720069006700
      69006E0043006F006C004E0061006D006500140053006F007500720063006500
      530069007A00650010006400740044006F00750062006C006500120050007200
      650063006900730069006F006E001E0053006F00750072006300650050007200
      650063006900730069006F006E001000460069007800650064004C0065006E00
      1C0043006F006E00730074007200610069006E0074004C006900730074001000
      56006900650077004C006900730074000E0052006F0077004C00690073007400
      060052006F0077000A0052006F0077004900440010004F007200690067006900
      6E0061006C001800520065006C006100740069006F006E004C00690073007400
      1C0055007000640061007400650073004A006F00750072006E0061006C001200
      530061007600650050006F0069006E0074000E004300680061006E0067006500
      7300}
    object FDMenOfertaCODBARRA: TStringField
      DisplayWidth = 15
      FieldName = 'CODBARRA'
      Origin = 'CODBARRA'
      Size = 15
    end
    object FDMenOfertaDESCRICAO: TStringField
      DisplayWidth = 200
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 200
    end
    object FDMenOfertaVRVENDA: TFloatField
      DisplayWidth = 10
      FieldName = 'VRVENDA'
      Origin = 'VRVENDA'
    end
    object FDMenOfertaUNIDADE: TStringField
      DisplayWidth = 2
      FieldName = 'UNIDADE'
      Origin = 'UNIDADE'
      FixedChar = True
      Size = 2
    end
    object FDMenOfertaPROMOCAO: TStringField
      DisplayWidth = 1
      FieldName = 'PROMOCAO'
      Origin = 'PROMOCAO'
      FixedChar = True
      Size = 1
    end
  end
  object FMentResolucaoWs: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 264
    Top = 152
  end
end
