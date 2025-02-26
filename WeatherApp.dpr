program WeatherApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {frmForecast},
  dmMain in 'dmMain.pas' {dmMainf: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.CreateForm(TdmMainf, dmMainf);
  Application.CreateForm(TfrmForecast, frmForecast);
  Application.Run;
end.
