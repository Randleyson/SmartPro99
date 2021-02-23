object DmTvs: TDmTvs
  OldCreateOrder = False
  Height = 208
  Width = 354
  object QryTvs: TFDQuery
    SQL.Strings = (
      'select idTv,Descricao from tvs')
    Left = 32
    Top = 24
  end
  object QryProdutoTv: TFDQuery
    SQL.Strings = (
      'select codbarra,descricao,coalesce(codtv,0) from produtos p'
      'left join tv_prod tp on tp.codproduto = p.codbarra'
      'where coalesce(codtv,-1) = :IDTV')
    Left = 208
    Top = 24
    ParamData = <
      item
        Name = 'IDTV'
        ParamType = ptInput
      end>
  end
  object QryProdutos: TFDQuery
    Left = 120
    Top = 24
  end
end
