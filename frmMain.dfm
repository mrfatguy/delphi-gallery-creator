object MainForm: TMainForm
  Left = 195
  Top = 62
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'GalleryCreator 1.00'
  ClientHeight = 455
  ClientWidth = 420
  Color = clBtnFace
  Constraints.MinHeight = 380
  Constraints.MinWidth = 316
  Font.Charset = EASTEUROPE_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblStatus: TLabel
    Left = 8
    Top = 410
    Width = 404
    Height = 16
    AutoSize = False
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
  end
  object flb: TFileListBox
    Left = 280
    Top = 460
    Width = 145
    Height = 10
    FileType = [ftReadOnly, ftHidden, ftNormal]
    ItemHeight = 13
    Mask = '*.jpg'
    TabOrder = 0
  end
  object gbSource: TGroupBox
    Left = 8
    Top = 8
    Width = 404
    Height = 62
    Anchors = [akLeft, akTop, akRight]
    Caption = ' Folder zawieraj¹cy pliki Ÿród³owe '
    TabOrder = 1
    object Label1: TLabel
      Left = 7
      Top = 16
      Width = 327
      Height = 13
      Caption = 
        'Wska¿ folder Ÿród³owy, w którym znajduj¹ siê pliki graficzne (*.' +
        'jpg):'
      WordWrap = True
    end
    object eSourceFolder: TEdit
      Left = 7
      Top = 32
      Width = 366
      Height = 21
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btnGetSourceFolderName: TButton
      Left = 376
      Top = 33
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 1
      OnClick = btnGetSourceFolderNameClick
    end
  end
  object gbDestination: TGroupBox
    Left = 8
    Top = 72
    Width = 404
    Height = 62
    Anchors = [akLeft, akTop, akRight]
    Caption = ' Folder, w którym maj¹ byæ umieszczone pliki docelowe '
    TabOrder = 2
    object Label2: TLabel
      Left = 7
      Top = 16
      Width = 375
      Height = 13
      Caption = 
        'Wska¿ folder docelowy, w którym nale¿y umieœciæ pliki docelowe (' +
        '*.jpg i *.gif):'
      WordWrap = True
    end
    object eDestinationFolder: TEdit
      Left = 7
      Top = 32
      Width = 366
      Height = 21
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btnGetDestinationFolderName: TButton
      Left = 376
      Top = 33
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 1
      OnClick = btnGetDestinationFolderNameClick
    end
  end
  object rgNameChangeMode: TRadioGroup
    Left = 8
    Top = 234
    Width = 200
    Height = 76
    Caption = ' Zmiana nazwy '
    ItemIndex = 0
    Items.Strings = (
      'Automatyczna korekta nazwy pliku'
      'Wed³ug sugestii u¿ytkownika'
      'Brak korekty nazwy pliku')
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = rgNameChangeModeClick
  end
  object gbJPEGRatio: TGroupBox
    Left = 214
    Top = 234
    Width = 199
    Height = 76
    Caption = ' Jakoœæ pliku *.jpg '
    TabOrder = 6
    object Label3: TLabel
      Left = 7
      Top = 16
      Width = 164
      Height = 26
      AutoSize = False
      Caption = 'Stosunek jakoœci tworzonego pliku graficznego do jego rozmiaru:'
      WordWrap = True
    end
    object seJPEGRatio: TRVSpinEdit
      Left = 8
      Top = 46
      Width = 56
      Height = 22
      Hint = 
        'Jakoœæ JPEG#Okreœla stosunek jakoœci do rozmiaru tworzonego plik' +
        'u graficznego. Jakoœæ: 1 - najgorsza, 100 - najlepsza'
      Increment = 5
      MaxValue = 100
      MinValue = 1
      Value = 65
      AutoSize = False
      MaxLength = 3
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
  end
  object gbNumbering: TGroupBox
    Left = 214
    Top = 312
    Width = 199
    Height = 66
    Caption = ' Numeracja plików '
    TabOrder = 7
    object Label4: TLabel
      Left = 8
      Top = 40
      Width = 91
      Height = 13
      Caption = 'Zacznij od numeru:'
    end
    object chbAddNumbers: TCheckBox
      Left = 8
      Top = 16
      Width = 126
      Height = 17
      Hint = 
        'Numeracja plików#Okreœla, czy nazwy tworzonych plików oprócz zam' +
        'iany maj¹ byæ dodatkowo numerowane'
      Caption = 'Numeruj tworzone pliki'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 0
      OnClick = chbAddNumbersClick
    end
    object seFirstNumber: TRVSpinEdit
      Left = 107
      Top = 36
      Width = 86
      Height = 22
      Hint = 
        'Numer pierwszego pliku#Okreœl numer jaki zostanie nadany pierwsz' +
        'emu plikowi w grupie plików'
      Increment = 5
      MaxValue = 100000
      MinValue = 1
      Value = 1
      AutoSize = False
      MaxLength = 6
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
  end
  object gbNameChangeParams: TGroupBox
    Left = 8
    Top = 312
    Width = 200
    Height = 66
    Caption = ' Regu³y korekty nazwy '
    TabOrder = 5
    object Label5: TLabel
      Left = 8
      Top = 16
      Width = 184
      Height = 30
      AutoSize = False
      Caption = 'Aby zmieniæ regu³y korekty, kliknij po- ni¿szy klawisz:'
      WordWrap = True
    end
    object btnSetParameters: TButton
      Left = 102
      Top = 40
      Width = 92
      Height = 20
      Hint = 
        'Regu³y korekty#Kliknij, aby okreœliæ regu³y wed³ug których progr' +
        'am dokonuje automatycznej korekty nazwy'
      Caption = 'Regu³y korekty'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnSetParametersClick
    end
  end
  object btnGo: TButton
    Left = 289
    Top = 382
    Width = 124
    Height = 25
    Hint = 
      'Rozpocznij teraz!#Kliknij aby rozpocz¹æ automatyczn¹ zamianê pli' +
      'ków, z uwzglêdnieniem okreœlonych powy¿ej parametrów'
    Caption = 'Rozpocznij teraz!'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = btnGoClick
  end
  object pbProgress: TProgressBar
    Left = 8
    Top = 430
    Width = 404
    Height = 20
    Min = 1
    Max = 100
    Position = 1
    TabOrder = 10
  end
  object btnInfo: TButton
    Left = 8
    Top = 382
    Width = 124
    Height = 25
    Hint = 
      'O programie...#Kliknij, aby wyœwietliæ informacje o tym programi' +
      'e'
    Caption = 'O programie...'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = btnInfoClick
  end
  object gbRange: TGroupBox
    Left = 8
    Top = 136
    Width = 404
    Height = 97
    Caption = ' Zakres wykonywanych operacji '
    TabOrder = 3
    object Label6: TLabel
      Left = 8
      Top = 40
      Width = 46
      Height = 13
      Caption = 'Wymiary:'
    end
    object Label7: TLabel
      Left = 216
      Top = 40
      Width = 46
      Height = 13
      Caption = 'Wymiary:'
    end
    object lblPixelMini: TLabel
      Left = 120
      Top = 40
      Width = 58
      Height = 13
      Caption = 'x 120 pikseli'
    end
    object lblPixelMaxi: TLabel
      Left = 328
      Top = 40
      Width = 58
      Height = 13
      Caption = 'x 400 pikseli'
    end
    object Label8: TLabel
      Left = 8
      Top = 64
      Width = 388
      Height = 28
      AutoSize = False
      Caption = 
        '¯aden z plików Ÿród³owych nie zostanie zmieniony. Wszystkie oper' +
        'acjê s¹ wyko- nywane na nowych plikach, tworzonych we wskazanym ' +
        'folderze docelowym.'
      WordWrap = True
    end
    object chbMini: TCheckBox
      Left = 8
      Top = 16
      Width = 129
      Height = 17
      Caption = 'Twórz miniaturê (*.gif)'
      TabOrder = 0
      OnClick = chbMiniClick
    end
    object chbMain: TCheckBox
      Left = 216
      Top = 16
      Width = 161
      Height = 17
      Caption = 'Zmieñ rozmiar obrazka (*.jpg)'
      TabOrder = 2
      OnClick = chbMainClick
    end
    object rvsMiniSize: TRVSpinEdit
      Left = 60
      Top = 36
      Width = 56
      Height = 22
      Hint = 
        'Wymiary miniatury#D³u¿szy bok obrazu docelowego bêdzie mia³ ten ' +
        'wymiar, a bok krótszy zostanie zmniejszony z zachowaniem orygina' +
        'lnego stosunku wymiarów'
      Increment = 5
      MaxValue = 1000
      MinValue = 1
      Value = 120
      AutoSize = False
      MaxLength = 4
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnChange = rvsMiniSizeChange
    end
    object rvsMainSize: TRVSpinEdit
      Left = 268
      Top = 36
      Width = 56
      Height = 22
      Hint = 
        'Wymiary obrazka#D³u¿szy bok obrazu docelowego bêdzie mia³ ten wy' +
        'miar, a bok krótszy zostanie zmniejszony z zachowaniem oryginaln' +
        'ego stosunku wymiarów'
      Increment = 5
      MaxValue = 10000
      MinValue = 1
      Value = 400
      AutoSize = False
      MaxLength = 5
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnChange = rvsMainSizeChange
    end
  end
  object fdSource: TFolderDialog
    Top = 52
    Left = 12
    Title = 'Wska¿ folder'
    Text = 
      'Wska¿ folder Ÿród³owy, w którym znajduj¹ siê pliki graficzne (*.' +
      'jpg) przeznaczone do automatycznej redukcji wymiarów:'
    Options = [bfFileSysDirsOnly, bfStatusText, bfShowPathInStatusArea, bfSyncCustomButton, bfAlignCustomButton, bfScreenCenter]
    RootFolder = sfoMyComputer
  end
  object fdDestination: TFolderDialog
    Top = 52
    Left = 44
    Title = 'Wska¿ folder'
    Text = 
      'Wska¿ folder docelowy, w którym nale¿y umieœciæ pliki docelowe (' +
      '*.jpg i *.gif), po redukcji wymiarów:'
    Options = [bfFileSysDirsOnly, bfStatusText, bfShowPathInStatusArea, bfSyncCustomButton, bfAlignCustomButton, bfScreenCenter]
    RootFolder = sfoMyComputer
  end
  object FlatHint1: TFlatHint
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 112
    Top = 48
  end
  object ThemeManager1: TThemeManager
    Left = 80
    Top = 48
  end
end
