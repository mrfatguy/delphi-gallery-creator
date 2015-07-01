unit pasProcs;

interface

uses
  Windows, SysUtils, Forms, Classes, Comctrls, Graphics,
  jpeg, Dialogs, GIFImage, Controls;

type
   ResizedDimensions = record
        nX, nY: Integer;
   end;

        procedure WriteSettings;
        procedure ReadSettings;

        function CountFiles(Directory, OfType: String): Integer;
        function RecalculateImageSize(CurrentX, CurrentY, DesiredX, DesiredY: Integer): ResizedDimensions;
        function AddNumbering(Number: Integer): String;
        function ChangeFileName(FileName: String): String;
        function JPEGToOptimizedJPEG(SourceFilePath, DestinationFilePath: String; ImageSize, JPEGRatio: Integer): Boolean;
        function JPEGToOptimizedGIF(SourceFilePath, DestinationFilePath: String; ImageSize: Integer): Boolean;

const
   KernelVersion: String = '1.00';

var
   ProgramPath: String;

implementation

uses frmServerSettings, frmMain;

function CountFiles(Directory, OfType: String): Integer;
var
        a,c: Integer;
        SearchRec: TSearchRec;
begin
        c:=0;
        a:=FindFirst(Directory+OfType,faanyfile,SearchRec);
        while a=0 do
        begin
                if SearchRec.Name[1]<>'.' then Inc(c);
                a:=FindNext(SearchRec);
        end;
        FindClose(SearchRec);
        Result:=c;
end;

function JPEGToOptimizedJPEG(SourceFilePath, DestinationFilePath: String; ImageSize, JPEGRatio: Integer): Boolean;
var
        sJPG, dJPG: TJPEGImage;
        tBMP: TBitmap;
        r: ResizedDimensions;
begin
        sJPG:=TJPEGImage.Create;
        dJPG:=TJPEGImage.Create;
        tBMP:=TBitmap.Create;

        sJPG.LoadFromFile(SourceFilePath);
        if (sJPG.Width<=ImageSize) and (sJPG.Height<=ImageSize) then
        begin
                CopyFile(PChar(SourceFilePath), PChar(DestinationFilePath), False);
                Result:=True;
        end
        else
        begin
                r:=RecalculateImageSize(sJPG.Width,sJPG.Height,ImageSize,ImageSize);
                tBMP.Width:=r.nX;
                tBMP.Height:=r.nY;
                tBMP.Canvas.StretchDraw(Rect(0,0,r.nX,r.nY),sJPG);
                dJPG.Assign(tBMP);
                dJPG.CompressionQuality:=JPEGRatio;
                dJPG.Compress;
                dJPG.SaveToFile(DestinationFilePath);
                Result:=True;
        end;
        tBMP.Free;
        sJPG.Free;
        dJPG.Free;
end;

function JPEGToOptimizedGIF(SourceFilePath, DestinationFilePath: String; ImageSize: Integer): Boolean;
var
        sJPG: TJPEGImage;
        tBMP: TBitmap;
        dGIF: TGIFImage;
        r: ResizedDimensions;
begin
        sJPG:=TJPEGImage.Create;
        dGIF:=TGIFImage.Create;
        tBMP:=TBitmap.Create;

        GIFImageDefaultColorReduction := rmQuantize;
        GIFImageDefaultDitherMode := dmFloydSteinberg;

        sJPG.LoadFromFile(SourceFilePath);
        if (sJPG.Width<=ImageSize) and (sJPG.Height<=ImageSize) then
        begin
                dGIF.Assign(sJPG);
                dGIF.Transparent:=False;
                dGIF.SaveToFile(DestinationFilePath);
                Result:=True;
        end
        else
        begin
                r:=RecalculateImageSize(sJPG.Width,sJPG.Height,ImageSize,ImageSize);
                tBMP.Width:=r.nX;
                tBMP.Height:=r.nY;
                tBMP.Canvas.StretchDraw(Rect(0,0,r.nX,r.nY),sJPG);
                dGIF.Assign(tBMP);
                dGIF.Transparent:=False;
                dGIF.SaveToFile(DestinationFilePath);
                Result:=True;
        end;
        tBMP.Free;
        sJPG.Free;
        dGIF.Free;
end;

function RecalculateImageSize(CurrentX, CurrentY, DesiredX, DesiredY: Integer): ResizedDimensions;
begin
        if CurrentX>CurrentY then
        begin
                Result.nX:=DesiredX;
                Result.nY:=Trunc(CurrentY / (CurrentX / DesiredX));
        end
        else
        begin
                Result.nX:=Trunc(CurrentX / (CurrentY / DesiredY));
                Result.nY:=DesiredY;
        end;
