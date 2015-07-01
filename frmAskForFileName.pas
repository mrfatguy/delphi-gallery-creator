unit frmAskForFileName;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  TAskForFileName = class(TForm)
    btnCancel: TBitBtn;
    gbOrgFileInfo: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblNum: TLabel;
    lblPath: TLabel;
    lblFileName: TLabel;
    gbNewName: TGroupBox;
    Label4: TLabel;
    eNewName: TEdit;
    btnOK: TBitBtn;
    Label5: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AskForFileName: TAskForFileName;

implementation

{$R *.DFM}

uses pasProcs;

procedure TAskForFileName.btnCancelClick(Sender: TObject);
begin
        Close;
end;

procedure TAskForFileName.FormShow(Sender: TObject);
begin
        eNewName.SetFocus;
        eNewName.SelectAll;
end;

end.
