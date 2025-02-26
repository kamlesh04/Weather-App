unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, dmMain, JSON, FMX.Objects,  System.IOUtils, FMX.Ani;

type
  TfrmForecast = class(TForm)
    Header: TToolBar;
    Footer: TToolBar;
    lblHeader: TLabel;
    pnlMain: TPanel;
    recMain: TRectangle;
    imgDay: TImage;
    lblCloudCover: TLabel;
    lblTemp: TLabel;
    lblTime: TLabel;
    lblWindDire: TLabel;
    lblWindSpeed: TLabel;
    imgWindSpeed: TImage;
    imgWindDir: TImage;
    imgCloudCover: TImage;
    tmRefresh: TTimer;
    lblRefresh: TLabel;
    lblCount: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure tmRefreshTimer(Sender: TObject);
  private
    { Private declarations }
     FCountDown : integer;
    procedure GetWeatherData;
  public
    { Public declarations }
  end;

var
  frmForecast: TfrmForecast;

implementation

{$R *.fmx}

procedure TfrmForecast.FormCreate(Sender: TObject);
begin
  FCountDown := 30;
  GetWeatherData;
end;

procedure TfrmForecast.GetWeatherData;
var
  lWeatherData : TWeatherData;
  lBitmap : TBitmap;
  lFile : string;
begin
  //Set weather data to respective labels
  lWeatherData := dmMainf.GetWeatherData('15.2993','74.1240');
  lblTemp.Text := lWeatherData.Temp;
  lblWindSpeed.Text := lWeatherData.WindSpeed;
  lblTime.Text :=  FormatDateTime('dddd dd mmmm yyyy hh:mm',lWeatherData.Time);
  lblWindDire.Text := lWeatherData.WindDirection;
  lblCloudCover.Text := lWeatherData.CloudCover;

  lBitmap := TBitmap.Create;
  try
    //Check if day/night
    if lWeatherData.IsDay then
    begin
      lfile := TPath.Combine(ExpandFileName(ExtractFilePath(ParamStr(0))),'..\..\Images\day.jpg');
      lBitmap.LoadFromFile(lfile);
      imgDay.Bitmap := lBitmap;
    end
    else
    begin
      lfile := TPath.Combine(ExpandFileName(ExtractFilePath(ParamStr(0))),'..\..\Images\night.jpg');
      lBitmap.LoadFromFile(lfile);
      imgDay.Bitmap := lBitmap;
    end;

    //Set image cloud cover
    lfile := TPath.Combine(ExpandFileName(ExtractFilePath(ParamStr(0))),'..\..\Images\CloudCover.jpg');
    lBitmap.LoadFromFile(lfile);
    imgCloudCover.Bitmap := lBitmap;

    //Set image wind speed
    lfile := TPath.Combine(ExpandFileName(ExtractFilePath(ParamStr(0))),'..\..\Images\WindSpeed.jpg');
    lBitmap.LoadFromFile(lfile);
    imgWindSpeed.Bitmap := lBitmap;

    //Set image wind direction
    lfile := TPath.Combine(ExpandFileName(ExtractFilePath(ParamStr(0))),'..\..\Images\WindDir.png');
    lBitmap.LoadFromFile(lfile);
    imgWindDir.Bitmap := lBitmap;
  finally
    lBitmap.Free;
  end;
  tmRefresh.Enabled := true;
end;

procedure TfrmForecast.tmRefreshTimer(Sender: TObject);
begin
  lblCount.Text := FCountDown.ToString;
  FCountDown := FCountDown - 1;
  if FCountDown = 0 then
  begin
    tmRefresh.Enabled := false;
    GetWeatherData;
    FCountDown := 30;
  end;
end;

end.
