object DmVendas: TDmVendas
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 275
  Width = 359
  object FDQryTicketMedio: TFDQuery
    SQL.Strings = (
      
        'WITH TEMP AS                                                    ' +
        '                         '
      
        '    (                                                           ' +
        '                                      '
      
        '      SELECT                                                    ' +
        '                                      '
      
        '        IDEMPRESA,                                              ' +
        '                                      '
      
        '        TRUNC(DTVENDA) DTVENDA,                                 ' +
        '                                      '
      
        '        NROCUPOM,                                               ' +
        '                                      '
      
        '        SUM                                                     ' +
        '                                      '
      
        '        (                                                       ' +
        '                                      '
      
        '          CASE                                                  ' +
        '                                      '
      
        '            WHEN COALESCE(V.DESC_ACRE_MEDIO,0) > 0 THEN         ' +
        '                                      '
      
        '              (COALESCE(V.DESC_ACRE_MEDIO,0))                   ' +
        '                                      '
      
        '            ELSE                                                ' +
        '                                      '
      
        '              0                                                 ' +
        '                                      '
      
        '            END                                                 ' +
        '                                      '
      
        '            +                                                   ' +
        '                                      '
      
        '            CASE                                                ' +
        '                                      '
      
        '              WHEN COALESCE(V.DESC_ACRE_ITEM,0) > 0 THEN        ' +
        '                                      '
      
        '                (COALESCE(V.DESC_ACRE_ITEM,0))                  ' +
        '                                      '
      
        '              ELSE                                              ' +
        '                                      '
      
        '                0                                               ' +
        '                                      '
      
        '            END                                                 ' +
        '                                      '
      
        '        ) T_ACRESCIMO,                                          ' +
        '                                      '
      
        '        SUM                                                     ' +
        '                                      '
      
        '        (                                                       ' +
        '                                      '
      
        '          COALESCE(V.DESC_PROMOCAO,0)                           ' +
        '                                      '
      
        '          +                                                     ' +
        '                                      '
      
        '          COALESCE(V.DESC_DEPARTAMENTO,0)                       ' +
        '                                      '
      
        '          +                                                     ' +
        '                                      '
      
        '          (                                                     ' +
        '                                      '
      
        '            CASE                                                ' +
        '                                      '
      
        '              WHEN COALESCE(V.DESC_ACRE_MEDIO,0) < 0 THEN       ' +
        '                                      '
      
        '                (COALESCE(V.DESC_ACRE_MEDIO,0)*-1)              ' +
        '                                      '
      
        '              ELSE                                              ' +
        '                                      '
      
        '                0                                               ' +
        '                                      '
      
        '              END                                               ' +
        '                                      '
      
        '          )                                                     ' +
        '                                      '
      
        '          +                                                     ' +
        '                                      '
      
        '          (                                                     ' +
        '                                      '
      
        '            CASE                                                ' +
        '                                      '
      
        '              WHEN COALESCE(V.DESC_ACRE_ITEM,0) < 0 THEN        ' +
        '                                      '
      
        '                (COALESCE(V.DESC_ACRE_ITEM,0)*-1)               ' +
        '                                      '
      
        '              ELSE                                              ' +
        '                                      '
      
        '                0                                               ' +
        '                                      '
      
        '            END                                                 ' +
        '                                      '
      
        '          )                                                     ' +
        '                                      '
      
        '        )T_DESCONTO,                                            ' +
        '                                      '
      
        '        SUM                                                     ' +
        '                                      '
      
        '        (                                                       ' +
        '                                      '
      
        '          CASE                                                  ' +
        '                                      '
      
        '            WHEN V.IAT = '#39'A'#39' THEN                               ' +
        '                                    '
      
        '              CAST((V.QTDE * V.VRVENDA) AS NUMERIC(18,2))       ' +
        '                                      '
      
        '            ELSE                                                ' +
        '                                      '
      
        '              (CAST(TRUNC((V.QTDE * V.VRVENDA) * 100) AS NUMERIC' +
        '(18,2)) / 100)                        '
      
        '          END                                                   ' +
        '                                      '
      
        '        )                                                       ' +
        '                                      '
      
        '        T_TOTAL_VENDA,                                          ' +
        '                                      '
      
        '        SUM(QTDE)TOTAL_QTDE                                     ' +
        '                                      '
      
        '        FROM VENDAS V                                           ' +
        '                                      '
      
        '        WHERE                                                   ' +
        '                                      '
      
        '          V.CANCELADO = '#39'N'#39'                                     ' +
        '                                   '
      
        '        AND                                                     ' +
        '                                      '
      
        '          V.IDEMPRESA IN (:IDEMPRESA)                           ' +
        '                                 '
      '        AND TRUNC(DTVENDA) BETWEEN :DATA1  AND :DATA2 '
      
        '        GROUP BY  V.NROPEDIDO, V.NROCUPOM, TRUNC(DTVENDA), IDEMP' +
        'RESA                                 '
      
        '        ORDER BY  V.NROPEDIDO, V.NROCUPOM, TRUNC(DTVENDA), IDEMP' +
        'RESA                                  '
      
        '    )                                                           ' +
        '                                      '
      '    SELECT    '
      '      COUNT(NROCUPOM) QTDE_CUPONS , '
      
        '      CAST(SUM((T_TOTAL_VENDA + T_ACRESCIMO -   T_DESCONTO))  AS' +
        ' NUMERIC(18,2)) AS TOTAL_VENDA ,'
      
        '      ((CAST(SUM((T_TOTAL_VENDA + T_ACRESCIMO -   T_DESCONTO))  ' +
        'AS NUMERIC(18,2)) ) /'
      
        '        (COUNT(NROCUPOM))) MEDIA                                ' +
        '                                                                ' +
        '                                                              '
      
        '    FROM TEMP T                                                 ' +
        '                                      '
      
        '    LEFT JOIN EMPRESAS E ON E.CODEMPRESA = T.IDEMPRESA          ' +
        '                                                                ' +
        '                                 '
      '    ORDER BY IDEMPRESA,DTVENDA')
    Left = 56
    Top = 32
    ParamData = <
      item
        Name = 'IDEMPRESA'
        ParamType = ptInput
      end
      item
        Name = 'DATA1'
        ParamType = ptInput
      end
      item
        Name = 'DATA2'
        ParamType = ptInput
      end>
    object FDQryTicketMedioQTDE_CUPONS: TFMTBCDField
      FieldName = 'QTDE_CUPONS'
    end
    object FDQryTicketMedioTOTAL_VENDA: TFMTBCDField
      FieldName = 'TOTAL_VENDA'
      Size = 0
    end
    object FDQryTicketMedioMEDIA: TFMTBCDField
      FieldName = 'MEDIA'
      Size = 0
    end
  end
end
