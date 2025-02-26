unit dmMain;

interface

uses
  System.SysUtils, System.Classes, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope,json;

type
  TWeatherData = record
    Temp, WindSpeed, WindDirection, CloudCover : string;
    IsDay : boolean;
    Time : TDateTime;
  end;

  TdmMainf = class(TDataModule)
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
  private
    { Private declarations }
  public
    { Public declarations }
    function GetWeatherData(Alat,Along : string) : TWeatherData;
  end;

var
  dmMainf: TdmMainf;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

function TdmMainf.GetWeatherData(Alat, Along: string): TWeatherData;
var
  lJsArray : TJSONArray;
  lJsValue, lJsName : TJSONValue;
  lJsObj : TJSONObject;
begin
   try
    RESTClient.BaseURL := 'https://api.open-meteo.com/v1/forecast?latitude='+ Alat+ '&longitude='+ Along
          + '&current=temperature_2m,apparent_temperature,is_day,precipitation,rain,showers,cloud_cover,'
          + 'wind_speed_10m,wind_direction_10m&hourly=temperature_2m&daily=temperature_2m_max,sunrise,'
          + 'sunset,daylight_duration,rain_sum,wind_speed_10m_max&timezone=Asia%2FKolkata';

    RESTRequest.Execute;

    //Get response
    lJsValue := TJSONObject.ParseJSONValue(RESTResponse.Content);
    lJsObj := lJsValue as TJSONObject;
    Result.Temp := lJsObj.GetValue<string>('current'+'.'+'apparent_temperature') + '°C';
    Result.IsDay := lJsObj.GetValue<boolean>('current'+'.'+'is_day') ;
    Result.WindSpeed := lJsObj.GetValue<string>('current'+'.'+'wind_speed_10m') + 'km/h' ;
    Result.WindDirection := lJsObj.GetValue<string>('current'+'.'+'wind_direction_10m') + '°' ;
    Result.Time:= lJsObj.GetValue<TDateTime>('current'+'.'+'time') ;
    Result.CloudCover :=  lJsObj.GetValue<string>('current'+'.'+'cloud_cover') + '%' ;
   finally
      lJsValue.Free;
   end;

end;

end.
