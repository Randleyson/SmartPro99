object DmProduto: TDmProduto
  OldCreateOrder = False
  Height = 206
  Width = 292
  object FDQryProduto: TFDQuery
    SQL.Strings = (
      'SELECT idempresa'
      '       ,idproduto'
      '       ,codbarra'
      '       ,descricao'
      '       ,unidade'
      '       ,vrvenda'
      '       ,custorep'
      '       ,promocao'
      '       ,vrpromoca'
      '       ,ativo'
      '       ,estoque'
      'FROM  GET_GESTAOMOBILE_PRODUTO '
      'WHERE codbarra = :CODBARRA'
      'AND idempresa = :IDEMPRESA')
    Left = 48
    Top = 32
    ParamData = <
      item
        Name = 'CODBARRA'
        ParamType = ptInput
      end
      item
        Name = 'IDEMPRESA'
        ParamType = ptInput
      end>
  end
end