end;

function AddNumbering(Number: Integer): String;
begin
        if Number<10 then Result:='00'+IntToStr(Number);
        if (Number>=10) and (Number<100) then Result:='0'+IntToStr(Number);
        if Number>=100 then Result:=IntToStr(Number);
end;

function ChangeFileName(FileName: String): String;
var
        a: Integer;
        tExt: String;
begin
        tExt:=ExtractFileExt(FileName);
        FileName:=Copy(FileName,1,Length(FileName)-Length(tExt));
        FileName:=Trim(FileName);
        FileName:=LowerCase(FileName);

        for a:=1 to Length(FileName) do
        begin
                if FileName[a]='_' then FileName:=Copy(FileName,1,a-1)+' '+Copy(FileName,a+1,Length(FileName));
        end;

        case ServerSettings.rgWordSpace.ItemIndex of
                0:
                begin
                        if ServerSettings.chbFirstCapitalLetter.Checked then
                        begin
                                for a:=1 to Length(FileName) do
                                begin
                                        if FileName[a]=' ' then FileName:=Copy(FileName,1,a-1)+UpperCase(FileName[a+1])+Copy(FileName,a+2,Length(FileName));
                                end;
                        end
                        else
                        begin
                                for a:=1 to Length(FileName) do
                                begin
                                        if FileName[a]=' ' then FileName:=Copy(FileName,1,a-1)+Copy(FileName,a+1,Length(FileName));
                                end;
                        end;
                end;
                1:
                        if ServerSettings.chbFirstCapitalLetter.Checked then
                        begin
                                for a:=1 to Length(FileName) do
                                begin
                                        if FileName[a]=' ' then FileName:=Copy(FileName,1,a)+UpperCase(FileName[a+1])+Copy(FileName,a+2,Length(FileName));
                                end;
                        end;
                2:
                begin
                        if ServerSettings.chbFirstCapitalLetter.Checked then
                        begin
                                for a:=1 to Length(FileName) do
                                begin
                                        if FileName[a]=' ' then FileName:=Copy(FileName,1,a-1)+ServerSettings.eCharRepleace.Text+UpperCase(FileName[a+1])+Copy(FileName,a+2,Length(FileName));
                                end;
                        end
                        else
                        begin
                                for a:=1 to Length(FileName) do
                                begin
                                        if FileName[a]=' ' then FileName:=Copy(FileName,1,a-1)+ServerSettings.eCharRepleace.Text+Copy(FileName,a+1,Length(FileName));
                                end;
                        end;
                end;
        end;
        if ServerSettings.chbBreakSigns.Checked then for a:=1 to Length(FileName) do if FileName[a]='.' then FileName:=Copy(FileName,1,a-1)+Copy(FileName,a+1,Length(FileName));
        if ServerSettings.chbBreakSigns.Checked then for a:=1 to Length(FileName) do if FileName[a]=',' then FileName:=Copy(FileName,1,a-1)+Copy(FileName,a+1,Length(FileName));
        if ServerSettings.chbBreakSigns.Checked then for a:=1 to Length(FileName) do if FileName[a]='''' then FileName:=Copy(FileName,1,a-1)+Copy(FileName,a+1,Length(FileName));

        if ServerSettings.chbNationalLetters.Checked then for a:=1 to Length(FileName) do
        begin
                if FileName[a]='Í' then FileName[a]:=Char('e');
                if FileName[a]='Û' then FileName[a]:=Char('o');
                if FileName[a]='π' then FileName[a]:=Char('a');
                if FileName[a]='ú' then FileName[a]:=Char('s');
                if FileName[a]='≥' then FileName[a]:=Char('l');
                if FileName[a]='ø' then FileName[a]:=Char('z');
                if FileName[a]='ü' then FileName[a]:=Char('z');
                if FileName[a]='Ê' then FileName[a]:=Char('c');
                if FileName[a]='Ò' then FileName[a]:=Char('n');
                if FileName[a]=' ' then FileName[a]:=Char('E');
                if FileName[a]='”' then FileName[a]:=Char('O');
                if FileName[a]='•' then FileName[a]:=Char('A');
                if FileName[a]='å' then FileName[a]:=Char('S');
                if FileName[a]='£' then FileName[a]:=Char('L');
                if FileName[a]='Ø' then FileName[a]:=Char('Z');
                if FileName[a]='è' then FileName[a]:=Char('Z');
                if FileName[a]='∆' then FileName[a]:=Char('C');
                if FileName[a]='—' then FileName[a]:=Char('N');
        end;
        if ServerSettings.chbFirstCapitalLetter.Checked then FileName:=UpperCase(FileName[1])+Copy(FileName,2,Length(FileName));
        Result:=FileName+tExt;
end;

procedure ReadSettings;
var
        loader: TStringList;
begin
        ProgramPath:=ExtractFilePath(Application.ExeName);
        loader:=TStringList.Create;
        if not FileExists(ProgramPath+'Settings.dat') then
        begin
                loader.Free;
                WriteSettings;
                exit;
        end;
        loader.LoadFromFile(ProgramPath+'Settings.dat');

        ServerSettings.eCharRepleace.Text:=loader.Values['GS_CharRepleace'];
        ServerSettings.rgWordSpace.ItemIndex:=StrToIntDef(loader.Values['GS_WordSpace'],0);
        ServerSettings.chbNationalLetters.Checked:=(StrToIntDef(loader.Values['GS_NationalLetters'],0) = 1);
        ServerSettings.chbBreakSigns.Checked:=(StrToIntDef(loader.Values['GS_BreakSigns'],0) = 1);
        ServerSettings.chbFirstCapitalLetter.Checked:=(StrToIntDef(loader.Values['GS_FirstCapitalLetter'],0) = 1);

        MainForm.PutPathToEdit(MainForm.eSourceFolder, loader.Values['GASR_SourceFolder']);
        MainForm.PutPathToEdit(MainForm.eDestinationFolder, loader.Values['GASR_DestinationFolder']);
        MainForm.rgNameChangeMode.ItemIndex:=StrToIntDef(loader.Values['GASR_UseAutomation'],0);
        MainForm.seJPEGRatio.Value:=StrToIntDef(loader.Values['GASR_JPEGCompressionRatio'],65);
        MainForm.seFirstNumber.Value:=StrToIntDef(loader.Values['GASR_FirstBoon'],1000);
        MainForm.chbAddNumbers.Checked:=(StrToIntDef(loader.Values['GASR_AddNumbers'],0) = 1);
        MainForm.chbMini.Checked:=(StrToIntDef(loader.Values['GASR_MakeMini'],0) = 1);
        MainForm.chbMain.Checked:=(StrToIntDef(loader.Values['GASR_MakeMaxi'],0) = 1);
        MainForm.rvsMiniSize.Value:=StrToIntDef(loader.Values['GASR_MiniSize'],120);
        MainForm.rvsMainSize.Value:=StrToIntDef(loader.Values['GASR_MaxiSize'],400);
        MainForm.chbMiniClick(MainForm);
        MainForm.chbMainClick(MainForm);

        loader.Free;
end;

procedure WriteSettings;
var
        saver: TStringList;
begin
        saver:=TStringList.Create;
        saver.Clear;

        saver.Values['GS_CharRepleace']:=ServerSettings.eCharRepleace.Text;
        saver.Values['GS_WordSpace']:=IntToStr(ServerSettings.rgWordSpace.ItemIndex);
        saver.Values['GS_NationalLetters']:=IntToStr(Ord(ServerSettings.chbNationalLetters.Checked));
        saver.Values['GS_BreakSigns']:=IntToStr(Ord(ServerSettings.chbBreakSigns.Checked));
        saver.Values['GS_FirstCapitalLetter']:=IntToStr(Ord(ServerSettings.chbFirstCapitalLetter.Checked));

        saver.Values['GASR_SourceFolder']:=MainForm.eSourceFolder.Text;
        saver.Values['GASR_DestinationFolder']:=MainForm.eDestinationFolder.Text;
        saver.Values['GASR_UseAutomation']:=IntToStr(MainForm.rgNameChangeMode.ItemIndex);
        saver.Values['GASR_JPEGCompressionRatio']:=IntToStr(Trunc(MainForm.seJPEGRatio.Value));
        saver.Values['GASR_FirstBoon']:=IntToStr(Trunc(MainForm.seFirstNumber.Value));
        saver.Values['GASR_AddNumbers']:=IntToStr(Ord(MainForm.chbAddNumbers.Checked));
        saver.Values['GASR_MakeMini']:=IntToStr(Ord(MainForm.chbMini.Checked));
        saver.Values['GASR_MakeMaxi']:=IntToStr(Ord(MainForm.chbMain.Checked));
        saver.Values['GASR_MiniSize']:=IntToStr(Trunc(MainForm.rvsMiniSize.Value));
        saver.Values['GASR_MaxiSize']:=IntToStr(Trunc(MainForm.rvsMainSize.Value));

        saver.SaveToFile(ProgramPath+'Settings.dat');
        saver.Free;
end;

end.
