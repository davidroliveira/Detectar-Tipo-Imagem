object Form1: TForm1
  Left = 0
  Top = 0
  ActiveControl = Button1
  Caption = 'Form1'
  ClientHeight = 340
  ClientWidth = 606
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    606
    340)
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 311
    Top = 107
    Width = 106
    Height = 118
    Center = True
    Proportional = True
    Stretch = True
  end
  object Button1: TButton
    Left = 152
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 107
    Width = 297
    Height = 225
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object DBImage1: TDBImage
    Left = 423
    Top = 107
    Width = 170
    Height = 174
    DataField = 'IMAGEM'
    DataSource = DataSource1
    Proportional = True
    Stretch = True
    TabOrder = 2
  end
  object BtnJPG: TButton
    Left = 272
    Top = 8
    Width = 75
    Height = 25
    Caption = 'JPG'
    TabOrder = 3
    OnClick = BtnJPGClick
  end
  object BtnPNG: TButton
    Left = 272
    Top = 39
    Width = 75
    Height = 25
    Caption = 'PNG'
    TabOrder = 4
    OnClick = BtnPNGClick
  end
  object BtnBMP: TButton
    Left = 272
    Top = 70
    Width = 75
    Height = 25
    Caption = 'BMP'
    TabOrder = 5
    OnClick = BtnBMPClick
  end
  object FDMemTable1: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 432
    Top = 40
    object FDMemTable1IMAGEM: TBlobField
      FieldName = 'IMAGEM'
    end
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 504
    Top = 56
  end
end
