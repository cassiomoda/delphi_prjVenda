object selDescontoFrm: TselDescontoFrm
  Left = 0
  Top = 0
  Caption = 'selDescontoFrm'
  ClientHeight = 231
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object descontosDbGrid: TDBGrid
    Left = 0
    Top = 41
    Width = 505
    Height = 190
    Align = alClient
    DataSource = DM.descontosDs
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = descontosDbGridDblClick
    Columns = <
      item
        Color = clCream
        Expanded = False
        FieldName = 'Codigo'
        Title.Caption = 'C'#243'digo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end
      item
        Color = clCream
        Expanded = False
        FieldName = 'Descricao'
        Title.Caption = 'Descri'#231#227'o'
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
        FieldName = 'Percentual'
        Title.Caption = 'Percentual %'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 95
        Visible = True
      end>
  end
  object tituloPnl: TPanel
    Left = 0
    Top = 0
    Width = 505
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 1
    BorderStyle = bsSingle
    Color = clBtnShadow
    Ctl3D = False
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 1
    ExplicitLeft = -32
    ExplicitWidth = 537
  end
end
