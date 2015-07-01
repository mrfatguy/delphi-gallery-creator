unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ThemeMgr, Buttons, TFlatHintUnit, ExtCtrls, ComCtrls,
  FoldrDlg, FileCtrl, Spin, RVSpinEdit;

type
  TMainForm = class(TForm)
    fdSource: TFolderDialog;
    fdDestination: TFolderDialog;
    flb: TFileListBox;
    FlatHint1: TFlatHint;
    ThemeManager1: TThemeManager;
    gbSource: TGroupBox;
    Label1: TLabel;
    eSourceFolder: TEdit;
    btnGetSourceFolderName: TButton;
    gbDestination: TGroupBox;
    Label2: TLabel;
    eDestinationFolder: TEdit;
    btnGetDestinationFolderName: TButton;
    rgNameChangeMode: TRadioGroup;
    gbJPEGRatio: TGroupBox;
    Label3: TLabel;
    seJPEGRatio: TRVSpinEdit;
    gbNumbering: TGroupBox;
    Label4: TLabel;
    chbAddNumbers: TCheckBox;
    seFirstNumber: TRVSpinEdit;
    gbNameChangeParams: TGroupBox;
    Label5: TLabel;
    btnSetParameters: TButton;
    btnGo: TButton;
    lblStatus: TLabel;
    pbProgress: TProgressBar;
    btnInfo: TButton;
    gbRange: TGroupBox;
    chbMini: TCheckBox;
    chbMain: TCheckBox;
    rvsMiniSize: TRVSpinEdit;
    Label6: TLabel;
    Label7: TLabel;
    rvsMainSize: TRVSpinEdit;
    lblPixelMini: TLabel;
    lblPixelMaxi: TLabel;
    Label8: TLabel;

    procedure AddLogInfo(Text: String);
    procedure PutPathToEdit(Control: TEdit; Path: String);

    procedure FormShow(Sender: TObject);
    procedure btnGetSourceFolderNameClick(Sender: TObject);
    procedure btnGetDestinationFolderNameClick(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
    procedure rgNameChangeModeClick(Sender: TObject);
    procedure btnSetParametersClick(Sender: TObject);
    procedure chbAddNumbersClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chbMiniClick(Sender: TObject);
    procedure chbMainClick(Sender: TObject);
    procedure rvsMiniSizeChange(Sender: TObject);
    procedure rvsMainSizeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses pasProcs, frmServerSettings, frmAskForFileName, frmInfo;

{$R *.DFM}
{$R WinXP.res}

procedure TMainForm.FormShow(Sender: TObject);
begin
        ReadSettings;
        
        flb.Directory:=eSourceFolder.Text;
        rgNameChangeModeClick(self);
end;

procedure TMainForm.AddLogInfo(Text: String);
begin
        lblStatus.Caption:=' '+Text;
        Application.ProcessMessages;
end;

procedure TMainForm.btnGetSourceFolderNameClick(Sender: TObject);
begin
        if fdSource.Execute then PutPathToEdit(eSourceFolder, IncludeTrailingBackslash(fdSource.Directory));
end;

procedure TMainForm.btnGetDestinationFolderNameClick(Sender: TObject);
begin
        if fdDestination.Execute then PutPathToEdit(eDestinationFolder, IncludeTrailingBackslash(fdDestination.Directory));
end;

procedure TMainForm.btnGoClick(Sender: TObject);
var
        iCount, iFirstNum, a, b: Integer;
        SearchRec: TSearchRec;
        cName, fName: String;
        WasOK: Boolean;
begin
        if (not chbMini.Checked) and (not chbMain.Checked) then
        begin
                Application.MessageBox('Zaznacz przynajmniej jedn¹ opcjê - tworzenie miniatury lub zmianê wymiarów obrazka.','Informacja...',MB_OK+MB_ICONINFORMATION+MB_DEFBUTTON1);
                exit;
        end;
        //Poprawka
        PutPathToEdit(eSourceFolder, IncludeTrailingBackslash(eSourceFolder.Text));
        PutPathToEdit(eDestinationFolder, IncludeTrailingBackslash(eDestinationFolder.Text));

        iCount:=0;

        //Sprawdzenie
        if not DirectoryExists(eSourceFolder.Text) then
        begin
                Application.MessageBox('Wskazany folder Ÿród³owy nie istnieje!','Ostrze¿enie!',MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
                exit;
        end;
        if not DirectoryExists(eDestinationFolder.Text) then
        begin
                if Application.MessageBox('Wskazany folder docelowy nie istnieje. Utworzyæ ???','Pytanie...',MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2)=ID_NO then exit;
                ForceDirectories(eDestinationFolder.Text);
        end;

        if CountFiles(eSourceFolder.Text,'*.jpg')<1 then
        begin
                Application.MessageBox('Wskazany folder Ÿród³owy nie zawiera ¿adnego pliku o rozszerzeniu *.jpg!','Ostrze¿enie!',MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
                exit;
        end;
        if CountFiles(eDestinationFolder.Text,'*.*')>0 then if Application.MessageBox(PChar('Wskazany folder docelowy zawiera pliki. Proces zamiany automatycznej wymaga, aby folder docelowy by³ pusty. Wszystkie pliki w folderze docelowym zostan¹ trwale usuniête!'+chr(13)+''+chr(13)+'Kontynuowaæ ???'),'Pytanie...',MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2)=ID_NO then exit;

        Screen.Cursor:=crHourglass;
        btnGo.Enabled:=False;

        a:=FindFirst(eDestinationFolder.Text+'*.*',faanyfile,SearchRec);
        while a=0 do
        begin
                if SearchRec.Name[1]<>'.' then DeleteFile(eDestinationFolder.Text+SearchRec.Name);
                a:=FindNext(SearchRec);
        end;
        FindClose(SearchRec);

        flb.Directory:=eSourceFolder.Text;
	pbProgress.Min:=0;
        pbProgress.Max:=flb.Items.Count;

        iFirstNum:=Trunc(seFirstNumber.Value);

        for b:=0 to flb.Items.Count-1 do
        begin
                //Nazwa pliku
                fName:=flb.Items.Strings[b];
                case rgNameChangeMode.ItemIndex of
                        0:
                        begin
                                cName:=ChangeFileName(fName);
                                if chbAddNumbers.Checked then cName:=AddNumbering(b+iFirstNum)+'_'+cName;
                        end;
                        1:
                        begin
                                AskForFileName.lblNum.Caption:=IntToStr(b+1)+ ' / ' + IntToStr(flb.Items.Count);
                                AskForFileName.lblPath.Caption:=eSourceFolder.Text;
                                AskForFileName.lblPath.Hint:='Œcie¿ka dostêpu:#'+eSourceFolder.Text;
                                AskForFileName.lblFileName.Caption:=fName;
                                if chbAddNumbers.Checked then AskForFileName.eNewName.Text:=AddNumbering(b+iFirstNum)+'_'+ChangeFileName(fName) else AskForFileName.eNewName.Text:=ChangeFileName(fName);
                                if AskForFileName.ShowModal=mrCancel then
                                begin
                                        pbProgress.Position:=1;
                                        AddLogInfo('Operacja zamiany zosta³a przerwana...');
                                        Screen.Cursor:=crDefault;
                                        btnGo.Enabled:=True;
                                        exit;
                                end;
                                cName:=AskForFileName.eNewName.Text;
                                if ExtractFileExt(cName)='' then cName:=cName+'.jpg';
                        end;
                        2:
                        begin
                                cName:=fName;
                                if chbAddNumbers.Checked then cName:=AddNumbering(b+iFirstNum)+'_'+cName;
                        end;
                end;

                //Zrob JPEG
                if chbMain.Checked then
                begin
                        WasOK:=JPEGToOptimizedJPEG(eSourceFolder.Text+fName,eDestinationFolder.Text+cName,Trunc(rvsMainSize.Value),Trunc(seJPEGRatio.Value));
                        if not WasOK then
                        begin
                                pbProgress.Position:=1;
                                AddLogInfo('Wyst¹pi³ b³¹d podczas operacji zamiany!');
                                Application.MessageBox('Wyst¹pi³ b³¹d podczas tej operacji!','Ostrze¿enie...',MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
                                Screen.Cursor:=crDefault;
                                btnGo.Enabled:=True;
                                exit;
                        end;
                        Inc(iCount);
                        AddLogInfo('Utworzono plik: '+cName);
                end;

                //Zrob GIF
                if chbMini.Checked then
                begin
                        cName:=Copy(cName,1,Length(cName)-Length(ExtractFileExt(cName)))+'.gif';
                        WasOK:=JPEGToOptimizedGIF(eSourceFolder.Text+fName,eDestinationFolder.Text+cName, Trunc(rvsMiniSize.Value));
                        if not WasOK then
                        begin
                                pbProgress.Position:=1;
                                AddLogInfo('Wyst¹pi³ b³¹d podczas operacji zamiany!');
                                        Application.MessageBox('Wyst¹pi³ b³¹d podczas tej operacji!','Ostrze¿enie...',MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
                                        btnGo.Enabled:=True;
                                        Screen.Cursor:=crDefault;
                                        exit;
                        end;
                        Inc(iCount);
                        AddLogInfo('Utworzono plik: '+cName);
                end;
                pbProgress.Position:=b;
        end;
        pbProgress.Position:=1;
        AddLogInfo('Liczba zamienionych plików graficznych: '+IntToStr(iCount));
        Screen.Cursor:=crDefault;
        btnGo.Enabled:=True;
end;

procedure TMainForm.PutPathToEdit(Control: TEdit; Path: String);
begin
        if DirectoryExists(Path) then
        begin
                (Control as TEdit).Text:=Path;
        end;
        if (Control as TEdit)=eSourceFolder then
        begin
                if DirectoryExists(Path) then
                begin
                        (Control as TEdit).Hint:='Wybrany katalog Ÿród³owy:#'+Path;
                        fdSource.Directory:=Path;
                end;
        end
        else
        begin
                if DirectoryExists(Path) then
                begin
                        (Control as TEdit).Hint:='Wybrany katalog docelowy:#'+Path;
                        fdDestination.Directory:=Path;
                end;
        end;
end;

procedure TMainForm.rgNameChangeModeClick(Sender: TObject);
begin
        case rgNameChangeMode.ItemIndex of
        0:
        begin
                btnSetParameters.Enabled:=True;
                chbAddNumbers.Enabled:=True;
                chbAddNumbersClick(self);
        end;
        1:
        begin
                btnSetParameters.Enabled:=False;
                chbAddNumbers.Enabled:=True;
                chbAddNumbersClick(self);
        end;
        2:
        begin
                btnSetParameters.Enabled:=False;
                chbAddNumbers.Enabled:=True;
                chbAddNumbersClick(self);
        end;
        end;
end;

procedure TMainForm.btnSetParametersClick(Sender: TObject);
begin
        ServerSettings.ShowModal;
end;

procedure TMainForm.chbAddNumbersClick(Sender: TObject);
begin
        seFirstNumber.Enabled:=chbAddNumbers.Checked;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
        Caption:='GalleryCreator '+KernelVersion;
        Application.Title:='GalleryCreator '+KernelVersion;
end;

procedure TMainForm.btnInfoClick(Sender: TObject);
begin
        Info.ShowModal;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
        WriteSettings;
end;

procedure TMainForm.chbMiniClick(Sender: TObject);
begin
        rvsMiniSize.Enabled:=chbMini.Checked;
end;

procedure TMainForm.chbMainClick(Sender: TObject);
begin
        rvsMainSize.Enabled:=chbMain.Checked;
end;

procedure TMainForm.rvsMiniSizeChange(Sender: TObject);
begin
        lblPixelMini.Caption:='x '+IntToStr(Trunc(rvsMiniSize.Value))+' pikseli';
end;

procedure TMainForm.rvsMainSizeChange(Sender: TObject);
begin
        lblPixelMaxi.Caption:='x '+IntToStr(Trunc(rvsMainSize.Value))+' pikseli';
end;

end.

