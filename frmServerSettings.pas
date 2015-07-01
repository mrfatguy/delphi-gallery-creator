unit frmServerSettings;

interface

uses
    Windows, SysUtils, Forms, Classes, Controls, StdCtrls,
    Spin, ComCtrls, RVSpinEdit, ExtCtrls, Dialogs;

type
    TServerSettings = class(TForm)
    ButtonCancel: TButton;
    ButtonOK: TButton;
    rgWordSpace: TRadioGroup;
    chbNationalLetters: TCheckBox;
    chbBreakSigns: TCheckBox;
    chbFirstCapitalLetter: TCheckBox;
    Label10: TLabel;
    eCharRepleace: TEdit;
    procedure eCharRepleaceChange(Sender: TObject);
    procedure rgWordSpaceClick(Sender: TObject);
end;

var
	ServerSettings: TServerSettings;

implementation

uses pasProcs;

{$R *.DFM}

procedure TServerSettings.eCharRepleaceChange(Sender: TObject);
begin
        if Length(eCharRepleace.Text)=0 then
        begin
                rgWordSpace.ItemIndex:=0;
                exit;
        end
        else
                rgWordSpace.ItemIndex:=2;
        if eCharRepleace.Text[1] in ['/','\',':','*','?','"','<','>','|'] then
        begin
                eCharRepleace.Text:='';
                Application.MessageBox('An incorrect character! Filname cannot contain any of these characters: / \ : * ? " < > |','Warning...',MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
        end;
end;

procedure TServerSettings.rgWordSpaceClick(Sender: TObject);
begin
        if rgWordSpace.ItemIndex=2 then
        begin
                Label10.Enabled:=True;
                eCharRepleace.Enabled:=True;
        end
        else
        begin
                Label10.Enabled:=False;
                eCharRepleace.Enabled:=False;
        end;
end;

end.

