object DmFinanceiro: TDmFinanceiro
  Left = 0
  Top = 0
  ClientHeight = 257
  ClientWidth = 531
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object FQryDocFinanceiro: TFDQuery
    SQL.Strings = (
      'SELECT * FROM ('
      
        'SELECT cliente parceiro,valor, data_vencimento Dtvencimento, '#39'AR' +
        'ECEBER'#39' documento FROM get_rcb'
      
        'WHERE Trunc(data_vencimento) BETWEEN :DATA1 AND :DATA2          ' +
        '         '
      'AND idempresa IN (:IDEMPRESA)'
      ''
      'UNION '
      
        'SELECT operadora parceiro,valor, previsao_compensacao, '#39'CARTAO'#39' ' +
        'documento FROM get_cartao'
      
        'WHERE Trunc(previsao_compensacao) BETWEEN :DATA1 AND :DATA2     ' +
        '              '
      'AND codigo_empresa IN (:IDEMPRESA)'
      ''
      
        'UNION                                                           ' +
        '            '
      
        'SELECT cliente parceiro,valor, bom_para, '#39'CHEQUEPRE'#39' documento F' +
        'ROM get_cheque'
      
        'WHERE Trunc(bom_para) BETWEEN :DATA1 AND :DATA2                 ' +
        '  '
      'AND idempresa IN (:IDEMPRESA)  '
      ''
      'UNION'
      
        'SELECT fornecedor parceiro,valor, vencimento, '#39'APAGAR'#39' documento' +
        ' FROM get_apagar'
      
        'WHERE Trunc(vencimento) BETWEEN :DATA1 AND :DATA2               ' +
        '    '
      'AND idempresa IN (:IDEMPRESA)  '
      ''
      'UNION'
      
        'SELECT parceiro parceiro,valor,data_vencimento, '#39'CHEQUEPROP'#39' doc' +
        'umento FROM get_cheque_proprio'
      
        'WHERE Trunc(data_vencimento) BETWEEN :DATA1 AND :DATA2          ' +
        '         '
      'AND idempresa IN (:IDEMPRESA)'
      ')'
      '  '
      ''
      ''
      ''
      '                                   ')
    Left = 40
    Top = 24
    ParamData = <
      item
        Name = 'DATA1'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DATA2'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'IDEMPRESA'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object FQryDocFinanceiroVALOR: TFMTBCDField
      FieldName = 'VALOR'
    end
    object FQryDocFinanceiroPARCEIRO: TStringField
      FieldName = 'PARCEIRO'
    end
    object FQryDocFinanceiroDTVENCIMENTO: TDateTimeField
      FieldName = 'DTVENCIMENTO'
    end
    object FQryDocFinanceiroDOCUMENTO: TStringField
      FieldName = 'DOCUMENTO'
    end
  end
end
