object PrincipalFrm: TPrincipalFrm
  Left = 0
  Top = 0
  Caption = 'Vendas'
  ClientHeight = 561
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object principalPgc: TPageControl
    Left = 0
    Top = 0
    Width = 784
    Height = 561
    ActivePage = vendasTS
    Align = alClient
    TabOrder = 0
    object vendasTS: TTabSheet
      Caption = 'Vendas'
      object vendasSplit: TSplitter
        Left = 0
        Top = 389
        Width = 776
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        Color = clGrayText
        ParentColor = False
        ExplicitLeft = -3
        ExplicitTop = 398
      end
      object vendasBtnsPnl: TPanel
        Left = 0
        Top = 0
        Width = 776
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 1
        BorderStyle = bsSingle
        Color = clBtnShadow
        Ctl3D = False
        ParentBackground = False
        ParentCtl3D = False
        TabOrder = 0
        object novaVendaBtn: TButton
          Left = 15
          Top = 9
          Width = 100
          Height = 25
          Caption = 'Nova'
          TabOrder = 0
          OnClick = novaVendaBtnClick
        end
        object editarBtn: TButton
          Left = 135
          Top = 9
          Width = 100
          Height = 25
          Caption = 'Editar'
          TabOrder = 1
          OnClick = editarBtnClick
        end
        object cancelarBtn: TButton
          Left = 255
          Top = 9
          Width = 100
          Height = 25
          Caption = 'Cancelar'
          TabOrder = 2
          OnClick = cancelarBtnClick
        end
      end
      object vendasDbGrid: TDBGrid
        Left = 0
        Top = 41
        Width = 776
        Height = 313
        Align = alClient
        DataSource = DM.listaVendasDS
        FixedColor = clWhite
        Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnCellClick = vendasDbGridCellClick
        OnDrawColumnCell = vendasDbGridDrawColumnCell
        OnDblClick = vendasDbGridDblClick
        Columns = <
          item
            Color = clCream
            Expanded = False
            FieldName = 'CODIGO'
            Title.Caption = 'C'#243'digo'
            Title.Color = clSkyBlue
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -13
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 100
            Visible = True
          end
          item
            Color = clCream
            Expanded = False
            FieldName = 'DATA'
            Title.Caption = 'Data'
            Title.Color = clSkyBlue
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -13
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 150
            Visible = True
          end
          item
            Color = clCream
            Expanded = False
            FieldName = 'VALOR_BRUTO'
            Title.Caption = 'Subtotal R$'
            Title.Color = clSkyBlue
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -13
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 120
            Visible = True
          end
          item
            Color = clCream
            Expanded = False
            FieldName = 'VALOR_DESCONTO'
            Title.Caption = 'Desconto R$'
            Title.Color = clSkyBlue
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -13
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 100
            Visible = True
          end
          item
            Color = clCream
            Expanded = False
            FieldName = 'VALOR_LIQUIDO'
            Title.Caption = 'Total R$'
            Title.Color = clSkyBlue
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -13
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 120
            Visible = True
          end
          item
            Color = clCream
            Expanded = False
            FieldName = 'CANCELADA'
            Title.Caption = 'Cancelada'
            Title.Color = clSkyBlue
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -13
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Visible = True
          end
          item
            Color = clCream
            Expanded = False
            FieldName = 'BtnExcluir'
            Title.Caption = '  '
            Width = 60
            Visible = True
          end>
      end
      object itensVendaDbGrid: TDBGrid
        Left = 0
        Top = 392
        Width = 776
        Height = 141
        Align = alBottom
        DataSource = DM.listaItemVendaSC
        Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Color = clCream
            Expanded = False
            FieldName = 'CODIGO_SEQUENCIAL'
            Title.Caption = 'C'#243'digo'
            Title.Color = clSkyBlue
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -13
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 100
            Visible = True
          end
          item
            Color = clCream
            Expanded = False
            FieldName = 'DESCRICAO'
            Title.Caption = 'Produto'
            Title.Color = clSkyBlue
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -13
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 250
            Visible = True
          end
          item
            Color = clCream
            Expanded = False
            FieldName = 'QTDE'
            Title.Caption = 'Quantidade'
            Title.Color = clSkyBlue
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -13
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 100
            Visible = True
          end
          item
            Color = clCream
            Expanded = False
            FieldName = 'VALOR'
            Title.Caption = 'Valor R$'
            Title.Color = clSkyBlue
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -13
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 120
            Visible = True
          end
          item
            Color = clCream
            Expanded = False
            FieldName = 'VALOR_SUBTOTAL'
            Title.Caption = 'Total R$'
            Title.Color = clSkyBlue
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -13
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 120
            Visible = True
          end>
      end
      object Panel1: TPanel
        Left = 0
        Top = 354
        Width = 776
        Height = 35
        Align = alBottom
        Alignment = taLeftJustify
        Caption = '  Itens'
        Color = clBtnShadow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 3
      end
    end
  end
end
