program GalleryCreator;

uses
  Forms,
  frmMain in 'frmMain.pas' {MainForm},
  pasProcs in 'pasProcs.pas',
  frmServerSettings in 'frmServerSettings.pas' {ServerSettings},
  frmAskForFileName in 'frmAskForFileName.pas' {AskForFileName},
  frmInfo in 'frmInfo.pas' {Info};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'GalleryCreator 1.00';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TServerSettings, ServerSettings);
  Application.CreateForm(TAskForFileName, AskForFileName);
  Application.CreateForm(TInfo, Info);
  Application.Run;
end.
