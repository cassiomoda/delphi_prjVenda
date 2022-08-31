object DM: TDM
  OldCreateOrder = False
  Height = 401
  Width = 575
  object conn: TFDConnection
    Params.Strings = (
      'Database=C:\dev\delphi\prjVendas\DB\VENDAS.FDB'
      'DriverID=FB'
      'Password=Tigre401!'
      'User_Name=SYSDBA')
    Connected = True
    LoginPrompt = False
    Left = 16
    Top = 16
  end
  object vendaTR: TFDTransaction
    Connection = conn
    Left = 16
    Top = 80
  end
  object listaVendasQry: TFDQuery
    Connection = conn
    SQL.Strings = (
      'select * from VENDA'
      'order by DATA')
    Left = 88
    Top = 80
    object listaVendasQryCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object listaVendasQryDATA: TSQLTimeStampField
      FieldName = 'DATA'
      Origin = '"DATA"'
      Required = True
    end
    object listaVendasQryVALOR_BRUTO: TCurrencyField
      FieldName = 'VALOR_BRUTO'
      Origin = 'VALOR_BRUTO'
      Required = True
    end
    object listaVendasQryVALOR_DESCONTO: TCurrencyField
      FieldName = 'VALOR_DESCONTO'
      Origin = 'VALOR_DESCONTO'
    end
    object listaVendasQryVALOR_LIQUIDO: TCurrencyField
      FieldName = 'VALOR_LIQUIDO'
      Origin = 'VALOR_LIQUIDO'
      Required = True
    end
    object listaVendasQryCANCELADA: TStringField
      FieldName = 'CANCELADA'
      Origin = 'CANCELADA'
      Size = 1
    end
    object listaVendasQryBtnExcluir: TStringField
      FieldKind = fkCalculated
      FieldName = 'BtnExcluir'
      Size = 1
      Calculated = True
    end
  end
  object listaVendasDS: TDataSource
    DataSet = listaVendasQry
    OnDataChange = listaVendasDSDataChange
    Left = 88
    Top = 136
  end
  object vendaQry: TFDQuery
    CachedUpdates = True
    Connection = conn
    Transaction = vendaTR
    SQL.Strings = (
      'select * from VENDA where codigo = :codVenda')
    Left = 216
    Top = 80
    ParamData = <
      item
        Name = 'CODVENDA'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object vendaQryCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object vendaQryDATA: TSQLTimeStampField
      FieldName = 'DATA'
      Origin = '"DATA"'
      Required = True
      EditMask = '00/00/0000;1; '
    end
    object vendaQryVALOR_BRUTO: TCurrencyField
      FieldName = 'VALOR_BRUTO'
      Origin = 'VALOR_BRUTO'
      Required = True
    end
    object vendaQryVALOR_DESCONTO: TCurrencyField
      FieldName = 'VALOR_DESCONTO'
      Origin = 'VALOR_DESCONTO'
    end
    object vendaQryVALOR_LIQUIDO: TCurrencyField
      FieldName = 'VALOR_LIQUIDO'
      Origin = 'VALOR_LIQUIDO'
      Required = True
    end
    object vendaQryCANCELADA: TStringField
      FieldName = 'CANCELADA'
      Origin = 'CANCELADA'
      Size = 1
    end
  end
  object vendaDS: TDataSource
    DataSet = vendaQry
    Left = 216
    Top = 136
  end
  object itemVendaQry: TFDQuery
    CachedUpdates = True
    IndexFieldNames = 'CODIGO_SEQUENCIAL'
    Connection = conn
    Transaction = vendaTR
    SQL.Strings = (
      'select * from VENDAITEM where CODIGO_VENDA = :codVenda')
    Left = 264
    Top = 80
    ParamData = <
      item
        Name = 'CODVENDA'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object itemVendaQryCODIGO_SEQUENCIAL: TIntegerField
      FieldName = 'CODIGO_SEQUENCIAL'
      Origin = 'CODIGO_SEQUENCIAL'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object itemVendaQryCODIGO_VENDA: TIntegerField
      FieldName = 'CODIGO_VENDA'
      Origin = 'CODIGO_VENDA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object itemVendaQryCODIGO_PRODUTO: TIntegerField
      FieldName = 'CODIGO_PRODUTO'
      Origin = 'CODIGO_PRODUTO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object itemVendaQryVALOR: TCurrencyField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      Required = True
    end
    object itemVendaQryQTDE: TIntegerField
      FieldName = 'QTDE'
      Origin = 'QTDE'
      Required = True
    end
    object itemVendaQryVALOR_SUBTOTAL: TCurrencyField
      FieldName = 'VALOR_SUBTOTAL'
      Origin = 'VALOR_SUBTOTAL'
      Required = True
    end
    object itemVendaQryDESCRICAO: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'DESCRICAO'
      Size = 40
    end
    object itemVendaQryBtnExcluir: TStringField
      FieldKind = fkCalculated
      FieldName = 'BtnExcluir'
      Size = 1
      Calculated = True
    end
  end
  object itemVendaDS: TDataSource
    DataSet = itemVendaQry
    Left = 264
    Top = 136
  end
  object listaItemVendaQry: TFDQuery
    Connection = conn
    Transaction = vendaTR
    SQL.Strings = (
      'select VENDAITEM.*, CADPRODUTO.DESCRICAO '
      'from VENDAITEM '
      
        'inner join CADPRODUTO on CADPRODUTO.CODIGO = VENDAITEM.CODIGO_PR' +
        'ODUTO '
      'where CODIGO_VENDA = :codVenda')
    Left = 136
    Top = 80
    ParamData = <
      item
        Name = 'CODVENDA'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object listaItemVendaQryCODIGO_SEQUENCIAL: TIntegerField
      FieldName = 'CODIGO_SEQUENCIAL'
      Origin = 'CODIGO_SEQUENCIAL'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object listaItemVendaQryCODIGO_VENDA: TIntegerField
      FieldName = 'CODIGO_VENDA'
      Origin = 'CODIGO_VENDA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object listaItemVendaQryCODIGO_PRODUTO: TIntegerField
      FieldName = 'CODIGO_PRODUTO'
      Origin = 'CODIGO_PRODUTO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object listaItemVendaQryVALOR: TCurrencyField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      Required = True
    end
    object listaItemVendaQryQTDE: TIntegerField
      FieldName = 'QTDE'
      Origin = 'QTDE'
      Required = True
    end
    object listaItemVendaQryVALOR_SUBTOTAL: TCurrencyField
      FieldName = 'VALOR_SUBTOTAL'
      Origin = 'VALOR_SUBTOTAL'
      Required = True
    end
    object listaItemVendaQryDESCRICAO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 40
    end
  end
  object listaItemVendaSC: TDataSource
    DataSet = listaItemVendaQry
    Left = 136
    Top = 136
  end
  object descontoVendaQry: TFDQuery
    CachedUpdates = True
    Connection = conn
    Transaction = vendaTR
    SQL.Strings = (
      'select * from VENDADESCONTO where CODIGO_VENDA = :codVenda')
    Left = 312
    Top = 80
    ParamData = <
      item
        Name = 'CODVENDA'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object descontoVendaQryCODIGO_SEQUENCIAL: TIntegerField
      FieldName = 'CODIGO_SEQUENCIAL'
      Origin = 'CODIGO_SEQUENCIAL'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object descontoVendaQryCODIGO_VENDA: TIntegerField
      FieldName = 'CODIGO_VENDA'
      Origin = 'CODIGO_VENDA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object descontoVendaQryCODIGO_DESCONTO: TIntegerField
      FieldName = 'CODIGO_DESCONTO'
      Origin = 'CODIGO_DESCONTO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object descontoVendaQryDESCRICAO_DESCONTO: TStringField
      FieldName = 'DESCRICAO_DESCONTO'
      Origin = 'DESCRICAO_DESCONTO'
      Required = True
      Size = 40
    end
    object descontoVendaQryVALOR_PERCENTUAL: TCurrencyField
      FieldName = 'VALOR_PERCENTUAL'
      Origin = 'VALOR_PERCENTUAL'
      Required = True
      currency = False
    end
    object descontoVendaQryBtnExcluir: TStringField
      FieldKind = fkCalculated
      FieldName = 'BtnExcluir'
      Size = 1
      Calculated = True
    end
  end
  object descontoVendaDS: TDataSource
    DataSet = descontoVendaQry
    Left = 312
    Top = 136
  end
  object receitaVendaQry: TFDQuery
    CachedUpdates = True
    Connection = conn
    Transaction = vendaTR
    SQL.Strings = (
      'select * from VENDARECEITA where CODIGO_VENDA = :codVenda')
    Left = 360
    Top = 80
    ParamData = <
      item
        Name = 'CODVENDA'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object receitaVendaQryCODIGO_SEQUENCIAL: TIntegerField
      FieldName = 'CODIGO_SEQUENCIAL'
      Origin = 'CODIGO_SEQUENCIAL'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object receitaVendaQryCODIGO_VENDA: TIntegerField
      FieldName = 'CODIGO_VENDA'
      Origin = 'CODIGO_VENDA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object receitaVendaQryCODIGO_RECEITA: TIntegerField
      FieldName = 'CODIGO_RECEITA'
      Origin = 'CODIGO_RECEITA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object receitaVendaQryDESCRICAO_RECEITA: TStringField
      FieldName = 'DESCRICAO_RECEITA'
      Origin = 'DESCRICAO_RECEITA'
      Required = True
      Size = 40
    end
    object receitaVendaQryVALOR: TCurrencyField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      Required = True
    end
    object receitaVendaQryBtnExcluir: TStringField
      FieldKind = fkCalculated
      FieldName = 'BtnExcluir'
      Size = 1
      Calculated = True
    end
  end
  object receitaVendaDS: TDataSource
    DataSet = receitaVendaQry
    Left = 360
    Top = 136
  end
  object auxiliarQry: TFDQuery
    Connection = conn
    Left = 88
    Top = 344
  end
  object listaProdutosQry: TFDQuery
    Connection = conn
    SQL.Strings = (
      'select CADPRODUTO.*, CADGRUPOPRODUTO.DESCRICAO as GRUPO  '
      'from CADPRODUTO '
      
        'inner join CADGRUPOPRODUTO on CADGRUPOPRODUTO.CODIGO = CADPRODUT' +
        'O.CODIGO_GRUPO '
      'order by CODIGO_GRUPO')
    Left = 88
    Top = 208
    object listaProdutosQryCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object listaProdutosQryDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 40
    end
    object listaProdutosQryCODIGO_GRUPO: TIntegerField
      FieldName = 'CODIGO_GRUPO'
      Origin = 'CODIGO_GRUPO'
      Required = True
    end
    object listaProdutosQryVALOR: TCurrencyField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      Required = True
    end
    object listaProdutosQryGRUPO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'GRUPO'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 40
    end
  end
  object listaProdutosDS: TDataSource
    DataSet = listaProdutosQry
    Left = 88
    Top = 264
  end
  object descontosCds: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 456
    Top = 80
    object descontosCdsCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object descontosCdsDescricao: TStringField
      FieldName = 'Descricao'
      Size = 40
    end
    object descontosCdsPercentual: TFloatField
      FieldName = 'Percentual'
    end
  end
  object descontosDs: TDataSource
    DataSet = descontosCds
    Left = 456
    Top = 136
  end
  object receitasCds: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 504
    Top = 80
    object receitasCdsCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object receitasCdsDescricao: TStringField
      FieldName = 'Descricao'
      Size = 40
    end
  end
  object receitasDs: TDataSource
    DataSet = receitasCds
    Left = 504
    Top = 136
  end
end
