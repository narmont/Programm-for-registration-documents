object Form2: TForm2
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103' '#1088#1072#1089#1096#1080#1074#1082#1080
  ClientHeight = 306
  ClientWidth = 685
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefaultSizeOnly
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 32
    Width = 169
    Height = 35
    Caption = #1043#1088#1091#1087#1087#1080#1088#1086#1074#1082#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 0
    Top = 293
    Width = 685
    Height = 13
    Align = alBottom
    ExplicitWidth = 3
  end
  object Edit1: TEdit
    Left = 24
    Top = 88
    Width = 209
    Height = 31
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnKeyPress = Edit1KeyPress
  end
  object Memo1: TMemo
    Left = 267
    Top = 3
    Width = 416
    Height = 286
    Align = alCustom
    PopupMenu = PopupMenu1
    ReadOnly = True
    TabOrder = 1
    OnClick = Memo1Click
  end
  object ADOConnection2: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=TeestDB.mdf;Data Source=NARMONT;Use Pro' +
      'cedure for Prepare=1;Auto Translate=True;Packet Size=4096;Workst' +
      'ation ID=NARMONT;Use Encryption for Data=False;Tag with column c' +
      'ollation when possible=False'
    LoginPrompt = False
    Mode = cmShareDenyRead
    Provider = 'SQLOLEDB.1'
    Left = 48
    Top = 184
  end
  object DataSource2: TDataSource
    DataSet = ADOQuery2
    Left = 208
    Top = 216
  end
  object ADOQuery2: TADOQuery
    Active = True
    Connection = ADOConnection2
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM dbo.Rasshivka')
    Left = 136
    Top = 160
  end
  object PopupMenu1: TPopupMenu
    Left = 120
    Top = 240
    object N1: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = N1Click
    end
  end
end
