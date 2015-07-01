object AskForFileName: TAskForFileName
  Left = 192
  Top = 80
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Podaj now¹ nazwê pliku...'
  ClientHeight = 201
  ClientWidth = 474
  Color = clBtnFace
  Font.Charset = EASTEUROPE_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 8
    Top = 128
    Width = 460
    Height = 28
    AutoSize = False
    Caption = 
      'Podaj nazwê dla pliku *.jpg. W przypadku plików typu GIF zostani' +
      'e u¿yta ta sama nazwa, któr¹ podano - zmianie ulegnie tylko rozs' +
      'zerzenie tworzonego pliku.'
    WordWrap = True
  end
  object btnCancel: TBitBtn
    Left = 8
    Top = 168
    Width = 160
    Height = 25
    Caption = 'Przerwij proces'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 3
    Kind = bkCancel
  end
  object gbOrgFileInfo: TGroupBox
    Left = 8
    Top = 8
    Width = 460
    Height = 70
    Caption = ' Zamieniany plik '
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 90
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Plik nr:'
    end
    object Label2: TLabel
      Left = 8
      Top = 32
      Width = 90
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Œcie¿ka dostêpu:'
    end
    object Label3: TLabel
      Left = 8
      Top = 48
      Width = 90
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Oryginalna nazwa:'
    end
    object lblNum: TLabel
      Left = 102
      Top = 16
      Width = 352
      Height = 13
      AutoSize = False
      Caption = '0 z 0'
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnCancelClick
    end
    object lblPath: TLabel
      Left = 102
      Top = 32
      Width = 352
      Height = 13
      Hint = 'Œcie¿ka dostêpu:#C:\'
      AutoSize = False
      Caption = 'C:\'
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnCancelClick
    end
    object lblFileName: TLabel
      Left = 102
      Top = 48
      Width = 352
      Height = 13
      AutoSize = False
      Caption = 'NazwaPliku.jpg'
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnCancelClick
    end
  end
  object gbNewName: TGroupBox
    Left = 8
    Top = 80
    Width = 460
    Height = 41
    Caption = ' Zamieñ nazwê '
    TabOrder = 2
    object Label4: TLabel
      Left = 8
      Top = 18
      Width = 104
      Height = 13
      AutoSize = False
      Caption = 'Proponowana nazwa:'
    end
    object eNewName: TEdit
      Left = 114
      Top = 14
      Width = 335
      Height = 21
      TabOrder = 0
    end
  end
  object btnOK: TBitBtn
    Left = 308
    Top = 168
    Width = 160
    Height = 25
    Caption = 'Zmieñ nazwê i kontynuuj'
    Default = True
    ModalResult = 1
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
end
