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
    Caption = ' Source folder 
    TabOrder = 1
    object Label1: TLabel
      Left = 7
      Top = 16
      Width = 327
      Height = 13
      Caption = 
        'Pick a source folder, containing *.jpg files...'
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
    Caption = ' Destination folder '
    TabOrder = 2
    object Label2: TLabel
      Left = 7
      Top = 16
      Width = 375
      Height = 13
      Caption = 
        'Pick a destination folder, where converted *.gif and *.jpg files' +
        ' will be put:'
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
    Caption = ' Filename change '
    ItemIndex = 0
    Items.Strings = (
      'Correct filename automatically'
      'Ask user for a filename'
      'Do not change filenames')
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
    Caption = ' JPEG file quality '
    TabOrder = 6
    object Label3: TLabel
      Left = 7
      Top = 16
      Width = 164
      Height = 26
      AutoSize = False
      Caption = 'Quality-to-filesize ratio for created file'
      WordWrap = True
    end
    object seJPEGRatio: TRVSpinEdit
      Left = 8
      Top = 46
      Width = 56
      Height = 22
      Hint = 'JPEG quality#1 - lowest quality, smallest filesize, 100 - opposite'
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
    Caption = ' Files numbering '
    TabOrder = 7
    object Label4: TLabel
      Left = 8
      Top = 40
      Width = 91
      Height = 13
      Caption = 'Start from:'
    end
    object chbAddNumbers: TCheckBox
      Left = 8
      Top = 16
      Width = 126
      Height = 17
      Hint = ''
      Caption = 'Add number to each filename'
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
      Hint = 'Set number for first created filename'
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
    Caption = ' File rename rules '
    TabOrder = 5
    object Label5: TLabel
      Left = 8
      Top = 16
      Width = 184
      Height = 30
      AutoSize = False
      Caption = 'Click below button to set file rename rules:'
      WordWrap = True
    end
    object btnSetParameters: TButton
      Left = 102
      Top = 40
      Width = 92
      Height = 20
      Hint = ''
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
    Hint = ''
    Caption = 'Start!'
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
    Hint = ''
    Caption = 'About'
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
    Caption = ' Range of operations '
    TabOrder = 3
    object Label6: TLabel
      Left = 8
      Top = 40
      Width = 46
      Height = 13
      Caption = 'Dimensions:'
    end
    object Label7: TLabel
      Left = 216
      Top = 40
      Width = 46
      Height = 13
      Caption = 'Dimensions:'
    end
    object lblPixelMini: TLabel
      Left = 120
      Top = 40
      Width = 58
      Height = 13
      Caption = 'x 120 pixels'
    end
    object lblPixelMaxi: TLabel
      Left = 328
      Top = 40
      Width = 58
      Height = 13
      Caption = 'x 400 pixels'
    end
    object Label8: TLabel
      Left = 8
      Top = 64
      Width = 388
      Height = 28
      AutoSize = False
      Caption = 
        'None of the source files will be changed. All operations are per' +
        'formed only on newly created files, in destination folder. Amen!'
      WordWrap = True
    end
    object chbMini: TCheckBox
      Left = 8
      Top = 16
      Width = 129
      Height = 17
      Caption = 'Create miniature (*.gif)'
      TabOrder = 0
      OnClick = chbMiniClick
    end
    object chbMain: TCheckBox
      Left = 216
      Top = 16
      Width = 161
      Height = 17
      Caption = 'Change image size (*.jpg)'
      TabOrder = 2
      OnClick = chbMainClick
    end
    object rvsMiniSize: TRVSpinEdit
      Left = 60
      Top = 36
      Width = 56
      Height = 22
      Hint = 
        'Longer side of created destination file will have this size. Sho' +
        'rter side will be resized respecting original image ratio.'
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
        'Longer side of created destination file will have this size. Sho' +
        'rter side will be resized respecting original image ratio.'
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
    Title = 'Select a folder'
    Text = 'Pick a source folder:'
    Options = [bfFileSysDirsOnly, bfStatusText, bfShowPathInStatusArea, bfSyncCustomButton, bfAlignCustomButton, bfScreenCenter]
    RootFolder = sfoMyComputer
  end
  object fdDestination: TFolderDialog
    Top = 52
    Left = 44
    Title = 'Select a folder'
    Text = 'Pick a destination folder:'
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
