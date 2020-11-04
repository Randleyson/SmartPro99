object ModelTvs: TModelTvs
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 324
  Width = 594
  object FQryTv: TFDQuery
    Connection = ModelConexao.FDC_Freeboard
    SQL.Strings = (
      'select * from tv')
    Left = 26
    Top = 264
  end
  object FMenTv: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'IDTV'
        Attributes = [faRequired]
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
    Left = 136
    Top = 264
    Content = {
      414442530F009A2481010000FF00010001FF02FF0304000C00000046004D0065
      006E005400760005000A0000005400610062006C006500060000000000070000
      080032000000090000FF0AFF0B04000800000049004400540056000500080000
      0049004400540056000C00010000000E000D000F000110000111000112000113
      00011400080000004900440054005600FEFF0B04001600000044004500530043
      0052004900430041004F00540056000500160000004400450053004300520049
      00430041004F00540056000C00020000000E0015001600640000000F00011700
      0110000118000111000112000114001600000044004500530043005200490043
      0041004F0054005600190064000000FEFF0B0400080000004900500054005600
      05000800000049005000540056000C00030000000E0015001600140000000F00
      0117000110000118000111000112000114000800000049005000540056001900
      14000000FEFEFF1AFEFF1BFEFF1CFEFEFEFF1DFEFF1E1F0009000000FF20FEFE
      FE0E004D0061006E0061006700650072001E0055007000640061007400650073
      005200650067006900730074007200790012005400610062006C0065004C0069
      00730074000A005400610062006C00650008004E0061006D006500140053006F
      0075007200630065004E0061006D0065000A0054006100620049004400240045
      006E0066006F0072006300650043006F006E00730074007200610069006E0074
      0073001E004D0069006E0069006D0075006D0043006100700061006300690074
      007900180043006800650063006B004E006F0074004E0075006C006C00140043
      006F006C0075006D006E004C006900730074000C0043006F006C0075006D006E
      00100053006F007500720063006500490044000E006400740049006E00740033
      0032001000440061007400610054007900700065001400530065006100720063
      006800610062006C0065000800420061007300650012004F0049006E00550070
      00640061007400650010004F0049006E00570068006500720065000C004F0049
      006E004B00650079001A004F0072006900670069006E0043006F006C004E0061
      006D00650018006400740041006E007300690053007400720069006E00670008
      00530069007A006500120041006C006C006F0077004E0075006C006C0014004F
      0041006C006C006F0077004E0075006C006C00140053006F0075007200630065
      00530069007A0065001C0043006F006E00730074007200610069006E0074004C
      00690073007400100056006900650077004C006900730074000E0052006F0077
      004C006900730074001800520065006C006100740069006F006E004C00690073
      0074001C0055007000640061007400650073004A006F00750072006E0061006C
      001200530061007600650050006F0069006E0074000E004300680061006E0067
      0065007300}
  end
  object FQryProdutos: TFDQuery
    Connection = ModelConexao.FDC_Freeboard
    Left = 32
    Top = 24
  end
  object FMentProdNaoTv: TFDMemTable
    FieldDefs = <
      item
        Name = 'CODBARRA'
        Attributes = [faRequired]
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
        DataType = ftFMTBcd
        Precision = 18
        Size = 2
      end
      item
        Name = 'DESCRICAOALTERADA'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'EXISTENOARQ'
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
    Top = 88
    object FMentProdNaoTvCODBARRA: TStringField
      FieldName = 'CODBARRA'
      Required = True
      Size = 15
    end
    object FMentProdNaoTvDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 200
    end
    object FMentProdNaoTvVRVENDA: TFMTBCDField
      FieldName = 'VRVENDA'
      Precision = 18
      Size = 2
    end
    object FMentProdNaoTvDESCRICAOALTERADA: TStringField
      FieldName = 'DESCRICAOALTERADA'
      Size = 200
    end
    object FMentProdNaoTvEXISTENOARQ: TStringField
      FieldName = 'EXISTENOARQ'
      FixedChar = True
      Size = 1
    end
  end
  object FMentProdNaTv: TFDMemTable
    FieldDefs = <
      item
        Name = 'CODBARRA'
        Attributes = [faRequired]
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
        DataType = ftFMTBcd
        Precision = 18
        Size = 2
      end
      item
        Name = 'DESCRICAOALTERADA'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'EXISTENOARQ'
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
    Left = 144
    Top = 88
    object FMentProdNaTvCODBARRA: TStringField
      FieldName = 'CODBARRA'
      Required = True
      Size = 15
    end
    object FMentProdNaTvDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 200
    end
    object FMentProdNaTvVRVENDA: TFMTBCDField
      FieldName = 'VRVENDA'
      Precision = 18
      Size = 2
    end
    object FMentProdNaTvDESCRICAOALTERADA: TStringField
      FieldName = 'DESCRICAOALTERADA'
      Size = 200
    end
    object FMentProdNaTvEXISTENOARQ: TStringField
      FieldName = 'EXISTENOARQ'
      FixedChar = True
      Size = 1
    end
  end
  object FMentTabProdTv: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'CODBARRA'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'IDTV'
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
    Left = 136
    Top = 168
    Content = {
      414442530F009A2421010000FF00010001FF02FF0304001600000046004D0065
      006E007400500072006F0064005400760005000A0000005400610062006C0065
      00060000000000070000080032000000090000FF0AFF0B04001000000043004F
      0044004200410052005200410005001000000043004F00440042004100520052
      0041000C00010000000E000D000F000F00000010000111000112000113000114
      000115000116001000000043004F0044004200410052005200410017000F0000
      00FEFF0B04000800000049004400540056000500080000004900440054005600
      0C00020000000E00180010000111000112000113000114000115000116000800
      00004900440054005600FEFEFF19FEFF1AFEFF1BFEFEFEFF1CFEFF1DFF1EFEFE
      FE0E004D0061006E0061006700650072001E0055007000640061007400650073
      005200650067006900730074007200790012005400610062006C0065004C0069
      00730074000A005400610062006C00650008004E0061006D006500140053006F
      0075007200630065004E0061006D0065000A0054006100620049004400240045
      006E0066006F0072006300650043006F006E00730074007200610069006E0074
      0073001E004D0069006E0069006D0075006D0043006100700061006300690074
      007900180043006800650063006B004E006F0074004E0075006C006C00140043
      006F006C0075006D006E004C006900730074000C0043006F006C0075006D006E
      00100053006F0075007200630065004900440018006400740041006E00730069
      0053007400720069006E00670010004400610074006100540079007000650008
      00530069007A0065001400530065006100720063006800610062006C00650012
      0041006C006C006F0077004E0075006C006C000800420061007300650014004F
      0041006C006C006F0077004E0075006C006C0012004F0049006E005500700064
      0061007400650010004F0049006E00570068006500720065001A004F00720069
      00670069006E0043006F006C004E0061006D006500140053006F007500720063
      006500530069007A0065000E006400740049006E007400330032001C0043006F
      006E00730074007200610069006E0074004C0069007300740010005600690065
      0077004C006900730074000E0052006F0077004C006900730074001800520065
      006C006100740069006F006E004C006900730074001C00550070006400610074
      00650073004A006F00750072006E0061006C000E004300680061006E00670065
      007300}
    object FMentTabProdTvCODBARRA: TStringField
      FieldName = 'CODBARRA'
      Origin = 'CODBARRA'
      Size = 15
    end
    object FMentTabProdTvIDTV: TIntegerField
      FieldName = 'IDTV'
      Origin = 'IDTV'
    end
  end
  object FQryTabProdTv: TFDQuery
    Connection = ModelConexao.FDC_Freeboard
    SQL.Strings = (
      'select * from tv_prod')
    Left = 40
    Top = 168
  end
end
