object selFormaPagamentoFrm: TselFormaPagamentoFrm
  Left = 0
  Top = 0
  ClientHeight = 196
  ClientWidth = 193
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
  object formaPagamentoLbl: TLabel
    Left = 24
    Top = 16
    Width = 128
    Height = 16
    Caption = 'Forma de Pagamento:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object valorLbl: TLabel
    Left = 24
    Top = 80
    Width = 54
    Height = 16
    Caption = 'Valor: R$'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object formaPagamentoCb: TDBLookupComboBox
    Left = 24
    Top = 32
    Width = 145
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    KeyField = 'Codigo'
    ListField = 'Descricao'
    ListSource = DM.receitasDs
    ParentFont = False
    TabOrder = 0
  end
  object okBtn: TButton
    Left = 59
    Top = 152
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = okBtnClick
  end
  object valorEdt: TEdit
    Left = 24
    Top = 102
    Width = 145
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Text = '0,00'
    OnKeyPress = valorEdtKeyPress
  end
end
